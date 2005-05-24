Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVEXM37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVEXM37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVEXM1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:27:40 -0400
Received: from colin.muc.de ([193.149.48.1]:45326 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262035AbVEXM1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:27:01 -0400
Date: 24 May 2005 14:27:00 +0200
Date: Tue, 24 May 2005 14:27:00 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, rusty@rustycorp.com.au,
       vatsa@in.ibm.com, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [patch 3/4] CPU Hotplug support for X86_64
Message-ID: <20050524122700.GC86182@muc.de>
References: <20050524081113.409604000@csdlinux-2.jf.intel.com> <20050524081304.805933000@csdlinux-2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524081304.805933000@csdlinux-2.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 01:11:16AM -0700, Ashok Raj wrote:
> ===================================================================
> --- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smpboot.c
> +++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c
> @@ -62,9 +62,12 @@
>  /* Number of siblings per CPU package */
>  int smp_num_siblings = 1;
>  /* Package ID of each logical CPU */
> -u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
> -u8 cpu_core_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
> +u8 phys_proc_id[NR_CPUS] __cacheline_aligned = 
> +	{ [0 ... NR_CPUS-1] = BAD_APICID };

Why this change?

>  EXPORT_SYMBOL(phys_proc_id);
> +
> +u8 cpu_core_id[NR_CPUS] __cacheline_aligned = 
> +	{ [0 ... NR_CPUS-1] = BAD_APICID };

And that one?

It does not seem related to CPUhotplug. May as a separate patch,
but in this case the "per cpu readonly" section C.Lameter recently
added should be used for these which are near always read-only
(I hope the section made it into -mm* now)


-Andi
