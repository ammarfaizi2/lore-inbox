Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319072AbSHSUcN>; Mon, 19 Aug 2002 16:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSHSUbA>; Mon, 19 Aug 2002 16:31:00 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24704 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319068AbSHSUa5>;
	Mon, 19 Aug 2002 16:30:57 -0400
Date: Mon, 20 Aug 2001 20:45:33 +0000
From: Pavel Machek <pavel@suse.cz>
To: Willy TARREAU <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] APM fix for 2.4.20pre1
Message-ID: <20010820204533.A169@toy.ucw.cz>
References: <20020806134328.GA587@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020806134328.GA587@pcw.home.local>; from willy@w.ods.org on Tue, Aug 06, 2002 at 03:43:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> @@ -897,10 +889,11 @@
>  	 */
>  #ifdef CONFIG_SMP
>  	/* Some bioses don't like being called from CPU != 0 */
> -	while (cpu_number_map(smp_processor_id()) != 0) {
> -		kernel_thread(apm_magic, NULL,
> -			CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
> +	if (cpu_number_map(smp_processor_id()) != 0) {
> +		current->cpus_allowed = 1;
>  		schedule();
> +		if (unlikely(cpu_number_map(smp_processor_id()) != 0))
> +			BUG();

BUG_ON()?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

