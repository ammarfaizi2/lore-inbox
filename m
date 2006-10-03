Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWJCUex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWJCUex (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 16:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWJCUex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 16:34:53 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42256 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030316AbWJCUex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 16:34:53 -0400
Date: Tue, 3 Oct 2006 16:34:51 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Paolo Ornati <ornati@fastwebnet.it>
cc: Arkadiusz =?UTF-8?B?SmHFgm93aWVj?= <ajalowiec@interia.pl>,
       <linux-kernel@vger.kernel.org>, <linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] PROBLEM: Kernel 2.6.x freeze
In-Reply-To: <20061003215200.0d1047db@localhost>
Message-ID: <Pine.LNX.4.44L0.0610031629310.5817-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006, Paolo Ornati wrote:

> The code dumped from memory matches the original one up to, and not
> including, the failing istruction. From that point the code is
> different.
> 
> 
> The failure is only a natural consequence of:
> 
> 	add    %ah,(%eax)
> 
> with "eax" pointing to 000f9edf, that belongs to the BIOS reserved
> memory region...
> 
> 
> The real problem is that the code starting from "0xcd0d18140" has been
> overwritten by something :(
> 
> 
> Another thing: both panics happened in interrupt context and both times
> uhci driver is involved.

I wonder whether the code in question was supposed to be running at all.  
Arkadiusz, what sort of USB devices do you have attached to the computer?

What does /proc/bus/usb/devices say (you may need to do "mount -t usbfs
none /proc/bus/usb" before you can see the file)?

> And this is the data that has overwritten the code:
> 
> 00 20 7b 0f 00 00 00 00 69 7f e0 ff 00 00 00 00 00 20 7b 0f 14
> ^^^^^^^^^^^                                     ^^^^^^^^^^^
> 
> 
> Maybe someone have an idea of where does this data come from?

In principle that data could be coming from anywhere.  It doesn't have to 
be related at all to uhci-hcd.

If you move the USB devices over to another Linux computer, does the new 
computer then have the same problem?

Alan Stern

