Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWATQra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWATQra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWATQra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:47:30 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17540 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751081AbWATQr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:47:29 -0500
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com>
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 08:47:24 -0800
Message-Id: <1137775645.28944.61.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 07:20 -0800, Stephane Eranian wrote:

> +static struct pfm_smpl_fmt dfl_fmt={
> + 	.fmt_name = "default_format2",
> + 	.fmt_uuid = PFM_DFL_SMPL_UUID,

What's the point of using a UUID here?

> +static struct file_system_type pfm_fs_type = {
> +	.name     = "pfmfs",
> +	.get_sb   = pfmfs_get_sb,
> +	.kill_sb  = kill_anon_super,
> +};

A comment that describes what pfmfs is for would be useful here, and
perhaps a warning to hold one's nose, if the code that follows is
anything to go by :-)

> +#if 0
> +irqreturn_t pfm_interrupt_handler(int irq, void *arg, struct pt_regs *regs)

Why a dead interrupt handler here?

> +static ctl_table pfm_ctl_table[]={

Why are you using sysctls, and not sysfs?  Why is this in a file that
claims to be procfs-related?

Also, it looks like much of the procfs goo is actually not related to
individual processes, really doesn't belong in /proc at all, and should
move to some place in sysfs somewhere.

> +/*
> + * invoked by writing to /proc/sys/kernel/perfmon/reset_stats
> + */

Yep, this shouldn't be in /proc, unless I'm massively misunderstanding
the current state of the world.

> +int pfm_get_smpl_arg(pfm_uuid_t uuid, void *uaddr, size_t usize, void **arg,
> +		     struct pfm_smpl_fmt **fmt)

That should be void __user *uaddr.  Please run the code through sparse.

> +	if (addr)
> +		kfree(addr);

kfree ignores a NULL argument.

	<b

