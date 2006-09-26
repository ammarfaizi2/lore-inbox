Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWIZR4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWIZR4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWIZRzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:55:51 -0400
Received: from mail-gw3.sa.ew.hu ([212.108.200.82]:5761 "EHLO
	mail-gw3.sa.ew.hu") by vger.kernel.org with ESMTP id S932223AbWIZRzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:55:21 -0400
To: pavel@ucw.cz
CC: nigelenki@comcast.net, linux-kernel@vger.kernel.org
In-reply-to: <20060925220426.GA2546@elf.ucw.cz> (message from Pavel Machek on
	Tue, 26 Sep 2006 00:04:26 +0200)
Subject: Re: Swap on Fuse deadlocks?
References: <45184D88.1010203@comcast.net> <20060925220426.GA2546@elf.ucw.cz>
Message-Id: <E1GSH8h-0001kZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 Sep 2006 19:54:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just tried to set up an LZOlayer swap partition:
> > 
> > http://north.one.pl/~kazik/pub/LZOlayer/
> > 
> > The layout was as such:
> > 
> > /tmp/swap_base  - tmpfs (run1), disk (run2)
> > /tmp/swap - lzolayer swap_base
> > /tmp/swap/swap0 - 200M swap file
> > /dev/loop0 - /tmp/swap/swap0 loopback
> > 
> > I turned on loop0, crept anywhere over 10 megs into swap and it seized
> > up (otherwise it was fine).  This happened in both run1 (swap on tmpfs)
> > and run2 (swap on disk).
> > 
> > The swap on tmpfs I can understand; it'll essentially loop trying to
> > allocate new swap, swap in and out parts of the swap file to itself, and
> > eventually hit a condition where it's trying to swap an area of the swap
> > file into itself, creating an infinite loop.
> > 
> > Swap on disk I don't get.  A little slow perhaps due to the LZO or zlib
> > compression in the middle (lzolayer lets you pick either); but a total
> > freeze?  What's wrong here, is lzo_fs data getting swapped out and then
> > not swapped in because it's needed to decompress itself?
> 
> Yes, possibly. Or maybe lzo_fs needs  to allocate memory and kernel
> decides it needs to swap for that?
> 
> It is miracle that fuse works for normal write, do not expect it to
> work for swap. (Does it even work mmap-ed writes?)

No.  Though with the dirty page accounting and callback in 2.6.18 it
would be possible to add writable mmap support.

This is next on my todo list once fuse-2.6.0 is out and I have a
little spare time.

Miklos
