Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTKTCKM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTKTCKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:10:11 -0500
Received: from CPE-138-130-214-20.qld.bigpond.net.au ([138.130.214.20]:22999
	"EHLO mx.jeeves.bpa.nu") by vger.kernel.org with ESMTP
	id S264289AbTKTCKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:10:07 -0500
From: Ben Hoskings <ben@jeeves.bpa.nu>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: transmeta cpu code question
Date: Thu, 20 Nov 2003 12:10:04 +1000
User-Agent: KMail/1.5.4
References: <20031120020218.GJ3748@schottelius.org>
In-Reply-To: <20031120020218.GJ3748@schottelius.org>
Cc: Nico Schottelius <nico-mutt@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200311201210.04780.ben@jeeves.bpa.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Nov 2003 12:02 pm, Nico Schottelius wrote:
> Hello!
>
> What does this do:
>
>                 printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u,
> %u MHz\n",
>                        (cpu_rev >> 24) & 0xff,
>                        (cpu_rev >> 16) & 0xff,
>                        (cpu_rev >> 8) & 0xff,
>                        cpu_rev & 0xff,
>                        cpu_freq);
>
> (from arch/i386/kernel/cpu/transmeta.c)
>
> Does not & 0xff make no sense? 0 & 1 makes 0, 1 & 1 makes 1,
> no changes.

I may be wrong, but afaik the 0xff's are there to truncate the other values to 
8-bit. 0xff == 0b11111111, which is 8-bit.

>From the bitshifting above, cpu_rev seems to be a 32-bit value, so the four 
sections of cpu_rev (>>24, >>16, >>8 and >>0) are being ANDed with 0xff to 
show only the 8 low bits (post-shift).

>
> And I don't understand why we do this for 8bit and shifting the
> cpu_rev...
>
> Can someone enlighten me (with CC' as I am not subscribed) ?
>
> Nico
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben

