Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbVBDVwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbVBDVwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 16:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbVBDVtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:49:04 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:2186 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264704AbVBDVby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:31:54 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] 2.6: USB disk unusable level of data corruption
Date: Fri, 4 Feb 2005 13:31:36 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
References: <Pine.LNX.4.44L0.0502041539350.674-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0502041539350.674-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041331.37042.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 12:55 pm, Alan Stern wrote:
> 
> The most likely explanation seems to be hardware problems.  Particularly
> for high-speed USB devices, 2.6 drives the hardware much closer to the
> limit than 2.4 or Windows (to judge by the problem reports we've seen).  

Agreed ... though limiting usb-storage I/O requests to 64 KB does tend to
mask that difference.  Some network adapters get better throughput than
Windows, too.  URB queueing does the trick ... not really usable on 2.4
kernels, but the costs on 2.6 seem substantially lower than on Windows.


> One case came up just a couple of days ago, in which this sort of data
> corruption was definitively traced to a known erratum in the peripheral's
> USB interface.  (The controller chip was an old revision which has been
> supplanted, but who knows what sort of hardware lurks in the hearts of
> commercial drives?)

If you're thinking of that net2280 issue, that erratum was specific
to full speed modes, and never appeared at high speed.  Also, that chip
wouldn't be used in mass market IDE adapters.  (Too pricey compared to
the custom chips that have no need for a CPU or PCI.)

But the point is good:  it's easy for hardware to have bugs there.

- Dave



