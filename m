Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJ1RKd>; Mon, 28 Oct 2002 12:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261384AbSJ1RKd>; Mon, 28 Oct 2002 12:10:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6455 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261381AbSJ1RKc>; Mon, 28 Oct 2002 12:10:32 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<3DBCEB2E.BC3956FD@daimi.au.dk> <m1hef7j7j1.fsf@frodo.biederman.org>
	<3DBCF9C5.DF3FF28D@daimi.au.dk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Oct 2002 10:14:45 -0700
In-Reply-To: <3DBCF9C5.DF3FF28D@daimi.au.dk>
Message-ID: <m18z0ijxiy.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:

> "Eric W. Biederman" wrote:
> > 
> > I believe it is inappropriate to assume the interrupt
> > controller is going to be used by dos when it is shut down.
> 
> If Linux was booted by LILO or SYSLINUX, there will be no DOS
> in memory. But the BIOS interrupt vector table and other data
> structures are in the first physical memory page which is not
> touched by Linux, so I'd expect the BIOS to be usable if we
> can just leave the hardware in a usable state. Booting to DOS
> from Linux might actually be possible.

I agree.  To rephrase I believe it is inappropriate to assume a
classic x86 PCBIOS is present on the machine.

All the shutdown routines should do is to place the hardware in a
quiescent state, that the linux driver init code can recover from.
Since arbitrary code can be loaded leaving this policy to the users of
the kexec system call is reasonable. 

> OTOH if Linux was booted by LOADLIN, there will have been a
> DOS in memory. DOS has changed interrupt vectors to point to
> DOS own code in segment 0x70, but that code will be outside
> the first physical page and will thus have been overwritten
> by Linux. In this case neither DOS nor BIOS routines can be
> used reliable. Any INT instruction can potentially crash,
> this lead to problems with kmonte, does kexec have the same
> problem?

The system call does not.  My user space component needs a bit more
work to bypass setup.S and do a reasonable job at it.  I have all of
the code in a tested state except the code that queries the current
kernel for the BIOS setup information.

Getting the last pieces together so I can reliably boot a linux kernel
is the next step.  My user space started out as a proof of concept and
is evolving into something useful from there.  I refuse to use the
hack of copying the empty_zero_page from the old kernel to the new
kernel. 

Eric
