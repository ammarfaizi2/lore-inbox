Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVKXDbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVKXDbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 22:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVKXDbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 22:31:17 -0500
Received: from urtax.ms.mff.cuni.cz ([195.113.20.127]:18606 "EHLO
	urtax.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932350AbVKXDbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 22:31:16 -0500
Date: Thu, 24 Nov 2005 04:31:15 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
X-X-Sender: mikulas@urtax.ms.mff.cuni.cz
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
In-Reply-To: <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0511240430410.21325@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> 
 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> 
 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> 
 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de>
 <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>
  <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain>
 <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com>
 <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Nov 2005, Linus Torvalds wrote:

>
>
> On Wed, 23 Nov 2005, H. Peter Anvin wrote:
>>
>> Linus Torvalds wrote:
>>> What I suggested to Intel at the Developer Days is to have a MSR (or, better
>>> yet, a bit in the page table pointer %cr0) that disables "lock" in _user_
>>> space. Ie a lock would be a no-op when in CPL3, and only with certain
>>> processes.
>>
>> You mean %cr3, right?
>
> Yes.
>
> It _should_ be fairly easy to do something like that - just a simple
> global flag that gets set and makes CPL3 ignore lock prefixes. Even timing
> doesn't matter - it it takes a hundred cycles for the setting to take
> effect, we don't care, since you can't write %cr3 from user space anyway,
> and it will certainly take a hundred cycles (and a few serializing
> instructions) until we get to CPL3.
>
> I'd personally prefer it to be in %cr3, since we'd have to reload it on
> task switching, and that's one of the registers we load anyway. And it
> would make sense. But it could be in an MSR too.
>
> Of course, if it's in one of the low 12 bits of %cr3, there would have to
> be a "enable this bit" in %cr4 or something. Historically, you could write
> any crap in the low bits, I think.

Why should they waste their (already complex) decoding logic with that?
Why can't an application instead set a bit somewhere if it's running on
SMP and if it's threaded and branch to variants with and without lock
prefix?

(correctly predicted branch is even faster than some microcode to
determine the value of your bit)

Mikulas

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
