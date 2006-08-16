Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWHPDKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWHPDKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbWHPDKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:10:45 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:38625 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750870AbWHPDKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:10:45 -0400
Date: Tue, 15 Aug 2006 22:10:43 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, containers@lists.osdl.org,
       linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [Containers] [PATCH 2/7] pid: Add do_each_pid_task
Message-ID: <20060816031043.GE15241@sergelap.austin.ibm.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com> <11556661923847-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11556661923847-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> To avoid pid rollover confusion the kernel needs to work with
> struct pid * instead of pid_t.  Currently there is not an iterator
> that walks through all of the tasks of a given pid type starting
> with a struct pid.  This prevents us replacing some pid_t instances
> with struct pid.  So this patch adds do_each_pid_task which walks
> through the set of task for a given pid type starting with a struct pid.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  include/linux/pid.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 93da7e2..4007114 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -118,4 +118,17 @@ #define while_each_task_pid(who, type, t
>  				1; }) );				\
>  	}
>  
> +#define do_each_pid_task(pid, type, task)				\

Hmm, defining do_each_pid_task right after do_each_task_pid could result
in some frustration  :)

Though not sure of a better name - do_each_task_structpid?

-serge
