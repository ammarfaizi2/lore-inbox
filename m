Return-Path: <linux-kernel-owner+w=401wt.eu-S1750721AbXAPSRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXAPSRX (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbXAPSRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:17:23 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:38546 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXAPSRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:17:22 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Q0LEG9+J71WwE3m0ZYlTygtKem6m/rXvBDmGbZR+YpRYZXrHCzSD7HH7N4ieXNGOr78XoHb2hD5OgY20B9gPwm+j2Pyc82/6jx6GnUmhP2TTAzjtjVAvYXg2wsbmYAK0qm15v4q8OQYGruLyemFg7T97lW2AbD3YWgKG8E8+SzE=
Date: Tue, 16 Jan 2007 21:16:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       xfs@oss.sgi.com
Subject: Re: [PATCH 14/59] sysctl: C99 convert xfs ctl_tables
Message-ID: <20070116181651.GA5028@martell.zuzino.mipt.ru>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656301563-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11689656301563-git-send-email-ebiederm@xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 09:39:19AM -0700, Eric W. Biederman wrote:
> --- a/fs/xfs/linux-2.6/xfs_sysctl.c
> +++ b/fs/xfs/linux-2.6/xfs_sysctl.c
> @@ -55,95 +55,197 @@ xfs_stats_clear_proc_handler(

> +	{
> +		.ctl_name	= XFS_RESTRICT_CHOWN,
> +		.procname	= "restrict_chown",
> +		.data		= &xfs_params.restrict_chown.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec,

No need for &. These two are functions.

> +		.extra1		= &xfs_params.restrict_chown.min,
> +		.extra2		= &xfs_params.restrict_chown.max
								,

Usually, comma is left even if the field is last and no additions
expected.

> +	{
> +		.ctl_name	= XFS_PANIC_MASK,
> +		.procname	= "panic_mask",
> +		.data		= &xfs_params.panic_mask.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	=  &proc_dointvec_minmax,
				  ^
Space.

> +	{
> +		.ctl_name	= XFS_INHERIT_NODUMP,
> +		.procname	= "inherit_nodump",
> +		.data		= &xfs_params.inherit_nodump.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,
						  ^^^^
Forgotten NULL.

> +	{
> +		.ctl_name	= XFS_INHERIT_NOATIME,
> +		.procname	= "inherit_noatime",
> +		.data		= &xfs_params.inherit_noatim.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,

Ditto.

> +	{
> +		.ctl_name	= XFS_STATS_CLEAR,
> +		.procname	= "stats_clear",
> +		.data		= &xfs_params.stats_clear.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	=  &xfs_stats_clear_proc_handler,
				  ^
Space.

