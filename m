Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbTAFJRy>; Mon, 6 Jan 2003 04:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbTAFJRy>; Mon, 6 Jan 2003 04:17:54 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:63900 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266330AbTAFJRx>; Mon, 6 Jan 2003 04:17:53 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, rth@twiddle.net, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, ak@suse.de,
       davem@redhat.com, paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections
References: <20030102030044.D066C2C05E@lists.samba.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 Jan 2003 18:25:26 +0900
In-Reply-To: <20030102030044.D066C2C05E@lists.samba.org>
Message-ID: <buo3co6bpfd.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The declaration of `module_frob_arch_sections' in moduleloader.h (and
the definitions in most of the module.c files) are inconsistent with the
definition in the PPC's module.c -- in the latter the first two
arguments are not declared `const', whereas everyplace else they are.

I copied the PPC version of module_frob_arch_sections for the v850, and
couldn't compile without changing the type-signature to match.  Making
all args const to agree with the declaration results in these warnings:

   arch/v850/kernel/module.c: In function `module_frob_arch_sections':
   arch/v850/kernel/module.c:124: warning: assignment of read-only member `sh_size'arch/v850/kernel/module.c:126: warning: assignment of read-only member `sh_size'

Since the purpose of module_frob_arch_sections is to frob, perhaps it
makes sense to have the frobable arguments be non-const (in this case
only sechdrs needs it, I guess)... :-)

-Miles
-- 
"Whatever you do will be insignificant, but it is very important that
 you do it."  Mahatma Ghandi
