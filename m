Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262508AbTCMTzq>; Thu, 13 Mar 2003 14:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbTCMTzq>; Thu, 13 Mar 2003 14:55:46 -0500
Received: from terminus.zytor.com ([63.209.29.3]:60093 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262508AbTCMTzp>; Thu, 13 Mar 2003 14:55:45 -0500
Message-ID: <3E70E4B8.2010600@zytor.com>
Date: Thu, 13 Mar 2003 12:06:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, davej@suse.de, alan@redhat.com,
       torvalds@transmeta.com
Subject: Re: [PATCH] cpu/hw_random cleanups
References: <20030313184343.GA7246@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Here are the requested cleanups to cpu capabilities and hw_random.c.
> 
> For x86 experts, the new cpu cap words are what needs looking over.
> For example, I wonder if storing Intel's cpuid(0x00000001) ecx
> register output is wise on older Intel cpus.  I worry about garbage
> appearing there.  Is that a false worry?
> 

Yes; it should be completely safe.

> This has only been tested on Via Nehemiah CPUs...  I have a laptop with
> an Intel RNG on it at home, and will be testing with that later on
> tonight to make sure nothing is broken.  I'm hoping Alan or somebody can
> test AMD RNG... if not I'll poke around work and see if there are any
> boxes I can test on.
> 
> WRT hw_random, the main change there is to allow multiple independent
> openers to read(2) simultaneously, by removing the semaphore that
> limited userspace to a single open(2)er.
> 
> Comments welcome.  This patch is to be considered as a fourth patch in
> the previously-posted hw_random series.
> 
> 
> ===== arch/i386/kernel/cpu/centaur.c 1.7 vs edited =====
> --- 1.7/arch/i386/kernel/cpu/centaur.c	Tue Mar 11 21:35:40 2003
> +++ edited/arch/i386/kernel/cpu/centaur.c	Thu Mar 13 13:31:08 2003
> @@ -256,9 +256,10 @@
>  	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
>  		set_bit(X86_FEATURE_CENTAUR_EFF, c->x86_capability);
>  

There is also no need to set a special feature bit for the existence of 
the feature flags.  If they are not present the additional capability 
word will simply be zero.


