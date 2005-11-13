Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbVKMDUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVKMDUN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKMDUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:20:13 -0500
Received: from c-67-177-11-17.hsd1.ut.comcast.net ([67.177.11.17]:1408 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751234AbVKMDUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:20:11 -0500
Message-ID: <4376AAC1.5060503@utah-nac.org>
Date: Sat, 12 Nov 2005 19:53:53 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com> <43722AFC.4040709@pobox.com>	<Pine.LNX.4.58.0511090904320.4001@shark.he.net> <p73u0eh4als.fsf@verdi.suse.de>
In-Reply-To: <p73u0eh4als.fsf@verdi.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>"Randy.Dunlap" <rdunlap@xenotime.net> writes:
>
>  
>
>>On Wed, 9 Nov 2005, Jeff Garzik wrote:
>>
>>    
>>
>>>Jan Beulich wrote:
>>>      
>>>
>>>>The following patch set represents the Novell Linux Kernel Debugger,
>>>>stripped off of its original low-level exception handling framework.
>>>>        
>>>>
>>>Honestly, just seeing all these code changes makes me think we really
>>>don't need it in the kernel.  How many "early" and "alternative" gadgets
>>>do we really need just for this thing?
>>>      
>>>
>>On the surface I have to agree.  However, if Jan wants feedback
>>on the patches, that's a reasonable request IMO.
>>(but they need to be readable via email so that someone
>>can comment on them)
>>
>>At a quick blush, I would guess it has as much chance as
>>kdb does (or did) for merging.
>>    
>>
>
>I hope we can follow the same strategy as I did for debuggers on x86-64 - 
>which imho worked very well. Get all the (sane) hooks in so that everybody
>who wants to use their particular flavour of debugger can use it 
>by (ideally) either just loading it or alternatively applying a small
>core patch and the debugger files elsewhere. The die chains started
>from that. 
>  
>
Yes. This is the way to go. Use kdb as a base and instrument an 
alternate debugger interface. You need to also find a good way to
allow GDB to work properly with alternate debuggers. At present, the 
code in traps.c is mutually exclusive since embedded int3
breakpoints trigger in the kernel for gbd. This is busted.

Jeff

>Making the debugger work modular is a bit more work, but possible (was
>done for kdb at least before with some changes). IMHO that's the ideal
>state for users - they can just compile it externally and load it when
>they need it, but the core kernel doesn't need to carry it. It
>conflicts a bit with the usual policy of not exporting stuff that's
>not used in the core kernel; but I think making an exception here is
>reasonable because
>
>So I guess it's best to concentrate on merging the hooks needed in a sane
>way. 
>
>I think the many additions for "early" code in the NLKD patchkit
>comes from Jan's desire to make the debugger work in as many weird
>corner cases as possible. I must say he found a lot of problems in 
>corner cases during that work in x86-64 and i386, fixing generic
>bugs and making even the standard oops code and other error handling
>code (e.g. double faults on i386) more reliable, which I appreciate. 
>
>The particular early changes have to be weighted of course in
>intrusiveness. If it's simple and not too ugly stuff I guess it is
>reasonable to consider it. If not the debugger will have
>to live without it.
>
>I already merged all the changes that looked good (and where I was cc'ed) 
>for x86-64 now. Some patches need changes, and I guess with that
>feedback the i386 part can be similarly adjusted.
>
>-Andi
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

