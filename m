Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWFTOXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWFTOXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWFTOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:23:04 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:15123 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751080AbWFTOXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:23:01 -0400
Date: Tue, 20 Jun 2006 10:22:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: andi@lisas.de
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       <hal@lists.freedesktop.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <20060620090532.GA6170@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.44L0.0606201017030.6455-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Andreas Mohr wrote:

> But how would HAL safely determine whether a (IDE/USB) drive is busy?
> As my test app demonstrates (without HAL running), the *very first* open()
> happening during an ongoing burning operation will kill it instantly, in the
> USB case.
> Are there any options left for HAL at all? Still seems to strongly point
> towards a kernel issue so far.
> 
> One (rather less desireable) way I can make up might be to have HAL
> keep the device open permanently and do an ioctl query on whether it's "busy"
> and then quickly close the device again before the newly started
> burning process gets disrupted (if this even properly works at all).

The open() call is not in itself the problem.

I would guess that the problem is sparked by the TEST UNIT READY command
automatically sent when the device file is opened.  Although a drive
should have no difficulty handling this command while carrying out a burn,
apparently yours aborts.  In other words, this is likely to be a firmware 
problem in the CD drive.

I can't tell what's going on with the USB HDD since you haven't provided 
any information.

If you want to find out what's actually happening instead of just 
guessing, turn on CONFIG_USB_STORAGE_DEBUG and see what the kernel log has 
to say for the time when the underrun/reset occurs.

Alan Stern

