Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290609AbSA3VO2>; Wed, 30 Jan 2002 16:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290607AbSA3VOS>; Wed, 30 Jan 2002 16:14:18 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:37381 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290606AbSA3VOD>;
	Wed, 30 Jan 2002 16:14:03 -0500
Date: Tue, 29 Jan 2002 01:04:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] [sched] x86 idle thread should clear %fs, %gs
Message-ID: <20020129000419.GA18496@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0201271826220.5785-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201271826220.5785-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> so it appears that this lowlevel x86 performance bug(?) is more than 11
> years old! :-)

Probably 386's were not optimized for %fs==%gs==0 case?

BTW does it really make a difference for the CPU?
									Pavel

> @@ -2803,9 +2803,10 @@
>  	load_TR(nr);
>  	load_LDT(&init_mm);
> 
> -	/*
> -	 * Clear all 6 debug registers:
> -	 */
> +	/* Clear %fs and %gs. */
> +	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");
> +
> +	/* Clear all 6 debug registers: */
> 
>  #define CD(register) __asm__("movl %0,%%db" #register ::"r"(0) );

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
