Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279982AbRKLREZ>; Mon, 12 Nov 2001 12:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRKLREQ>; Mon, 12 Nov 2001 12:04:16 -0500
Received: from [195.63.194.11] ([195.63.194.11]:53767 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S279982AbRKLREF>; Mon, 12 Nov 2001 12:04:05 -0500
Message-ID: <3BF00D59.5558ADA4@evision-ventures.com>
Date: Mon, 12 Nov 2001 18:56:41 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: dalecki@evision.ag, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.14 mregparm=3 compilation fixes
In-Reply-To: <4300.1005581402@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 12 Nov 2001 12:28:33 +0100,
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> >diff -ur linux-2.4.14-2/arch/i386/Makefile linux-mdcki/arch/i386/Makefile
> >--- linux-2.4.14-2/arch/i386/Makefile  Thu Apr 12 21:20:31 2001
> >+++ linux-mdcki/arch/i386/Makefile     Sat Nov 10 00:07:17 2001
> >@@ -21,7 +21,7 @@
> > LDFLAGS=-e stext
> > LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
> >
> >-CFLAGS += -pipe
> >+CFLAGS += -freg-struct-return -mregparm=3
> >
> > # prevent gcc from keeping the stack 16 byte aligned
> > CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)
> 
> Setting mregparm must be a CONFIG_ option, with a huge warning that
> 
> A) Changing CONFIG_MREGPARM requires make mrproper.
> 
> B) Loading binary only modules into a kernel compiled with mregparm is
>    even more likely to destroy your kernel.

Ehmm... In fact my feelings about this are that _this part_ of the
patch _should not_ be included in the mainstream kernel at all. It
should may be made just the default (in 2.5 perhaps)
if it turns out that the performance code size and so on gains are worth 
it, since I didn't encounter any problems thus far even with a "distro
RPM grade
kernel" containing USB TCP and what a not. GCC real got better over the
last
years! 

So there is no real need for an option at all in my oppinion.
We have already enough of them.

The REST OF THE PATCH is containing only pure true clear cut bugfixes
which should be applied STRAIGHT away. Those fixes do not influence
the current compilation output at all (with the exception of hiding not
externaly used global symbols in misc.c). But they enable somebody
who knows what he is doing to add the above CFLAGS for his system to
gain a significant amount of free speace for example in the PROM or to
gain a bit of performance - supposedly.

I hope this makes my intentions clear. OK?

BTW.> Try it out it doesn't interferre with any module handling.
However your objections about binary only modules I just don't
share - becouse I just don't care about them... In esp. my nonexistant
interrest in computer games doesn't oppress me to 
by any nvida graphics cards. Pure nice old Mach64 -
which always was one of the most UNIX friendly VGA designs ever 
just makes it fine for me ;-).
