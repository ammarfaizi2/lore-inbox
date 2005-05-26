Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVEZJnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVEZJnf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 05:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVEZJne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 05:43:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13254 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261244AbVEZJit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 05:38:49 -0400
Date: Thu, 26 May 2005 11:38:27 +0200
From: Pavel Machek <pavel@suse.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: Swsusp trival fix
Message-ID: <20050526093827.GC1925@elf.ucw.cz>
References: <1117089842.8005.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117089842.8005.5.camel@linux-hp.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The below patch fixes a small error in -mm tree. It makes the error
> handling process correct, which is introduced by my previous
> suspend/resume smp patch.

My tree changed quite a bit relative to what is in -mm, so it does not
apply here. It looks correct for -mm.
								Pavel

>  linux-2.6.11-rc5-mm1-root/kernel/power/disk.c |    3 +--
>  1 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN kernel/power/disk.c~swsusp kernel/power/disk.c
> --- linux-2.6.11-rc5-mm1/kernel/power/disk.c~swsusp	2005-05-26 14:16:24.789077512 +0800
> +++ linux-2.6.11-rc5-mm1-root/kernel/power/disk.c	2005-05-26 14:18:23.369050616 +0800
> @@ -135,7 +135,7 @@ static int prepare_processes(void)
>  
>  	if (freeze_processes()) {
>  		error = -EBUSY;
> -		goto enable_cpu;
> +		goto thaw;
>  	}
>  
>  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> @@ -150,7 +150,6 @@ static int prepare_processes(void)
>  	return 0;
>  thaw:
>  	thaw_processes();
> -enable_cpu:
>  	enable_nonboot_cpus();
>  	pm_restore_console();
>  	return error;
> _
> 

-- 
