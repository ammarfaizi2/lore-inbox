Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263613AbUDQD3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 23:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUDQD3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 23:29:16 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:61853 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263613AbUDQD3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 23:29:14 -0400
Date: Sat, 17 Apr 2004 05:29:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "David S. Miller" <davem@redhat.com>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5+BK compile error: binfmt_elf on sparc64
Message-ID: <20040417032912.GA23888@MAIL.13thfloor.at>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.44.0404141104370.28974-100000@math.ut.ee> <20040414115301.37145997.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040414115301.37145997.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 11:53:01AM -0700, David S. Miller wrote:
> On Wed, 14 Apr 2004 11:33:00 +0300 (EEST)
> Meelis Roos <mroos@linux.ee> wrote:
> 
> > Because of -Werror, it bails out:
> > 
> > In file included from arch/sparc64/kernel/binfmt_elf32.c:154:
> > fs/binfmt_elf.c: In function `load_elf_interp':
> > fs/binfmt_elf.c:369: warning: comparison is always false due to limited range of data type
> > fs/binfmt_elf.c: In function `load_elf_binary':
> > fs/binfmt_elf.c:780: warning: comparison is always false due to limited range of data type
> > 
> > It's the comparision "elf_ppnt->p_memsz > TASK_SIZE".
> > 
> > p_memsz is Elf32_Word, TASK_SIZE is defined as
> > #define TASK_SIZE       ((unsigned long)-VPTE_SIZE)
> > 
> > At the first glance I can't see what's wrong here.
> 
> The compiler is telling us that the condition is always false because a 32-bit
> value can never have the codition being tested against a 64-bit one (TASK_SIZE).
> I've tried everything to kill this warning, even casting both sides of the
> conparison to 64-bit, but gcc can still see things clearly.
> 
> So just comment out the -Werror line in arch/sparc64/kernel/Makefile which is
> how I'm (unfortunately) solving this for now.

what about the good old

	eppnt->p_memsz - TASK_SIZE > 0

HTH,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
