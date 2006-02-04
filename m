Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWBDXvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWBDXvp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 18:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946153AbWBDXvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 18:51:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030216AbWBDXvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 18:51:17 -0500
Date: Sat, 4 Feb 2006 15:50:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: steiner@sgi.com, dgc@sgi.com, Simon.Derr@bull.net, ak@suse.de,
       linux-kernel@vger.kernel.org, pj@sgi.com, clameter@sgi.com
Subject: Re: [PATCH 4/5] cpuset memory spread slab cache optimizations
Message-Id: <20060204155019.47f313d7.akpm@osdl.org>
In-Reply-To: <20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060204071927.10021.75308.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> +void mpol_set_task_struct_flag(struct task_struct *p)
>  +{
>  +	if (p->mempolicy)
>  +		p->flags |= PF_MEMPOLICY;
>  +	else
>  +		p->flags &= ~PF_MEMPOLICY;
>  +}

As mentioned before, if we ever modify tsk->flags, where tsk != current, we
have a nasty race.  So this function's interface really does invite that
race and hence is not very good.

As we do seem to be only calling it for current or for a newly-created task
I guess the access is OK, so perhaps a weaselly comment would cover that
worry.

