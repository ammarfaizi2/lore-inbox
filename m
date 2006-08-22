Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWHVLIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWHVLIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 07:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWHVLIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 07:08:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:56766 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932168AbWHVLIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 07:08:50 -0400
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ps command race fix take2 [3/4] profile fix
References: <20060822174152.7105aa33.kamezawa.hiroyu@jp.fujitsu.com>
From: Andi Kleen <ak@suse.de>
Date: 22 Aug 2006 13:08:49 +0200
In-Reply-To: <20060822174152.7105aa33.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <p737j1181tq.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> writes:

> ===================================================================
> --- linux-2.6.18-rc4.orig/include/linux/sched.h
> +++ linux-2.6.18-rc4/include/linux/sched.h
> @@ -808,6 +808,10 @@ struct task_struct {
>  	struct list_head ptrace_children;
>  	struct list_head ptrace_list;
>  
> +#if defined(CONFIG_OPROFILE) || defined(CONFIG_OPROFILE_MODULE)
> +	struct list_head 	dead_tasks;
> +#endif

Sorry I think this needs a cleaner solution without ifdef.   Why can't it use
the token list? Or some other list head that's unused then.

Otherwise I would think it it better to use a separate list object to
maintain this list in oprofile.

-Andi
