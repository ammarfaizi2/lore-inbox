Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbRGXPik>; Tue, 24 Jul 2001 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbRGXPiU>; Tue, 24 Jul 2001 11:38:20 -0400
Received: from sncgw.nai.com ([161.69.248.229]:39617 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S267570AbRGXPiR>;
	Tue, 24 Jul 2001 11:38:17 -0400
Message-ID: <XFMail.20010724084134.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <p05100306b7829ca20739@[10.0.0.49]>
Date: Tue, 24 Jul 2001 08:41:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: user-mode port 0.44-2.4.7
Cc: Jan Hubicka <jh@suse.cz>, linux-kernel@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net,
        Jeff Dike <jdike@karaya.com>, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 24-Jul-2001 Jonathan Lundell wrote:
> At 3:51 PM -0700 2001-07-23, Linus Torvalds wrote:
>>On Mon, 23 Jul 2001, Jonathan Lundell wrote:
>>>
>>>  If jiffies were not volatile, this initializing assignment and the
>>>  test at the end could be optimized away, leaving an unconditional
>>>  "return 0". A lock is of no help.
>>
>>Right.
>>
>>We want optimization barriers, and there's an explicit "barrier()"  thing
>>for Linux exactly for this reason.
>>
>>For historical reasons "jiffies" is actually marked volatile, but at least
>>it has reasonably good semantics with a single-data item. Which is not to
>>say I like it. But grep for "barrier()" to see how many times we make this
>>explicit in the algorithms.
>>
>>And really, THAT is my whole point. Notice in the previous mail how I used
>>"volatile" when it was part of the _algorithm_. You should not hide
>>algorithmic choices in your data structures. You should make them
>>explicit, so that when you read the code you _see_ what assumptions people
>>make.
> 
> OK, sure, that's fine. Better than barrier() in some respects, too. 
> Namely, 1) volatile is portable C; barrier() isn't (not that that's 
> much of an issue for compiling Linux), and 2) volatile can be 
> specific to a variable, unlike the indiscriminate barrier(), which 
> forces a reload of everything that might be cached (OK, not a big 
> deal for IA32, but nontrivial for many-register architectures). One 
> could imagine a more specific barrier(jiffies) syntax, I suppose, but 
> the volatile cast is nice, restricting the effect not only to the 
> single variable but to the single reference to a single variable.

One more thing, with volatile you specify it one time ( declaration time ),
while with barrier() you've to spread inside the code tons of such macro
everywhere you touch the variable.



- Davide

