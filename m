Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280070AbRKEARO>; Sun, 4 Nov 2001 19:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280064AbRKEARF>; Sun, 4 Nov 2001 19:17:05 -0500
Received: from hermes.toad.net ([162.33.130.251]:34283 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280062AbRKEAQq>;
	Sun, 4 Nov 2001 19:16:46 -0500
Subject: Re: 2.4.12-ac3 floppy module requires 0x3f0-0x3f1 ioports
From: Thomas Hood <jdthood@mail.com>
To: Maciej Zenczykowski <maze@druid.if.uj.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111050050160.27009-200000@druid.if.uj.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0111050050160.27009-200000@druid.if.uj.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 04 Nov 2001 19:15:56 -0500
Message-Id: <1004919359.1318.63.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-04 at 19:00, Maciej Zenczykowski wrote:
> > A fix for this problem went in to 2.4.13-ac2.  Please
> > try that kernel (or a later -ac kernel) and report back.
> 
> Well just tried kernel 2.4.13-ac6 and there is absolutely no difference.
> 
> After applying the attached patch all works OK...
> 
> Maciej Zenczykowski
> 
> nb. modprobe rivafb leaves the kernel's idea of whats on screen out of
> sync with the truth.  i.e. modprobe rivafb on tty2 and you end up with
> tty1 on the screen, but keypresses going to tty2...

What I would like to know is: What is at 0x3f0-0x3f1 on
your machine, and why does your PnP BIOS list these
two ioports as used by "system peripheral: other"?

On my ThinkPad 600, the BIOS lists 0x3f0-0x3f5 as owned
by the floppy device:
jdthood@thanatos:~$ sudo lspnp -v 08
08 PNP0700 mass storage device: floppy
	irq 6
	io 0x03f0-0x03f5
	dma 2

It looks like there's a bug in your BIOS.  What we could do is
patch the PnP BIOS driver so that it refrains from reserving 
0x3f0-0x3f1.

I'll let others comment on the appropriateness of your patch
to floppy.c .  I don't know whether it's the right thing to
do or not.

--
Thomas Hood


