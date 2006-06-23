Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751895AbWFWTK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbWFWTK0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbWFWTK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:10:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:3742 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751895AbWFWTKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:10:25 -0400
Date: Fri, 23 Jun 2006 15:10:02 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Amul Shah <amul.shah@unisys.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Eric Biederman <ebiederm@xmission.com>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [Fastboot] [PATCH] Fix kdump Crash Kernel boot memory reservation for NUMA	machines
Message-ID: <20060623191002.GD7551@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1151089038.29121.32.camel@b4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151089038.29121.32.camel@b4.na.uis.unisys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 02:57:17PM -0400, Amul Shah wrote:
> This patch will fix a boot memory reservation bug that trashes memory on
> the ES7000 when loading the kdump crash kernel.
> 
> The code in arch/x86_64/kernel/setup.c to reserve boot memory for the 
> crash kernel uses the non-numa aware "reserve_bootmem" function instead 
> of the NUMA aware "reserve_bootmem_generic".  I checked to make sure 
> that no other function was using "reserve_bootmem" and found none, 
> except the ones that had NUMA ifdef'ed out.
> 
> I have tested this patch only on an ES7000 with NUMA on and off (numa=off)
> in a single (non-NUMA) and multi-cell (NUMA) configurations.
> 
> Signed-off-by: Amul Shah <amul.shah@unisys.com>
> 
> 
> ---
> --- linux-2.6.16.18-1.8/arch/x86_64/kernel/setup.c      2006-06-06 12:07:42.000000000 -0400
> +++ linux-2.6.16.18-1.8-az/arch/x86_64/kernel/setup.c   2006-06-21 17:06:04.000000000 -0400
> @@ -715,7 +715,7 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  #ifdef CONFIG_KEXEC
>         if (crashk_res.start != crashk_res.end) {
> -               reserve_bootmem(crashk_res.start,
> +               reserve_bootmem_generic(crashk_res.start,
>                         crashk_res.end - crashk_res.start + 1);
>         }

Looks good to me. I know of a 64w NUMA machine test results and kdump
was successful. Not sure why did not we see the problem there. But
anyway this is logical.

Thanks
Vivek

