Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030532AbVKXA1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030532AbVKXA1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 19:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVKXA1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 19:27:38 -0500
Received: from [67.137.28.188] ([67.137.28.188]:7818 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1030532AbVKXA1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 19:27:37 -0500
Message-ID: <4384F50D.6030804@wolfmountaingroup.com>
Date: Wed, 23 Nov 2005 16:02:37 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051123214835.GA24044@nevyn.them.org> <Pine.LNX.4.64.0511231416490.13959@g5.osdl.org> <20051123222056.GA25078@nevyn.them.org> <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511231502250.13959@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 23 Nov 2005, Daniel Jacobowitz wrote:
>  
>
>>Why should we use a silicon based solution for this, when I posit that
>>there are simpler and equally effective userspace solutions?
>>    
>>
>
>Name them.
>
>In user space, doing things like clever run-time linking things is 
>actually horribly bad. It causes COW faults at startup, and/or makes the 
>compiler have to do indirections unnecessarily.  Both of which actually 
>make caches less effective, because now processes that really effectively 
>do have exactly the same contents have them in different pages.
>
>The other alternative (which apparently glibc actually does use) is to 
>dynamically branch over the lock prefixes, which actually works better: 
>it's more work dynamically, but it's much cheaper from a startup 
>standpoint and there's no memory duplication, so while it is the "stupid" 
>approach, it's actually better than the clever one.
>  
>

Using self modifying code stubs will work, and Intel's architecture will 
support it. This would be
faster than waiting 2-3 years for Intel to spin a processor rev. NetWare 
did something similair with
global branch tables for memory protection.


J


>The third alternative is to know at link-time that the process never does 
>anything threaded, but that needs more developer attention and 
>non-standard setups, and you _will_ get it wrong (some library will create 
>some thread without the developer even realizing). It also has the 
>duplicated library overhead (but at least now the duplication is just 
>twice, not "each process duplicates its own private pointer")
>
>In short, there simply isn't any good alternatives. The end result is that 
>thread-safe libraries are always in practice thread-safe even on UP, even 
>though that serializes the CPU altogether unnecessarily.
>
>I'm sure you can make up alternatives every time you hit one _particular_ 
>library, but that just doesn't scale in the real world.
>
>In contrast, the simple silicon support scales wonderfully well. Suddenly 
>libraries can be thread-safe _and_ efficient on UP too. You get to eat 
>your cake and have it too.
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

