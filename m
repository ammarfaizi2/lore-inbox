Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280828AbRKLQKi>; Mon, 12 Nov 2001 11:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280831AbRKLQK2>; Mon, 12 Nov 2001 11:10:28 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:3858 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280828AbRKLQKP>;
	Mon, 12 Nov 2001 11:10:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: dalecki@evision.ag
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.14 mregparm=3 compilation fixes 
In-Reply-To: Your message of "Mon, 12 Nov 2001 12:28:33 BST."
             <3BEFB261.700729A4@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Nov 2001 03:10:02 +1100
Message-ID: <4300.1005581402@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001 12:28:33 +0100, 
Martin Dalecki <dalecki@evision-ventures.com> wrote:
>diff -ur linux-2.4.14-2/arch/i386/Makefile linux-mdcki/arch/i386/Makefile
>--- linux-2.4.14-2/arch/i386/Makefile	Thu Apr 12 21:20:31 2001
>+++ linux-mdcki/arch/i386/Makefile	Sat Nov 10 00:07:17 2001
>@@ -21,7 +21,7 @@
> LDFLAGS=-e stext
> LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
> 
>-CFLAGS += -pipe
>+CFLAGS += -freg-struct-return -mregparm=3
> 
> # prevent gcc from keeping the stack 16 byte aligned
> CFLAGS += $(shell if $(CC) -mpreferred-stack-boundary=2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-mpreferred-stack-boundary=2"; fi)

Setting mregparm must be a CONFIG_ option, with a huge warning that

A) Changing CONFIG_MREGPARM requires make mrproper.

B) Loading binary only modules into a kernel compiled with mregparm is
   even more likely to destroy your kernel.

