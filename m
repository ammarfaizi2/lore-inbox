Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbUJXKD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUJXKD6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbUJXKD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:03:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:38884 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261417AbUJXKDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:03:52 -0400
Date: Sun, 24 Oct 2004 03:01:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][resend] small binfmt_elf warning fix (copy_from_user
 return value checking) (fwd)
Message-Id: <20041024030151.0c81df8f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0410240244050.25721@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410240244050.25721@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
>  diff -up linux-2.6.9-rc3-bk5-orig/fs/binfmt_elf.c linux-2.6.9-rc3-bk5/fs/binfmt_elf.c
>  --- linux-2.6.9-rc3-bk5-orig/fs/binfmt_elf.c	2004-09-30 05:04:32.000000000 +0200
>  +++ linux-2.6.9-rc3-bk5/fs/binfmt_elf.c	2004-10-06 23:21:22.000000000 +0200
>  @@ -1223,7 +1223,7 @@ static void fill_psinfo(struct elf_prpsi
>   	len = mm->arg_end - mm->arg_start;
>   	if (len >= ELF_PRARGSZ)
>   		len = ELF_PRARGSZ-1;
>  -	copy_from_user(&psinfo->pr_psargs,
>  +	len -= copy_from_user(&psinfo->pr_psargs,
>   		       (const char __user *)mm->arg_start, len);
>   	for(i = 0; i < len; i++)
>   		if (psinfo->pr_psargs[i] == 0)

It doesn't matter, really - we've already zeroed out the memory and will
correctly handle any uncopied data.

Maybe sticking a (void) in front of the copy_from_user() call will shut the
warning up.  Although it could possibly break the build, depending on how
the architecture implements copy_from_user().
