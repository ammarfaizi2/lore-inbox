Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263588AbUEMEOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263588AbUEMEOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 00:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUEMEOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 00:14:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:14484 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263588AbUEMEOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 00:14:39 -0400
Date: Wed, 12 May 2004 21:14:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, luto@myrealbox.com
Subject: Re: [PATCH 1/2] capabilities: cleanups
Message-Id: <20040512211411.6af01084.akpm@osdl.org>
In-Reply-To: <200405112024.23834.luto@myrealbox.com>
References: <200405112024.23834.luto@myrealbox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> wrote:
>
> --- linux-2.6.6-mm1/include/linux/binfmts.h~cap_1_cleanup	2004-05-10 23:52:05.000000000 -0700
>  +++ linux-2.6.6-mm1/include/linux/binfmts.h	2004-05-11 00:58:13.000000000 -0700
>  @@ -20,6 +20,9 @@
>   /*
>    * This structure is used to hold the arguments that are used when loading binaries.
>    */
>  +#define BINPRM_SEC_SETUID	1
>  +#define BINPRM_SEC_SETGID	2
>  +#define BINPRM_SEC_SECUREEXEC	4
>   struct linux_binprm{
>   	char buf[BINPRM_BUF_SIZE];
>   	struct page *page[MAX_ARG_PAGES];
>  @@ -27,8 +30,9 @@
>   	unsigned long p; /* current top of mem */
>   	int sh_bang;
>   	struct file * file;
>  -	int e_uid, e_gid;
>  -	kernel_cap_t cap_inheritable, cap_permitted, cap_effective;
>  +	int set_uid, set_gid;
>  +	int secflags;
>  +	kernel_cap_t cap_inheritable, cap_permitted;

security/dummy.c: In function `dummy_bprm_apply_creds':
security/dummy.c:176: structure has no member named `e_uid'
security/dummy.c:176: structure has no member named `e_gid'
security/dummy.c:180: structure has no member named `e_uid'
security/dummy.c:181: structure has no member named `e_gid'
security/dummy.c:185: structure has no member named `e_uid'
security/dummy.c:186: structure has no member named `e_gid'

