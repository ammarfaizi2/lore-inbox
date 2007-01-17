Return-Path: <linux-kernel-owner+w=401wt.eu-S932596AbXAQRiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbXAQRiF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 12:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAQRiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 12:38:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932598AbXAQRiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 12:38:03 -0500
Message-ID: <45AE5EF5.8050604@sandeen.net>
Date: Wed, 17 Jan 2007 11:37:57 -0600
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: xfs-masters@oss.sgi.com
CC: "<Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [xfs-masters] [PATCH 14/59] sysctl: C99 convert xfs ctl_tables
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com> <11689656301563-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656301563-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  fs/xfs/linux-2.6/xfs_sysctl.c |  258 ++++++++++++++++++++++++++++------------
>  1 files changed, 180 insertions(+), 78 deletions(-)

Oh no, 100 more XFS LOC! ;)

Minor nits below...

> +	{
> +		.ctl_name	= XFS_PANIC_MASK,
> +		.procname	= "panic_mask",
> +		.data		= &xfs_params.panic_mask.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	=  &proc_dointvec_minmax,

Extra space here

> +	{
> +		.ctl_name	= XFS_INHERIT_NODUMP,
> +		.procname	= "inherit_nodump",
> +		.data		= &xfs_params.inherit_nodump.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,

don't think you want the NULL here

> +		.extra1		= &xfs_params.inherit_nodump.min,
> +		.extra2		= &xfs_params.inherit_nodump.max
> +	},
> +	{
> +		.ctl_name	= XFS_INHERIT_NOATIME,
> +		.procname	= "inherit_noatime",
> +		.data		= &xfs_params.inherit_noatim.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,

or here

> +	{
> +		.ctl_name	= XFS_BUF_AGE,
> +		.procname	= "age_buffer_centisecs",
> +		.data		= &xfs_params.xfs_buf_age.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &proc_dointvec_minmax,
> +		.strategy	= &sysctl_intvec, NULL,

or here

> +	{
> +		.ctl_name	= XFS_STATS_CLEAR,
> +		.procname	= "stats_clear",
> +		.data		= &xfs_params.stats_clear.val,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	=  &xfs_stats_clear_proc_handler,

extra space here

Thanks,
-Eric
