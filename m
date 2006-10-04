Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWJDJON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWJDJON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJDJON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:14:13 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:6672
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030639AbWJDJOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:14:12 -0400
Message-Id: <452397C8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 10:15:20 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Eric Rannaud" <eric.rannaud@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       "Chandra Seetharaman" <sekharan@us.ibm.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <nagar@watson.ibm.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
 <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301237460.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Linus Torvalds <torvalds@osdl.org> 30.09.06 21:54 >>>
>On Sat, 30 Sep 2006, Eric Rannaud wrote:
>> 
>> (2) is introduced by d94a041519f3ab1ac023bf917619cd8c4a7d3c01
>> [PATCH] taskstats: free skb, avoid returns in send_cpu_listeners,
>> Signed-off-by: Shailabh Nagar.
>> The kernel freezes after a BUG (no sysrq magic).
>
>This one looks like the real problem is that totally broken stack unwinder 
>again. 

I can only support Andi here - I disagree that the unwinder is totally
broken, and most code fragments you presented during the thread
to support your statements were actually not even introduced by the
unwinding patches. While you ask Andi to look at the old code, it
seems to me you haven't really looked at the new one.

>Andi, I really think that Dwarf unwinder needs to go. The code is totally 
>unreadable, and it's clearly fragile as hell. It doesn't check that the 
>pointers it gets are even remotely valid, but just follows them as if they 
>were.

Rather than ripping out the unwinder, anyone not liking the way it
works or it is implemented can easily just disable it - I always thought
that's what config options are for.

>The whole unwinder seems buggier than any bug it can ever unwind would be. 
>Really. Let's go back to the sane "try our best, don't guarantee anything, 
>but at least don't make things worse!" old code.
>
>The people who wrote that crap (and yes, Andi, I mean apparently you and 
>Jan Beulich) really _have_ to get his act together. It's not just 
>unreadable and obviously buggy, it's so scarily that it's hard to even 
>talk about it. Lookie here:
>
>	#define HANDLE_STACK(cond) \
>	        do while (cond) { \
>	                unsigned long addr = *stack++; \
>
>What the F*CK! "do while(cond) {" ???? 
>
>Please. Somebody just rip out all this crap. I beg of you.

One example of you blaming the unwind code for something that
was all there before. (I agree that I wrote that code, but a lot
earlier, and in order to replace what I could call crap: repeating
the same code sequence three times, making it necessary to apply 
any adjustments to it in three places).

Also, I'd really like to understand if we're on a technical discussion
here, or whether we're just trying to exchange emotions.

Jan
