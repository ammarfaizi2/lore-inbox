Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUHEPn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUHEPn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 11:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUHEPnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 11:43:25 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:2278 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S267553AbUHEPnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 11:43:20 -0400
From: David Brownell <david-b@pacbell.net>
To: Michael Guterl <mguterl@gmail.com>
Subject: Re: [linux-usb-devel] Re: USB troubles in rc2
Date: Thu, 5 Aug 2004 08:34:27 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net,
       "Luis Miguel =?utf-8?q?Garc=FD?= Mancebo" <ktech@wanadoo.es>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
References: <200408022100.54850.ktech@wanadoo.es> <200408041820.50199.david-b@pacbell.net> <944a037704080420574bb181f8@mail.gmail.com>
In-Reply-To: <944a037704080420574bb181f8@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408050834.27452.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 August 2004 20:57, Michael Guterl wrote:

> Attached are my dmesg's from each kernel, each time I booted fully,
> then plugged the USB keyboard in, and then the USB mouse.  My kernel
> config is also attached, along with the output of lspci -v, (David
> Brownell mentioned "lspci -w" but this isn't a valid option, and I

Actually that was "-vv" (two v's, not double-v), but don't bother.

The dmesg output shows this is a HID failure.  It's likely connected
with some changes in the unlink logic, since that's what returns
the "-ENOENT" status.  The usb_kill_urb() changes added a new
URB state as I recall, maybe that's part of the issue here... since
that routine replaced the previous "synchronous unlink" logic.

- Dave

