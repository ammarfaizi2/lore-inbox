Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267729AbTBUVWx>; Fri, 21 Feb 2003 16:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267726AbTBUVWx>; Fri, 21 Feb 2003 16:22:53 -0500
Received: from [195.39.17.254] ([195.39.17.254]:29312 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267729AbTBUVWs>;
	Fri, 21 Feb 2003 16:22:48 -0500
Date: Tue, 18 Feb 2003 08:29:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND 6] sysctls for PA-RISC
Message-ID: <20030218072933.GA149@elf.ucw.cz>
References: <20030216190930.B6290@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216190930.B6290@parcelfarce.linux.theplanet.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Can anyone think why Linus isn't applying this patch?  He won't tell
> me what's wrong with it, and I'm getting frustrated by the silence.
> 
> Add two new sysctls.  The first one handles the soft-power switch
> and the second describes what to do when we get an unaligned trap.

Perhaps that soft-power thingie should be done in a generic way? Any
modern pc has soft-power, too...
								Pavel

> --- linus-2.5/include/linux/sysctl.h	Sun Jan  5 11:03:43 2003
> +++ parisc-2.5/include/linux/sysctl.h	Sun Jan  5 11:23:43 2003
> @@ -129,6 +129,8 @@ enum
>  	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
>  	KERN_PIDMAX=55,		/* int: PID # limit */
>    	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
> +	KERN_HPPA_PWRSW=57,	/* int: hppa soft-power enable */
> +	KERN_HPPA_UNALIGNED=58,	/* int: hppa unaligned-trap enable */
>  };
>  
>  
> --- linus-2.5/kernel/sysctl.c	Sun Jan  5 11:03:50 2003
> +++ parisc-2.5/kernel/sysctl.c	Sun Jan  5 11:23:55 2003
> @@ -84,6 +84,11 @@ extern char reboot_command [];
>  extern int stop_a_enabled;
>  #endif
>  
> +#ifdef __hppa__
> +extern int pwrsw_enabled;
> +extern int unaligned_enabled;
> +#endif
> +
>  #ifdef CONFIG_ARCH_S390
>  #ifdef CONFIG_MATHEMU
>  extern int sysctl_ieee_emulation_warnings;
> @@ -188,6 +193,12 @@ static ctl_table kern_table[] = {
>  	{KERN_SPARC_REBOOT, "reboot-cmd", reboot_command,
>  	 256, 0644, NULL, &proc_dostring, &sysctl_string },
>  	{KERN_SPARC_STOP_A, "stop-a", &stop_a_enabled, sizeof (int),
> +	 0644, NULL, &proc_dointvec},
> +#endif
> +#ifdef __hppa__
> +	{KERN_HPPA_PWRSW, "soft-power", &pwrsw_enabled, sizeof (int),
> +	 0644, NULL, &proc_dointvec},
> +	{KERN_HPPA_UNALIGNED, "unaligned-trap", &unaligned_enabled, sizeof (int),
>  	 0644, NULL, &proc_dointvec},
>  #endif
>  #if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
> 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
