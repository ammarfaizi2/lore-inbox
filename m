Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVJFNvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVJFNvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVJFNvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:51:06 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:59777 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750954AbVJFNvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:51:05 -0400
Message-ID: <43452BAC.3000306@cosmosbay.com>
Date: Thu, 06 Oct 2005 15:50:36 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, Andrey Savochkin <saw@sawoct.com>, st@sw.ru,
       discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de>
In-Reply-To: <p73hdbuzs7l.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 06 Oct 2005 15:50:36 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen a écrit :
> Kirill Korotaev <dev@sw.ru> writes:
> 
> 
>>Please help with a not simple question about spin_lock/spin_unlock on
>>SMP archs. The question is whether concurrent spin_lock()'s should
>>acquire it in more or less "fair" fashinon or one of CPUs can starve
>>any arbitrary time while others do reacquire it in a loop.
> 
> 
> They are not fully fair because of the NUMAness of the system.
> Same on many other NUMA systems.
> 
> We considered long ago to use queued locks to avoid this, but 
> they are quite costly for the uncongested case and never seemed worth it.
> 
> So live with it.

Unrelated, but that reminds me that current spinlock implementation on x86 
imply that NR_CPUS should be < 128.

Maybe we should reflect this in Kconfig ?

config NR_CPUS
range 2 128

Or use a plain int for spinlock, instead of a signed char.

Eric
