Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWDWV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWDWV2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWDWV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 17:28:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10886 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751459AbWDWV2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 17:28:01 -0400
Date: Sun, 23 Apr 2006 14:26:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, ericy@cais.com, jesper.juhl@gmail.com
Subject: Re: [PATCH] binfmt_elf CodingStyle cleanup and remove some
 pointless casts
Message-Id: <20060423142648.6ef34b9f.akpm@osdl.org>
In-Reply-To: <200604231858.15646.jesper.juhl@gmail.com>
References: <200604231858.15646.jesper.juhl@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Here's a patch that does a CodingStyle cleanup of fs/binfmt_elf.c and also
> removes some pointless casts of kmalloc() return values in the same file.
> 

Much-needed.

> -	NEW_AUX_ENT(AT_PHENT, sizeof (struct elf_phdr));
> +	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
>  	NEW_AUX_ENT(AT_FLAGS, 0);
>  	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
> -	NEW_AUX_ENT(AT_UID, (elf_addr_t) tsk->uid);
> -	NEW_AUX_ENT(AT_EUID, (elf_addr_t) tsk->euid);
> -	NEW_AUX_ENT(AT_GID, (elf_addr_t) tsk->gid);
> -	NEW_AUX_ENT(AT_EGID, (elf_addr_t) tsk->egid);
> - 	NEW_AUX_ENT(AT_SECURE, (elf_addr_t) security_bprm_secureexec(bprm));
> +	NEW_AUX_ENT(AT_UID, (elf_addr_t)tsk->uid);
> +	NEW_AUX_ENT(AT_EUID, (elf_addr_t)tsk->euid);
> +	NEW_AUX_ENT(AT_GID, (elf_addr_t)tsk->gid);
> +	NEW_AUX_ENT(AT_EGID, (elf_addr_t)tsk->egid);
> + 	NEW_AUX_ENT(AT_SECURE, (elf_addr_t)security_bprm_secureexec(bprm));

The typecasting for NEW_AUX_ENT is random, ugly, irrational and
undesirable.  It's always u32 or unsigned long.  Perhaps as a followup
patch you could look at removing the unneeded casts? (hopefully that'll
be all of them)

