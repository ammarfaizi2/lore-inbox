Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319116AbSH2Iks>; Thu, 29 Aug 2002 04:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319124AbSH2Ikq>; Thu, 29 Aug 2002 04:40:46 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:54687 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S319116AbSH2Iko>; Thu, 29 Aug 2002 04:40:44 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: 2.5.32 doesn't beep?
Date: 29 Aug 2002 08:41:41 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnamrni5.3ub.kraxel@bytesex.org>
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <15724.51593.23255.339865@kim.it.uu.se> <20020828150522.A13090@ucw.cz> <15725.11451.335811.149069@kim.it.uu.se> <20020828223005.A21207@ucw.cz>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1030610501 4044 127.0.0.1 (29 Aug 2002 08:41:41 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Another issue: I enabled CONFIG_INPUT_MOUSEDEV_PSAUX, but /dev/psaux
> > gave an ENODEV when opened. Turns out CONFIG_INPUT_MOUSEDEV is
> > also required, but for some reason 'make config' let me set the
> > former without also setting the latter. A bug in input's config.in?
>  
>  Yes, a bug. Fixed now.

input in 2.5.32 also doesn't work fully modular because of some
unresolved symbols.  I fixed it this way:

==============================[ cut here ]==============================
--- linux-2.5.32/drivers/char/keyboard.c	Wed Aug 28 16:10:33 2002
+++ linux/drivers/char/keyboard.c	Wed Aug 28 16:11:43 2002
@@ -66,6 +66,7 @@
 #endif
 
 struct pt_regs *kbd_pt_regs;
+EXPORT_SYMBOL(kbd_pt_regs);
 void compute_shiftstate(void);
 
 /*
--- linux-2.5.32/drivers/input/input.c	Wed Aug 28 16:21:14 2002
+++ linux/drivers/input/input.c	Wed Aug 28 16:21:40 2002
@@ -772,6 +772,7 @@
 struct device_class input_devclass = {
 	.name		= "input",
 };
+EXPORT_SYMBOL(input_devclass);
 
 static int __init input_init(void)
 {
==============================[ cut here ]==============================

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
