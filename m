Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319443AbSH3Fy0>; Fri, 30 Aug 2002 01:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319445AbSH3FyZ>; Fri, 30 Aug 2002 01:54:25 -0400
Received: from dp.samba.org ([66.70.73.150]:60606 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319443AbSH3FyY>;
	Fri, 30 Aug 2002 01:54:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: junio@siamese.dyndns.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1) 
In-reply-to: Your message of "Thu, 29 Aug 2002 09:39:14 CST."
             <Pine.LNX.4.44.0208290938180.3234-100000@hawkeye.luckynet.adm> 
Date: Fri, 30 Aug 2002 13:50:25 +1000
Message-Id: <20020830005909.816302C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0208290938180.3234-100000@hawkeye.luckynet.adm> you w
rite:
> Hi,
> 
> On Thu, 29 Aug 2002, Rusty Russell wrote:
> > If you really care about that, try:
> > 
> > 	/* Be paranoid in case someone uses strlen(&("FOO"[0])) */
> > 	#define strlen(x) \
> > 		(__builtin_constant_p(x) && sizeof(x) != sizeof(char *)
> > 		? (sizeof(x) - 1) : __strlen(x))
> 
> I must say that doesn't make the code any cleaner, which leads to it being 
> not as clean as Keith suggested. It was a code cleanup, not a code messup.

Think harder.

This code would exist in one place: those (four) architectures which
insist on having an inline strlen function.  These guys already eat
inline asm for breakfast: it's *their* jobs to jump through hoops so
the driver writers can write simple code and have it work well.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
