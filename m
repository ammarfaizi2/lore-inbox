Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTJFMkl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTJFMkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:40:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41090 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261882AbTJFMki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:40:38 -0400
Date: Mon, 6 Oct 2003 08:42:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dave Jones <davej@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <20031003235801.GA5183@redhat.com>
Message-ID: <Pine.LNX.4.53.0310060834180.8593@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos> <20031003235801.GA5183@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Oct 2003, Dave Jones wrote:

> On Fri, Oct 03, 2003 at 01:25:30PM -0400, Richard B. Johnson wrote:
>  > In linux-2.4.22 and earlier, if there is no FDC driver installed,
>  > the FDC motor may continue to run after boot if the motor was
>  > started as part of the BIOS boot sequence.
>  > This patch turns OFF the motor once Linux gets control.
>  >
>  >
>  > --- linux-2.4.22/arch/i386/boot/setup.S.orig	Fri Aug  2 20:39:42 2002
>  > +++ linux-2.4.22/arch/i386/boot/setup.S	Fri Oct  3 11:50:43 2003
>  > @@ -59,6 +59,8 @@
>
> Does this mean the 'kill_motor' function in bootsect.S isn't doing
> what it should be? If so, maybe that needs fixing instead of turning
> it off in two places ?
>
> 		Dave

Yes. I didn't even see that. The code there makes me kinda sick.
Anyway, the kill_motor function executes "reset diskette/disk" function
which will never turn OFF the drive. Instead, it will restart
the motor timer because, as a condition of reseting the diskette,
it must make sure the motor is running.

I suggest that the FDC control byte be read, then the result be
ANDed with ~0x10, then written back. The ifed-out code clears
the whole control word which is inappropriate at a time the
diskette channel may be still be active.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


