Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263396AbTC2Hp7>; Sat, 29 Mar 2003 02:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263397AbTC2Hp7>; Sat, 29 Mar 2003 02:45:59 -0500
Received: from ns.suse.de ([213.95.15.193]:57350 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263396AbTC2Hp6>;
	Sat, 29 Mar 2003 02:45:58 -0500
To: john stultz <johnstul@us.ibm.com>
Cc: torvalds@transmeta.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux-2.5.66_monotonic-clock_A3
References: <1048892109.975.150.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Mar 2003 08:57:14 +0100
In-Reply-To: <1048892109.975.150.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73el4qzjtx.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz <johnstul@us.ibm.com> writes:

> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		ret = timer->monotonic_clock();
> +	} while (read_seqretry(&xtime_lock, seq));

Why does it need to check xtime lock ? xtime should be independent 
of the monotonic time because it can be changed. 

Also doing seqlocks around hardware register reads is quite nasty,
because a hardware register read can be hundreds of cycles and you're
very likely to get retries. If you really need a seqlock I would
move it into the low level function and do it after the hardware access.
But as far as I can see it can be just removed.

-Andi
