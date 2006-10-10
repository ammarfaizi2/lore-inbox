Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWJJGL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWJJGL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWJJGL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:11:27 -0400
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:58858 "EHLO
	lin5.shipmail.org") by vger.kernel.org with ESMTP id S965006AbWJJGL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:11:26 -0400
Message-ID: <452B398C.4030507@tungstengraphics.com>
Date: Tue, 10 Oct 2006 08:11:24 +0200
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
References: <20061009110007.GA3592@wotan.suse.de>	 <1160392214.10229.19.camel@localhost.localdomain>	 <20061009111906.GA26824@wotan.suse.de>	 <1160393579.10229.24.camel@localhost.localdomain>	 <20061009114527.GB26824@wotan.suse.de>	 <1160394571.10229.27.camel@localhost.localdomain>	 <20061009115836.GC26824@wotan.suse.de>	 <1160395671.10229.35.camel@localhost.localdomain>	 <20061009121417.GA3785@wotan.suse.de>	 <452A50C2.9050409@tungstengraphics.com>	 <20061009135254.GA19784@wotan.suse.de> <1160427036.7752.13.camel@localhost.localdomain>
In-Reply-To: <1160427036.7752.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>
>>>Could it be an option to make it safe for the fault handler to 
>>>temporarily drop the mmap_sem read lock given that some conditions TBD 
>>>are met?
>>>In that case it can retake the mmap_sem write lock, do the VMA flags 
>>>modifications, downgrade and do the pte modifications using a helper, or 
>>>even use remap_pfn_range() during the time the write lock is held?
>>>      
>>>
>>When you drop and retake the mmap_sem, you need to start again from
>>find_vma. At which point you technically probably want to start again
>>from the architecture specfic fault code. It sounds difficult but I
>>won't say it can't be done.
>>    
>>
>
>I can be done with returning NOPAGE_REFAULT but as you said, I don't
>think it's necessary.
>  
>
Still, even with NOPAGE_REFAULT or the equivalent with the new fault() code,
in the case we need to take this route, (and it looks like we won't have 
to),
I guess we still need to restart from find_vma() in the fault()/nopage() 
handler to make sure the VMA is still present. The object mutex need to 
be dropped as well to avoid deadlocks. Sounds complicated.

>Cheers,
>Ben.
>
>
>  
>
/Thomas

