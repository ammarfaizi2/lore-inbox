Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUG0Mx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUG0Mx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 08:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUG0Mx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 08:53:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:13293 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265198AbUG0MxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 08:53:24 -0400
Date: Tue, 27 Jul 2004 07:53:04 -0500
From: Robin Holt <holt@sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Marcin Owsiany <marcin@owsiany.pl>, linux-kernel@vger.kernel.org
Subject: Re: "swap_free: Unused swap offset entry 00000100" but no crash?
Message-ID: <20040727125304.GA1411@lnx-holt.americas.sgi.com>
References: <20040727002154.GA21628@melina.ds14.agh.edu.pl> <3808.1090931402@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3808.1090931402@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 10:30:02PM +1000, Keith Owens wrote:
> On Tue, 27 Jul 2004 02:21:54 +0200, 
> Marcin Owsiany <marcin@owsiany.pl> wrote:
> >    kernel: swap_free: Unused swap offset entry 00000100
> >Also, I would be grateful if someone could explain what is that number in the
> >message supposed to be? An address?
> 
> It is a swap partition number, but I doubt that you have 256 swap
> partitions in your system.  Single bit set in a word that is meant to
> be 0, most likely to be caused by a hardware single bit error.  Run
> memtest, burn86 or other memory verification checks.
> 

I remember a race condition I thought was possible, but couldn't exactly
pin down the exact sequence.  Give me a chance to dig through some of
my notes and see what I come across.

I think I could understand this if there two messages with each invocation,
but not with one.

Marcin, you have a process with a Page Table Entry which indicates it is
pointing to a page which has been swapped out to block 0 of swap device
256.  This is probably caused by a problem in the kernel.  You can certainly
run memtest et al.  If you don't find anything, I would assume the problem
is in the kernel.

Most of the code in the area you would be affected by has changed
drastically in the 2.6 kernel.

Good Luck,
Robin Holt
