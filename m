Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbTGDGwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 02:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTGDGwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 02:52:03 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:3086 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265804AbTGDGv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 02:51:57 -0400
Date: Fri, 4 Jul 2003 09:06:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Daniel Cavanagh <nofsk@vtown.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bsd disklabel and swap
Message-ID: <20030704070623.GA16445@win.tue.nl>
References: <3F04FFD0.2060404@vtown.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F04FFD0.2060404@vtown.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 02:17:20PM +1000, Daniel Cavanagh wrote:

> i'm having a problem with a bsd disklabel and swap.
> my /dev/hda disk look like this
> 
> partition 1: fat
> partition 2: ext2
> partition 3: openbsd
> 
> it is a standard bsd disklabel with a as root and b as swap. this means 
> that /dev/hda6 should be the swap partition. but "swapon /dev/hda6" 
> prints "swapon: /dev/hda6: Invalid argument". it also prints that for 
> any other valid partition. if i put this in /etc/fstab, on boot the 
> kernel will print "Unable to find swap-space signature" before swapon 
> prints the above message. but if i use /dev/hda3 instead, swapon will 
> accept it and add a 512Mb swap, which is the correct size. but it 
> appears that rather than writing at the start of the swap it starts 
> writing at the start of the openbsd partition so my root partition is 
> being corrupted. have i screwed or have you guys screwed up?

This sounds like user confusion.

A partition becomes a Linux swap partition by writing "SWAPSPACE" somewhere
at the beginning. (Yes, I know the details, don't tell me.)
If this signature is missing, the kernel refuses to swap to
the partition, in order to protect your data in case of a typo
in the swapon command.
The signature is written by the mkswap(8) command. Use it.

Andries

