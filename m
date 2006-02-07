Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWBGQ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWBGQ0z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWBGQ0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:26:53 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:5774 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S965157AbWBGQ0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:26:52 -0500
Message-ID: <43E8CA10.5070501@cosmosbay.com>
Date: Tue, 07 Feb 2006 17:25:52 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Ingo Molnar <mingo@elte.hu>, Jens Axboe <axboe@suse.de>,
       Anton Blanchard <anton@samba.org>, William Irwin <wli@holomorphy.com>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060207151541.GA32139@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060207151541.GA32139@osiris.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 07 Feb 2006 17:25:51 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens a écrit :
>> tree 8c30052a0d7fadec37c785a42a71b28d0a9c5fcf
>> parent cef5076987dd545ac74f4efcf1c962be8eac34b0
>> author Eric Dumazet <dada1@cosmosbay.com> Sun, 05 Feb 2006 15:27:36 -0800
>> committer Linus Torvalds <torvalds@g5.osdl.org> Mon, 06 Feb 2006 03:06:51 -0800
>>
>> [PATCH] percpu data: only iterate over possible CPUs
>>
>> percpu_data blindly allocates bootmem memory to store NR_CPUS instances of
>> cpudata, instead of allocating memory only for possible cpus.
>>
>> As a preparation for changing that, we need to convert various 0 -> NR_CPUS
>> loops to use for_each_cpu().
>>
>> (The above only applies to users of asm-generic/percpu.h.  powerpc has gone it
>> alone and is presently only allocating memory for present CPUs, so it's
>> currently corrupting memory).
> 
> This patch is broken since it replaces several loops that iterate NR_CPUS
> times with for_each_cpu before cpu_possible_map is setup:

This patch assumes that cpu_possible_map is setup before setup_per_cpu_areas().

That sounds a reasonable assumption, but maybe not on your architecture ?

I dont think cpu_possible_map has to be filled at smp_prepare_cpus() time, but 
long before.

On i386/x86_64/ia64, this is done from setup_arch() called from start_kernel() 
just before setup_per_cpu_areas()

On powerpc it's done from setup_system(), called before start_kernel()

Eric


