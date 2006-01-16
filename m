Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWAPWfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWAPWfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAPWfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:35:13 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:52371 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751234AbWAPWfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:35:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EGp/bGdS9vyPHqLI1Q6RdGe4WhAwsKLAj4PkYQ3KcNwII42bM/ykWIrJzdf5m+iqELiV+YwBOLL5fb6b9jtB4mEqxhEHlxsS4AtaXKc5FjBmO9+PoLfuvVo2jviMoUmiYLgmM9B5dwa+AvffwnlaTzkhnwwLe0617Rm2SMSiGug=
Date: Tue, 17 Jan 2006 01:52:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jason Baron <jbaron@redhat.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, drepper@redhat.com,
       Tony.Reix@bull.net
Subject: Re: [2.6 patch] fix sched_setscheduler semantics
Message-ID: <20060116225215.GA11049@mipter.zuzino.mipt.ru>
References: <Pine.LNX.4.61.0601161650540.21530@dhcp83-105.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601161650540.21530@dhcp83-105.boston.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 05:17:55PM -0500, Jason Baron wrote:
> --- linux-2.6/kernel/sched.c.bak
> +++ linux-2.6/kernel/sched.c
> @@ -3824,6 +3824,10 @@ do_sched_setscheduler(pid_t pid, int pol
>  asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
>  				       struct sched_param __user *param)
>  {
> +	/* negative values for policy are not valid */
> +	if (policy < 0)
> +		return -EINVAL;

Classical redundant comment.

