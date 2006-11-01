Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946928AbWKAQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946928AbWKAQay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946931AbWKAQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:30:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46725 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1946928AbWKAQax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:30:53 -0500
Date: Wed, 1 Nov 2006 17:30:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Make x86_64 udelay() round up instead of down.
Message-ID: <20061101163043.GA2602@elf.ucw.cz>
References: <20061029200702.26757.12496.stgit@americanbeauty.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029200702.26757.12496.stgit@americanbeauty.home.lan>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Port two patches from i386 to x86_64 delay.c to make sure all rounding is done
> upward instead of downward.
> 
> There is no sign in commit messages that the mismatch was done on purpose, and
> "delay() guarantees sleeping at least for the specified time" is still a valid
> rule IMHO.

> diff --git a/arch/x86_64/lib/delay.c b/arch/x86_64/lib/delay.c
> index 50be909..7514df0 100644
> --- a/arch/x86_64/lib/delay.c
> +++ b/arch/x86_64/lib/delay.c
> @@ -40,13 +40,13 @@ EXPORT_SYMBOL(__delay);
>  
>  inline void __const_udelay(unsigned long xloops)
>  {
> -	__delay((xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32);
> +	__delay((xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32 + 1);

Well, if this should be *rounding* up, you should do 

(xloops * HZ * cpu_data[raw_smp_processor_id()].loops_per_jiffy + 0xffffffff) >> 32

, no? Not sure if it matters...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
