Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSHFWqe>; Tue, 6 Aug 2002 18:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSHFWqd>; Tue, 6 Aug 2002 18:46:33 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:8458 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316258AbSHFWqd>; Tue, 6 Aug 2002 18:46:33 -0400
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: module cleanup (0/5)
Message-Id: <E17cD9U-0002uj-00@scrub.xs4all.nl>
From: Roman Zippel <zippel@linux-m68k.org>
Date: Wed, 07 Aug 2002 00:50:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will shortly send a few patches that cleanup the module code a bit.
All patches are independent. Please apply.

1. Replace get_mod_name/put_mod_name with getname/putname.
2. Make the various query functions more compact, by removing the second
   loop to calculate the required space and integrating it into the main
   loop.
3. Remove __MODULE_STRING() in favour of __stringify().
4. Introduce two macros mod_for_each_locked/mod_for_done_locked to safely
   iterate over the module list.
5. Remove obsolete get_kernel_syms system call.

The first 3 changes are trivial.
Patch 4 unifies all the code which loops over the module from an exception
context, so all that code now does correct locking.
get_kernel_syms is not used by modutils anymore. AFAIK get_kernel_syms is
only used by klogd and works fine without it.

bye, Roman
