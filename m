Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWFJApn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWFJApn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030571AbWFJApn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:45:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16041 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030564AbWFJApk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:45:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org, xemul@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, herbert@13thfloor.at, saw@sw.ru,
       serue@us.ibm.com, sfrench@us.ibm.com, sam@vilain.net,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [PATCH 1/6] IPC namespace core
References: <44898BF4.4060509@openvz.org> <44898D52.4080506@openvz.org>
Date: Fri, 09 Jun 2006 18:44:30 -0600
In-Reply-To: <44898D52.4080506@openvz.org> (Kirill Korotaev's message of "Fri,
	09 Jun 2006 19:01:38 +0400")
Message-ID: <m1fyid6dqp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:

> --- ./kernel/fork.c.ipcns	2006-06-06 14:47:58.000000000 +0400
> +++ ./kernel/fork.c	2006-06-08 15:31:03.000000000 +0400
> @@ -1592,6 +1592,7 @@ asmlinkage long sys_unshare(unsigned lon
>  	struct sem_undo_list *new_ulist = NULL;
>  	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
>  	struct uts_namespace *uts, *new_uts = NULL;
> +	struct ipc_namespace *ipc, *new_ipc = NULL;
>  
>  	check_unshare_flags(&unshare_flags);
>  
> @@ -1617,18 +1618,20 @@ asmlinkage long sys_unshare(unsigned lon
>  		goto bad_unshare_cleanup_fd;
>  	if ((err = unshare_utsname(unshare_flags, &new_uts)))
>  		goto bad_unshare_cleanup_semundo;
> +	if ((err = unshare_ipcs(unshare_flags, &new_ipc)))
> +		goto bad_unshare_cleanup_uts;
>  
>  	if (new_ns || new_uts) {
This test needs to be updated to test for new_ipc.
>  		old_nsproxy = current->nsproxy;
>  		new_nsproxy = dup_namespaces(old_nsproxy);
>  		if (!new_nsproxy) {
>  			err = -ENOMEM;
> -			goto bad_unshare_cleanup_uts;
> +			goto bad_unshare_cleanup_ipc;
>  		}
>  	}

Eric
