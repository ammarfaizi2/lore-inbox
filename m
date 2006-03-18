Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWCRXOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWCRXOx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWCRXOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:14:52 -0500
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:63653 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S1751117AbWCRXOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:14:52 -0500
Message-ID: <441C943A.6090307@tremplin-utc.net>
Date: Sun, 19 Mar 2006 00:14:02 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
References: <20060318142827.419018000@localhost.localdomain>	 <20060318142830.607556000@localhost.localdomain>	 <20060318120728.63cbad54.akpm@osdl.org>	 <1142712975.17279.131.camel@localhost.localdomain>	 <20060318123102.7d8c048a.akpm@osdl.org> <9a8748490603181245v47b9f0a5v1ef252f91c30a7d2@mail.gmail.com>
In-Reply-To: <9a8748490603181245v47b9f0a5v1ef252f91c30a7d2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-2.0.2 (reserv6.univ-lille1.fr [193.49.225.20]); Sun, 19 Mar 2006 00:14:06 +0100 (CET)
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

18.03.2006 21:45, Jesper Juhl wrote/a écrit:
> On 3/18/06, Andrew Morton <akpm@osdl.org> wrote:
>> Thomas Gleixner <tglx@linutronix.de> wrote:
>>> On Sat, 2006-03-18 at 12:07 -0800, Andrew Morton wrote:
>>>
>>>> From my reading, 2.4's sys_setitimer() will normalise the incoming timeval
>>>> rather than rejecting it.  And I think 2.6.13 did that too.
>>>>
>>>> It would be bad of us to change this behaviour, even if that's what the
>>>> spec says we should do - because we can break existing applications.
>>>>
>>>> So I think we're stuck with it - we should normalise and then accept such
>>>> timevals.  And we should have a big comment explaining how we differ from
>>>> the spec, and why.
>>> Hmm. How do you treat a negative value ?
>>>
>> In the same way as earlier kernels did!
>>
>> Unless, of course, those kernels did something utterly insane.  In that
>> case we'd need to have a little think.
>>
> 
> If the change only affects buggy apps (as Thomas says), then it seems
> completely obvious to me that the change should be made.
> 
> 1. We'll be in compliance with the spec
> 2. Buggy applications will actually be helped by this by getting a
> clear error instead of undefined behaviour silently hiding the fact
> that they are buggy.
> 3. Correct applications are unaffected.
4. Applications written for an OS which respects the spec (and using 
this particular rule) will finally work on Linux.

Well, I'd vote for just making Linux conform to the spec as soon as 
someone notices a non-compliance. However, as this rule doesn't play 
well with a stable ABI, a "trade-off" solution could consists in:
- Keeping the old behavior for now and generate a printk() each time 
this code path is entered;
- Add an entry to feature-removal-schedule.txt saying Linux will start 
conforming to the spec next year.

Eric
