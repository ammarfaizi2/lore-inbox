Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTJDN5A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTJDN5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 09:57:00 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:63632 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262046AbTJDN46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 09:56:58 -0400
Date: Sat, 4 Oct 2003 15:56:47 +0200 (MEST)
Message-Id: <200310041356.h94Dul7T009782@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: davej@redhat.com, root@chaos.analogic.com
Subject: Re: FDC motor left on
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003 00:58:02 +0100, Dave Jones wrote:
>On Fri, Oct 03, 2003 at 01:25:30PM -0400, Richard B. Johnson wrote:
> > In linux-2.4.22 and earlier, if there is no FDC driver installed,
> > the FDC motor may continue to run after boot if the motor was
> > started as part of the BIOS boot sequence.
> > This patch turns OFF the motor once Linux gets control.
> > 
> > 
> > --- linux-2.4.22/arch/i386/boot/setup.S.orig	Fri Aug  2 20:39:42 2002
> > +++ linux-2.4.22/arch/i386/boot/setup.S	Fri Oct  3 11:50:43 2003
> > @@ -59,6 +59,8 @@
>
>Does this mean the 'kill_motor' function in bootsect.S isn't doing
>what it should be? If so, maybe that needs fixing instead of turning
>it off in two places ?

It's my understanding that bootsect.S:kill_motor is part of
the kernel's old builtin boot-from-floppy code, and that it
doesn't run when some other boot loader loaded the kernel.
(And it shouldn't have to.)

The workaround if you have a buggy BIOS or external loader
is to configure BLK_DEV_FD as a built-in. I do that anyway
for other reasons (to avoid an unresolved module autoloading
failure in some cases; it's in RH bugzilla somewhere).

/Mikael
