Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVCNKPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVCNKPM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 05:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVCNKNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 05:13:21 -0500
Received: from ozlabs.org ([203.10.76.45]:53131 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262101AbVCNKMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 05:12:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.25552.640180.677985@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 21:13:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] No-exec support for ppc64
In-Reply-To: <20050310162513.74191caa.moilanen@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen writes:

> diff -puN fs/binfmt_elf.c~nx-user-ppc64 fs/binfmt_elf.c
> --- linux-2.6-bk/fs/binfmt_elf.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
> +++ linux-2.6-bk-moilanen/fs/binfmt_elf.c	2005-03-08 16:08:54 -06:00
> @@ -99,6 +99,8 @@ static int set_brk(unsigned long start, 
>  		up_write(&current->mm->mmap_sem);
>  		if (BAD_ADDR(addr))
>  			return addr;
> +
> +  		sys_mprotect(start, end-start, PROT_READ|PROT_WRITE|PROT_EXEC);

I don't think I can push that upstream.  What happens if you leave
that out?

More generally, we are making a user-visible change, even for programs
that aren't marked as having non-executable stack or heap, because we
are now enforcing that the program can't execute from mappings that
don't have PROT_EXEC.  Perhaps we should enforce the requirement for
execute permission only on those programs that indicate somehow that
they can handle it?

Paul.
