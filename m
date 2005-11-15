Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVKOBSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVKOBSp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVKOBSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:18:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751310AbVKOBSo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:18:44 -0500
Date: Mon, 14 Nov 2005 17:12:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com, ak@muc.de,
       benh@kernel.crashing.org, paulus@samba.org, stephane.eranian@hp.com,
       tony.luck@intel.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
Message-Id: <20051114171226.680cddc8.akpm@osdl.org>
In-Reply-To: <200511150050.27556.arnd@arndb.de>
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net>
	<200511150050.27556.arnd@arndb.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> wrote:
>
> >  #ifdef __KERNEL__
> >  #define __NR__exit __NR_exit
> 
> Hmm, I had sent an earlier patch to paulus that reserves 278 and
> 279 for spu_run and spu_create and that apparently got dropped.
> 
> Could I have those two numbers or is there already an established
> user based for the perfmon2 numbers that would take preference?

aargh.  Any time anyone dinks with the syscall tables I have tons of fun
fixing up rejects.  It doesn't help that both Stephane and Christoph's
patches were fairly broken.

Rules:

a) Keep unistd.h and the syscall tables in sync.

b) Keep ppc32 and powerpc[64] in sync

c) Add prototypes to syscalls.h (When the implementation goes in -
   obviously not relevant when we're just reserving syscall slots)

d) Some architectures have multiple syscall tables.  Stephane, you
   missed arch/ia64/ia32/ia32_entry.S, for example.  But then, that looks
   to be seriously out of date anyway.  No idea what's going on there.

e) review your work carefully.  Grep the tree for, say, `getxattr' (or
   any other syscall name which is unique-looking and which you expect all
   architectures to implement).

Anyway, I have a shower of fixup patches here.   Hopefully it all landed OK.
