Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131726AbRBQOXK>; Sat, 17 Feb 2001 09:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131715AbRBQOW7>; Sat, 17 Feb 2001 09:22:59 -0500
Received: from jalon.able.es ([212.97.163.2]:60374 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131726AbRBQOWx>;
	Sat, 17 Feb 2001 09:22:53 -0500
Date: Sat, 17 Feb 2001 15:22:40 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Hugh Dickins <hugh@veritas.com>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
Message-ID: <20010217152240.A2641@werewolf.able.es>
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com> <Pine.LNX.4.21.0102171200530.2029-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0102171200530.2029-100000@localhost.localdomain>; from hugh@veritas.com on Sat, Feb 17, 2001 at 14:15:42 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.17 Hugh Dickins wrote:
> On Sat, 17 Feb 2001, Paul Gortmaker wrote:
> > I was poking around in a vmlinux the other day and was surprised at the 
> > amount of repetitive crap text that was in there.  For example, try:
> > 
> > strings vmlinux|grep $PWD|wc -c
> > 

If you try
strings vmlinux|grep /usr

you get a bunch of strings like:
..
/usr/src/linux/include/asm/io.h
..

One other couple of Kb. The problem is not that, but the string comes from:
/usr/src/linux/include/asm/io.h:
..(line 110)
/*
 * Temporary debugging check to catch old code using
 * unmapped ISA addresses. Will be removed in 2.4.
 */
#if 1
  extern void *__io_virt_debug(unsigned long x, const char *file, int line);
  extern unsigned long __io_phys_debug(unsigned long x, const char *file, int li
ne);
  #define __io_virt(x) __io_virt_debug((unsigned long)(x), __FILE__, __LINE__)
//#define __io_phys(x) __io_phys_debug((unsigned long)(x), __FILE__, __LINE__)
#else
  #define __io_virt(x) ((void *)(x))
//#define __io_phys(x) __pa(x)
#endif
..

As you see, it was not removed in 2.4...

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac17 #1 SMP Sat Feb 17 01:47:56 CET 2001 i686

