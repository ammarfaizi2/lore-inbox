Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSA2WJN>; Tue, 29 Jan 2002 17:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbSA2WJJ>; Tue, 29 Jan 2002 17:09:09 -0500
Received: from [202.135.142.194] ([202.135.142.194]:46863 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S282967AbSA2WI6>; Tue, 29 Jan 2002 17:08:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: Your message of "Tue, 29 Jan 2002 01:22:30 -0800."
             <3C5669D6.B81E0B4@zip.com.au> 
Date: Wed, 30 Jan 2002 09:09:33 +1100
Message-Id: <E16VgRZ-0007Kf-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C5669D6.B81E0B4@zip.com.au> you write:
> Rusty Russell wrote:
> > 
> > This patch introduces the __per_cpu_data tag for data, and the
> > per_cpu() & this_cpu() macros to go with it.
> > 
> > This allows us to get rid of all those special case structures
> > springing up all over the place for CPU-local data.
> 
> Am I missing something? smp_init() is called quite late in
> the boot process, and if any code touches per-cpu data before
> this, it'll get a null pointer deref, won't it?

Yes.  But for a large amount of code it doesn't matter, and most
architectures don't know how many CPUs there are before smp_init().
Of course, we could make it NR_CPUS...

Do you have an example where you want to use this before
smp_boot_cpus()?  If so, we can bite the bullet.  Otherwise I'd prefer
not to waste memory.

BTW, my master plan (well, stolen from Anton and Paulus here) was to
have one register to point to the per-cpu area, and all you need is a
shift down 12 bits, and with 31 to get cpu id.  Bwahahahah! (non-x86
of course).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
