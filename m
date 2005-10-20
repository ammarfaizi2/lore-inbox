Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbVJTUou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbVJTUou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 16:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVJTUot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 16:44:49 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:1701 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932529AbVJTUot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 16:44:49 -0400
Message-ID: <435801BF.90701@vc.cvut.cz>
Date: Thu, 20 Oct 2005 22:44:47 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-almost-rc3, ext3 and memory corruption
References: <20051001030027.GA8784@vana.vc.cvut.cz> <4347F3DE.8070505@vc.cvut.cz>
In-Reply-To: <4347F3DE.8070505@vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> Petr Vandrovec wrote:
> 
>> Hello,
>>   I was so happy that 2.6.13-rc3 was released that I tried to grab it,
>> and while I was doing that, box said:
>>
>> Slab corruption: start=ffff8100005e5bf8, len=96
>> Redzone: 0x5a2cf071/0x5a2cf071.

> Hello,
>   so I've enabled JBD-DEBUG, and unfortunately somebody corrupted inode 
> instead of journal head this time :-(  But corruption looks same - 
> somebody wrote 32bit value 1 somewhere it should not...  Does anybody 
> have something like CONFIG_DEBUG_PAGE_ALLOC for x86-64?
> 
> Slab corruption: start=ffff8100005e7c00, len=976
> Redzone: 0x5a2cf071/0x5a2cf071.

Still no clue, but somebody still writes 0x00000001 here and there around my 
inodes :-(  This time when I was building 2.6.14-rc5 kernel...  Apparently 
whenever my old kernel finds that it is going to be replaced it attempts to 
boycott build of new kernel.

Linux ppc 2.6.14-rc3-8298 #9 SMP PREEMPT Sun Oct 9 03:45:32 CEST 2005 x86_64 
GNU/Linux

slab error in cache_free_debugcheck(): cache `size-64': double free, or memory 
outside object was overwritten

Call Trace:<ffffffff8017230a>{cache_free_debugcheck+378} 
<ffffffff8017376c>{kfree+220}
        <ffffffff801aaafe>{clear_inode+174} <ffffffff801aaba8>{dispose_list+104}
        <ffffffff801aaffa>{prune_icache+426} 
<ffffffff801ab067>{shrink_icache_memory+23}
        <ffffffff80176185>{shrink_slab+229} <ffffffff801776bd>{balance_pgdat+589}
        <ffffffff80371474>{_spin_lock_irqsave+36} <ffffffff80177937>{kswapd+311}
        <ffffffff80155070>{autoremove_wake_function+0} 
<ffffffff80155070>{autoremove_wake_function+0}
        <ffffffff801356dd>{schedule_tail+77} <ffffffff8010fd92>{child_rip+8}
        <ffffffff80177800>{kswapd+0} <ffffffff8010fd8a>{child_rip+0}

ffff8100005e7c38: redzone 1: 0x170fc2a5, redzone 2: 0x1.

									Petr

>> Box in question has single Athlon64 processor, runs SMP PREEMPT kernel
>> with almost all debugging options set (but not CONFIG_JBD_DEBUG).  Box 
>> has 2GB of ECC RAM.  Root filesystem is on pata disk connected to the 
>> pata port on Promise's 20378 (using sata_promise).  Disk with git 
>> repository is plugged to pata port on Via's VT8237.  Kernel's 
>> configuration is at http://platan.vc.cvut.cz/vana_at_home_config.txt, 
>> dmesg at http://platan.vc.cvut.cz/vana_at_home_dmesg.txt.


