Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWHGTkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWHGTkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWHGTkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:40:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:63504 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932324AbWHGTku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:40:50 -0400
Date: Mon, 7 Aug 2006 21:40:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Message-ID: <20060807194047.GM3691@stusta.de>
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <20060807085924.72f832af.rdunlap@xenotime.net> <m1wt9kcv2n.fsf@ebiederm.dsl.xmission.com> <20060807105537.08557636.rdunlap@xenotime.net> <m1psfcbcnk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1psfcbcnk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 12:53:35PM -0600, Eric W. Biederman wrote:
>...
> --- a/arch/x86_64/Kconfig
> +++ b/arch/x86_64/Kconfig
> @@ -384,6 +384,20 @@ config NR_CPUS
>  	  This is purely to save memory - each supported CPU requires
>  	  memory in the static kernel configuration.
>  
> +config NR_IRQS
> +	int "Maximum number of IRQs (224-57344)"

	int "Maximum number of IRQs (224-57344)" depends on SMP

This way, people with SMP=n will not see this question.

> +	range 224 57344
> +	default "4096" if SMP
> +	default "224" if !SMP

Why not always
         default "224"
?



> +	help
>...

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

