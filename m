Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWEJMsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWEJMsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 08:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWEJMsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 08:48:53 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11984 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964943AbWEJMsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 08:48:52 -0400
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       herbert@13thfloor.at, dev@sw.ru, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 2/9] nsproxy: incorporate fs namespace
References: <29vfyljM-1.2006059-s@us.ibm.com>
	<20060510021135.GC32523@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 10 May 2006 06:46:25 -0600
In-Reply-To: <20060510021135.GC32523@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Tue, 9 May 2006 21:11:35 -0500")
Message-ID: <m1k68uvyhq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:


> @@ -1727,11 +1727,16 @@ static void __init init_mount_tree(void)
>  	namespace->root = mnt;
>  	mnt->mnt_namespace = namespace;
>  
> -	init_task.namespace = namespace;
> +	init_task.nsproxy->namespace = namespace;
>  	read_lock(&tasklist_lock);
>  	do_each_thread(g, p) {
> +		/* do we want namespace count to be #nsproxies,
> +		 * or # processes pointing to the namespace? */

I am fairly certain we want the count to be #nsproxies.

>  		get_namespace(namespace);
> -		p->namespace = namespace;
> +#if 0
> +		/* should only be 1 nsproxy so far */
> +		p->nsproxy->namespace = namespace;
> +#endif
>  	} while_each_thread(g, p);
>  	read_unlock(&tasklist_lock);

So I think this bit is wrong.
