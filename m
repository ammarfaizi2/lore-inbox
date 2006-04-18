Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWDRWO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWDRWO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDRWO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:14:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10128 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750767AbWDRWO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:14:26 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] arch/i386/kernel/cpu/cpufreq/powernow-k8.c: fix a check-after-use
Date: Wed, 19 Apr 2006 00:14:15 +0200
User-Agent: KMail/1.9.1
Cc: Jacob Shin <jacob.shin@amd.com>, Dave Jones <davej@redhat.com>,
       Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org
References: <20060418220728.GU11582@stusta.de>
In-Reply-To: <20060418220728.GU11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604190014.15515.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 00:07, Adrian Bunk wrote:
> This patch fixes a check-after-use introduced by commit 
> 4211a30349e8d2b724cfb4ce2584604f5e59c299 and spotted by the Coverity 
> checker.

Good catch. Should probably go into 2.6.17

-Andi

> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  arch/i386/kernel/cpu/cpufreq/powernow-k8.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> --- linux-2.6.17-rc1-mm3-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.c.old	2006-04-18 20:32:27.000000000 +0200
> +++ linux-2.6.17-rc1-mm3-full/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-04-18 20:33:02.000000000 +0200
> @@ -905,14 +905,17 @@ static int powernowk8_target(struct cpuf
>  {
>  	cpumask_t oldmask = CPU_MASK_ALL;
>  	struct powernow_k8_data *data = powernow_data[pol->cpu];
> -	u32 checkfid = data->currfid;
> -	u32 checkvid = data->currvid;
> +	u32 checkfid;
> +	u32 checkvid;
>  	unsigned int newstate;
>  	int ret = -EIO;
>  
>  	if (!data)
>  		return -EINVAL;
>  
> +	checkfid = data->currfid;
> +	checkvid = data->currvid;
> +
>  	/* only run on specific CPU from here on */
>  	oldmask = current->cpus_allowed;
>  	set_cpus_allowed(current, cpumask_of_cpu(pol->cpu));
> 
> 
