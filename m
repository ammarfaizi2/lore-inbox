Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSEVWqZ>; Wed, 22 May 2002 18:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSEVWqZ>; Wed, 22 May 2002 18:46:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:5831 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315445AbSEVWqX>;
	Wed, 22 May 2002 18:46:23 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 23 May 2002 00:46:23 +0200 (MEST)
Message-Id: <UTC200205222246.g4MMkNL26024.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/port
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody: if you've ever used /dev/ports, holler _now_.

Holler.


In my eyes /dev/port is a rather unimportant corner
of the kernel. Removing it does not streamline anything,
we hear that it saves 454 bytes. A worthy goal, but..

Today a few things use /dev/port. Some low level mouse,
keyboard and console utilities. kbdrate. hwclock.

Is it needed? Hardly - most uses can be replaced by inb()
and outb(). But I am not sure why that would be better.
And I seem to recall that hwclock on some flavours of Alpha
really needed the /dev/port way. But I may be mistaken.


I have also seen systems that used /dev/port as
the implementation of inb() and and outb():
 outb(int p, char v) { lseek(fd,p,0); write(fd,&v,1); }
That way one could access keyboard, sound, rtc etc
while the underlying hardware was rather different from i86.


A further advantage of having /dev/port is that it allows one
to set keyboard or mouse or whatever properties from anything
that is able to access a file. But outb() or ioctl() probably
require something close to a C environment.
Probably this is what Alan is saying.


It is rather unimportant, but there are a few uses, and removing it
does not really have any positive effect. Quickly the 454 bytes
won will be lost again to the new ioctls, and to the filesystem
that Al develops to set the border colour of the monitor screen
and become a bleeding edge developer too.


Andries

