Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVISIY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVISIY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 04:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVISIY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 04:24:58 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:16033 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932191AbVISIY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 04:24:57 -0400
Date: Mon, 19 Sep 2005 10:24:23 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org, macro@linux-mips.org,
       akpm@osdl.org, roland@redhat.com, dev@sw.ru,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] more sigkill priority fix
Message-ID: <20050919082423.GB15034@osiris.boeblingen.de.ibm.com>
References: <20050908.012450.41200025.anemo@mba.ocn.ne.jp> <20050917.011715.41182516.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917.011715.41182516.anemo@mba.ocn.ne.jp>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> anemo> On Linux/MIPS, a simple test program can create unkillable
> anemo> process.  The "sigkill priority fix" was introduced in 2.6.12,
> anemo> but it does not effective for signals sent by force_sig() in
> anemo> kernel.  For detailed behavior and testcase, please look at
> anemo> this thread in linux-mips ML:
> 
> This is fixed by another way in 2.6.14-rc1 for i386 (Thanks, Roland).
> The changelog line is:
> 
> >    [PATCH] i386: Don't miss pending signals returning to user mode after signal processing
> >    Signed-off-by: Roland McGrath <roland@redhat.com>
> 
> And now similar fix for mips is already in Linux/MIPS CVS tree too.
> 
> --- linux-mips/arch/mips/kernel/entry.S	2005-03-04 22:17:29.000000000 +0900
> +++ linux/arch/mips/kernel/entry.S	2005-09-16 01:04:52.365022536 +0900
> @@ -105,7 +105,7 @@
>  	move	a0, sp
>  	li	a1, 0
>  	jal	do_notify_resume	# a2 already loaded
> -	j	restore_all
> +	j	resume_userspace
>  
>  FEXPORT(syscall_exit_work_partial)
>  	SAVE_STATIC
> 
> 
> I suppose the original problem on s390 (reported by Heiko Carstens)
> could be fixed same way.  Then 'sigkill priority fix' would be
> reverted safely.

If I understand the two arch changes correctly then this means that before
going back to userspace always _all_ pending signals will be delivered.
Of course this would fix the original problem and the 'sigkill priority fix'
could be reverted, if all architectures would implement this behaviour.
Is this the way the kernel is supposed to handle signals now?
Just wondering, since this changes signal handling quite significantly from
what it was before.

Heiko
