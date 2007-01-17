Return-Path: <linux-kernel-owner+w=401wt.eu-S1751995AbXAQDUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbXAQDUI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 22:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbXAQDUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 22:20:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:35324 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995AbXAQDUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 22:20:05 -0500
Subject: Re: [PATCH 36/59] sysctl: C99 convert ctl_tables entries in
	arch/ppc/kernel/ppc_htab.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
       linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
       ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
       aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
       rtc-linux@googlegroups.com, linux-scsi@vger.kernel.org,
       kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
       linuxsh-shmedia-dev@lists.sourceforge.net, James.Bottomley@SteelEye.com,
       clemens@ladisch.de, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       andrea@suse.de, openipmi-developer@lists.sourceforge.net,
       linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
       a.zummo@towertech.it, tony.luck@intel.com,
       linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
       aia21@cantab.net, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
       lethal@linux-sh.org, containers@lists.osdl.org, linux390@de.ibm.com,
       philb@gnu.org
In-Reply-To: <11689656602523-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	 <11689656602523-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 14:16:54 +1100
Message-Id: <1169003814.4778.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 09:39 -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> And make the mode of the kernel directory 0555 no one is allowed
> to write to sysctl directories.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/ppc/kernel/ppc_htab.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
> index bd129d3..77b20ff 100644
> --- a/arch/ppc/kernel/ppc_htab.c
> +++ b/arch/ppc/kernel/ppc_htab.c
> @@ -442,11 +442,16 @@ static ctl_table htab_ctl_table[]={
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dol2crvec,
>  	},
> -	{ 0, },
> +	{}
>  };
>  static ctl_table htab_sysctl_root[] = {
> -	{ 1, "kernel", NULL, 0, 0755, htab_ctl_table, },
> - 	{ 0,},
> +	{
> +		.ctl_name	= CTL_KERN,
> +		.procname	= "kernel",
> +		.mode		= 0555,
> +		.child		= htab_ctl_table,
> +	},
> +	{}
>  };
>  
>  static int __init

