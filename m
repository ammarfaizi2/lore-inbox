Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293600AbSCKE2x>; Sun, 10 Mar 2002 23:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293604AbSCKE2o>; Sun, 10 Mar 2002 23:28:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:70 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293603AbSCKE2e>; Sun, 10 Mar 2002 23:28:34 -0500
Date: Mon, 11 Mar 2002 05:29:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: Re: [PATCH] Support for assymmetric SMP
Message-ID: <20020311052954.R8949@dualathlon.random>
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 04:34:21AM +0100, Kurt Garloff wrote:
> @@ -53,6 +54,10 @@
>  	unsigned long *pmd_quick;
>  	unsigned long *pte_quick;
>  	unsigned long pgtable_cache_sz;
> +	unsigned long cpu_khz;
> +	unsigned long fast_gettimeoffset_quotient;
> +	unsigned long last_tsc_low;
> +	struct timeval xtime;
>  } __attribute__((__aligned__(SMP_CACHE_BYTES)));
>  
>  #define X86_VENDOR_INTEL 0

the only problem is if you happen to get the timer irq always in the
same cpu for a few seconds, then the last_tsc_low will wrap around and
gettimeofday will be wrong. And even if you snapshot the full 64bit of the
tsc you'll run into some trouble if the timer irq will be delivered only
to the same cpu for a long time (for example if you use irq bindings).
you'd lose precision and you'll run into the measuration errors of
fast_gettimeoffset_quotient. The right support for asynchronous TSC
handling is a bit more complicated unfortunately.

Andrea
