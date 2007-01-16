Return-Path: <linux-kernel-owner+w=401wt.eu-S1750824AbXAPSiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXAPSiN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbXAPSiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:38:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59146 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXAPSiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:38:11 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       xfs@oss.sgi.com
Subject: Re: [PATCH 14/59] sysctl: C99 convert xfs ctl_tables
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656301563-git-send-email-ebiederm@xmission.com>
	<20070116181651.GA5028@martell.zuzino.mipt.ru>
Date: Tue, 16 Jan 2007 11:37:12 -0700
In-Reply-To: <20070116181651.GA5028@martell.zuzino.mipt.ru> (Alexey Dobriyan's
	message of "Tue, 16 Jan 2007 21:16:51 +0300")
Message-ID: <m1irf6byxz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> writes:

> On Tue, Jan 16, 2007 at 09:39:19AM -0700, Eric W. Biederman wrote:
>> --- a/fs/xfs/linux-2.6/xfs_sysctl.c
>> +++ b/fs/xfs/linux-2.6/xfs_sysctl.c
>> @@ -55,95 +55,197 @@ xfs_stats_clear_proc_handler(
>
>> +	{
>> +		.ctl_name	= XFS_RESTRICT_CHOWN,
>> +		.procname	= "restrict_chown",
>> +		.data		= &xfs_params.restrict_chown.val,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= &proc_dointvec_minmax,
>> +		.strategy	= &sysctl_intvec,
>
> No need for &. These two are functions.

True.  I was trying to preserve as much as I could of the original
to minimize my changes of messing something up.

>> +		.extra1		= &xfs_params.restrict_chown.min,
>> +		.extra2		= &xfs_params.restrict_chown.max
> 								,
>
> Usually, comma is left even if the field is last and no additions
> expected.

Yep.  Again I the comma wasn't there in the first place, so
I didn't add it.

>> +	{
>> +		.ctl_name	= XFS_PANIC_MASK,
>> +		.procname	= "panic_mask",
>> +		.data		= &xfs_params.panic_mask.val,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	=  &proc_dointvec_minmax,
> 				  ^
> Space.
>
>> +	{
>> +		.ctl_name	= XFS_INHERIT_NODUMP,
>> +		.procname	= "inherit_nodump",
>> +		.data		= &xfs_params.inherit_nodump.val,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= &proc_dointvec_minmax,
>> +		.strategy	= &sysctl_intvec, NULL,
> 						  ^^^^
> Forgotten NULL.

Good catch thank you.

>> +	{
>> +		.ctl_name	= XFS_INHERIT_NOATIME,
>> +		.procname	= "inherit_noatime",
>> +		.data		= &xfs_params.inherit_noatim.val,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= &proc_dointvec_minmax,
>> +		.strategy	= &sysctl_intvec, NULL,
>
> Ditto.
>
>> +	{
>> +		.ctl_name	= XFS_STATS_CLEAR,
>> +		.procname	= "stats_clear",
>> +		.data		= &xfs_params.stats_clear.val,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	=  &xfs_stats_clear_proc_handler,
> 				  ^
> Space.


Eric
