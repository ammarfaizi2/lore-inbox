Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTIPPZf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTIPPZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:25:35 -0400
Received: from dyn-ctb-210-9-243-132.webone.com.au ([210.9.243.132]:37126 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261947AbTIPPZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:25:25 -0400
Message-ID: <3F672B42.5090809@cyberone.com.au>
Date: Wed, 17 Sep 2003 01:24:50 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: John Bradford <john@grabjohn.com>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <Pine.LNX.3.96.1030916095944.26515D-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030916095944.26515D-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bill Davidsen wrote:

>On Mon, 15 Sep 2003, Nick Piggin wrote:
>
>
>>
>>John Bradford wrote:
>>
>
>>I guess more specialised users would be able to edit the cache line
>>size themselves. I wouldn't be adverse to a kconfig setting under the
>>embedded menu though.
>>
>
>Clearly something which might be useful for some embedded CPUs.
>
>
>>I can see an argument for cache line size but thats about it. I can't
>>think of my optimisations that should be done on one architecture but
>>not another.
>>
>
>Well, if you meant "any optimizations" there are lots, and they already
>have config entries. Ex: F.P. emulation, RZ1000 fixups, etc.
>
>
>>No I definitely agree. Except sometimes you'll have to check at runtime:
>>a kernel compiled for all cpus for example needs Andi's Athlon prefetch
>>scheme. You'd really want some good helpers to either do runtime check
>>or always, or never. Something like this optimises down OK if cpu and
>>archmask are constant.
>>
>>static inline void ifcpu(const int cpumask, void (*func)(void))
>>{
>>        if ((cpumask&archmask) && ((~cpumask)&archmask)) {
>>                if (cpumask&current_cpu)
>>                        func();
>>        } else if (cpumask&archmask) {
>>                func();
>>        }
>>}
>>
>>ifcpu(K7||K8, &prefetch_workaround);
>>
>>You then need to get kconfig to generate cpu and archmask nicely.
>>You obviously still need to ifdef your prefetch_workaround to get the
>>space saving.
>>
>
>True, there's no way to get a minimal kernel without at least some
>ifdef'iness, although if you defined the code as an inline function and
>used your code above... a matter of style, a few preprocessor lines in
>that much code aren't going to be confusing.
>

I don't think ifdefing around functions is that bad for this sort of
workaround code. You have to take the address of the function with my
above code, so you can't use an inline one. I don't think the
preprocessor can solve the problem either because it seems you'd need
conditional compilation directives within a macro. I'm not a C expert
though so someone might have a way to do it.


