Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTENPyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTENPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:54:52 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:48596 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262437AbTENPys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:54:48 -0400
Date: Wed, 14 May 2003 12:04:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] PAG support only
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       dhowells@redhat.com, Jeff Garzik <jgarzik@pobox.com>
Message-ID: <200305141207_MC3-1-38D7-EB5B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

> Fair enough, but in arch/i386/kernel/process.c:
>
>       asmlinkage int sys_fork(struct pt_regs regs)
>       asmlinkage int sys_clone(struct pt_regs regs)
>       asmlinkage int sys_vfork(struct pt_regs regs)
>       asmlinkage int sys_execve(struct pt_regs regs)
>       etc...
>
> Should these be fixed too (the i386 arch is referred to quite a lot)?


$ grep 'asmlinkage int sys_' arch/i386/kernel/*.c | wc -l
     19


  And what is this all about?

$ grep -A 2 'unused)' arch/i386/kernel/*.c | grep -B 2 regs
arch/i386/kernel/ioport.c:asmlinkage int sys_iopl(unsigned long unused)
arch/i386/kernel/ioport.c-{
arch/i386/kernel/ioport.c-      volatile struct pt_regs * regs = (struct pt_regs *) &unused;
--
arch/i386/kernel/signal.c:asmlinkage int sys_sigreturn(unsigned long __unused)
arch/i386/kernel/signal.c-{
arch/i386/kernel/signal.c-      struct pt_regs *regs = (struct pt_regs *) &__unused;
--
arch/i386/kernel/signal.c:asmlinkage int sys_rt_sigreturn(unsigned long __unused)
arch/i386/kernel/signal.c-{
arch/i386/kernel/signal.c-      struct pt_regs *regs = (struct pt_regs *) &__unused;

