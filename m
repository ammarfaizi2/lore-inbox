Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVFCQSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVFCQSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFCQSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:18:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17616 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261377AbVFCQQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:16:10 -0400
Date: Fri, 3 Jun 2005 18:11:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Brian Gerst <bgerst@didntduck.org>
Cc: davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix warning in powernow-k8.c
Message-ID: <20050603161132.GB5083@elf.ucw.cz>
References: <429F3A9E.504@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429F3A9E.504@didntduck.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Fix this warning:
> powernow-k8.c: In function ?query_current_values_with_pending_wait?:
> powernow-k8.c:110: warning: ?hi? may be used uninitialized in this
> function

Are you sure?

Original code is clearly buggy; I do not think you need that ugly do
{} while loop.

								Pavel
> 
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>

> diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> --- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> +++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> @@ -110,14 +110,13 @@ static int query_current_values_with_pen
>  	u32 lo, hi;
>  	u32 i = 0;
>  
> -	lo = MSR_S_LO_CHANGE_PENDING;
> -	while (lo & MSR_S_LO_CHANGE_PENDING) {
> +	do {
>  		if (i++ > 0x1000000) {
>  			printk(KERN_ERR PFX "detected change pending stuck\n");
>  			return 1;
>  		}
>  		rdmsr(MSR_FIDVID_STATUS, lo, hi);
> -	}
> +	} while (lo & MSR_S_LO_CHANGE_PENDING);
>  
>  	data->currvid = hi & MSR_S_HI_CURRENT_VID;
>  	data->currfid = lo & MSR_S_LO_CURRENT_FID;


-- 
