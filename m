Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293070AbSCEAoB>; Mon, 4 Mar 2002 19:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293071AbSCEAnv>; Mon, 4 Mar 2002 19:43:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3849 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S293070AbSCEAnc>; Mon, 4 Mar 2002 19:43:32 -0500
Date: Tue, 5 Mar 2002 00:43:25 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
Message-ID: <20020305004325.C32309@flint.arm.linux.org.uk>
In-Reply-To: <1015287099.865.3.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1015287099.865.3.camel@phantasy>; from rml@tech9.net on Mon, Mar 04, 2002 at 07:11:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 07:11:23PM -0500, Robert Love wrote:
> During 2.5.5-pre, an optimization was made that removed schedule_tail
> from UP kernels.  This causes the initial preempt_count of a new task,
> which starts at 1, to never decrement to zero and thus never become
> preemptible.
> 
> Thanks to everyone who pointed out the lousy performance - it took
> awhile to find but it should be fixed now.  Please comment if not.
> 
> Patch is against 2.5.6-pre2 and is critical for all UP+preempt users.
> 
> 	Robert Love
> 
> diff -urN linux-2.5.6-pre2/arch/alpha/kernel/entry.S linux/arch/alpha/kernel/entry.S
> --- linux-2.5.6-pre2/arch/alpha/kernel/entry.S	Fri Mar  1 17:21:14 2002
> +++ linux/arch/alpha/kernel/entry.S	Mon Mar  4 17:49:27 2002
> @@ -495,7 +495,7 @@
>  	ret	$31,($26),1
>  .end alpha_switch_to
>  
> -#ifdef CONFIG_SMP
> +#ifdef CONFIG_SMP || CONFIG_PREEMPT

Surely you really don't mean this?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

