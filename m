Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVEKVv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVEKVv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVEKVv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 17:51:27 -0400
Received: from isec.pl ([193.110.121.50]:21123 "EHLO isec.pl")
	by vger.kernel.org with ESMTP id S261324AbVEKVvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 17:51:23 -0400
Date: Wed, 11 May 2005 23:51:21 +0200 (CEST)
From: Paul Starzetz <ihaquer@isec.pl>
To: Greg KH <gregkh@suse.de>
Cc: security@isec.pl, <linux-kernel@vger.kernel.org>,
       <full-disclosure@lists.netsys.com>, <bugtraq@securityfocus.com>,
       <vulnwatch@vulnwatch.org>
Subject: Re: Linux kernel ELF core dump privilege elevation
In-Reply-To: <20050511181211.GA16652@kroah.com>
Message-ID: <Pine.LNX.4.44.0505112350170.15140-100000@isec.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Greg KH wrote:

that seems ok.

> --- gregkh-2.6.orig/fs/binfmt_elf.c	2005-05-11 00:03:45.000000000 -0700
> +++ gregkh-2.6/fs/binfmt_elf.c	2005-05-11 00:09:17.000000000 -0700
> @@ -251,7 +251,7 @@
>  	}
>  
>  	/* Populate argv and envp */
> -	p = current->mm->arg_start;
> +	p = current->mm->arg_end = current->mm->arg_start;
>  	while (argc-- > 0) {
>  		size_t len;
>  		__put_user((elf_addr_t)p, argv++);
> @@ -1301,7 +1301,7 @@
>  static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
>  		       struct mm_struct *mm)
>  {
> -	int i, len;
> +	unsigned int i, len;
>  	
>  	/* first copy the parameters from user space */
>  	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
> 

-- 
Paul Starzetz
iSEC Security Research
http://isec.pl/


