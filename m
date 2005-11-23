Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVKWSvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVKWSvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKWSvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:51:20 -0500
Received: from [67.137.28.188] ([67.137.28.188]:56457 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932163AbVKWSvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:51:19 -0500
Message-ID: <4384A63E.6030706@wolfmountaingroup.com>
Date: Wed, 23 Nov 2005 10:26:22 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>  <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>  <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>  <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>  <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 23 Nov 2005, H. Peter Anvin wrote:
>  
>
>>Linus Torvalds wrote:
>>    
>>
>>>What I suggested to Intel at the Developer Days is to have a MSR (or, better
>>>yet, a bit in the page table pointer %cr0) that disables "lock" in _user_
>>>space. Ie a lock would be a no-op when in CPL3, and only with certain
>>>processes.
>>>      
>>>
>>You mean %cr3, right?
>>    
>>
>
>Yes. 
>
>It _should_ be fairly easy to do something like that - just a simple 
>global flag that gets set and makes CPL3 ignore lock prefixes. Even timing 
>doesn't matter - it it takes a hundred cycles for the setting to take 
>effect, we don't care, since you can't write %cr3 from user space anyway, 
>and it will certainly take a hundred cycles (and a few serializing 
>instructions) until we get to CPL3.
>
>I'd personally prefer it to be in %cr3, since we'd have to reload it on 
>task switching, and that's one of the registers we load anyway. And it 
>would make sense. But it could be in an MSR too.
>
>Of course, if it's in one of the low 12 bits of %cr3, there would have to 
>be a "enable this bit" in %cr4 or something. Historically, you could write 
>any crap in the low bits, I think.
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
The lock prefix '0F' is used for a lot of opcodes other than "lock". Go 
check the instruction set reference. It's not
trivial what you are proposing. Intel has a pretty hacked up opcode map 
with a lot of history. The bit should be in
CR4 and not CR3.

J
