Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUDNSxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 14:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUDNSxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 14:53:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261576AbUDNSxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 14:53:21 -0400
Date: Wed, 14 Apr 2004 11:53:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5+BK compile error: binfmt_elf on sparc64
Message-Id: <20040414115301.37145997.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.44.0404141104370.28974-100000@math.ut.ee>
References: <Pine.GSO.4.44.0404141104370.28974-100000@math.ut.ee>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 11:33:00 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> Because of -Werror, it bails out:
> 
> In file included from arch/sparc64/kernel/binfmt_elf32.c:154:
> fs/binfmt_elf.c: In function `load_elf_interp':
> fs/binfmt_elf.c:369: warning: comparison is always false due to limited range of data type
> fs/binfmt_elf.c: In function `load_elf_binary':
> fs/binfmt_elf.c:780: warning: comparison is always false due to limited range of data type
> 
> It's the comparision "elf_ppnt->p_memsz > TASK_SIZE".
> 
> p_memsz is Elf32_Word, TASK_SIZE is defined as
> #define TASK_SIZE       ((unsigned long)-VPTE_SIZE)
> 
> At the first glance I can't see what's wrong here.

The compiler is telling us that the condition is always false because a 32-bit
value can never have the codition being tested against a 64-bit one (TASK_SIZE).
I've tried everything to kill this warning, even casting both sides of the
conparison to 64-bit, but gcc can still see things clearly.

So just comment out the -Werror line in arch/sparc64/kernel/Makefile which is
how I'm (unfortunately) solving this for now.
