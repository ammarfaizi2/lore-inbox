Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312275AbSDEEuK>; Thu, 4 Apr 2002 23:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312277AbSDEEuA>; Thu, 4 Apr 2002 23:50:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7181 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312275AbSDEEtx>; Thu, 4 Apr 2002 23:49:53 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [QUESTION] How to use interruptible_sleep_on() without races ?
Date: Fri, 5 Apr 2002 04:49:28 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a8jaco$avc$1@penguin.transmeta.com>
In-Reply-To: <20020404185232.B27209@bougret.hpl.hp.com> <E16tKGi-0007Sy-00@the-village.bc.nu> <20020404190848.C27209@bougret.hpl.hp.com>
X-Trace: palladium.transmeta.com 1017982187 9704 127.0.0.1 (5 Apr 2002 04:49:47 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Apr 2002 04:49:47 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020404190848.C27209@bougret.hpl.hp.com>,
Jean Tourrilhes  <jt@bougret.hpl.hp.com> wrote:
>On Fri, Apr 05, 2002 at 04:20:04AM +0100, Alan Cox wrote:
>> > 
>> > 	I looked at it in every possible way, and I don't see how it
>> > is possible to use safely interruptible_sleep_on(). And I wonder :
>> 
>> It isnt for interrupt stuff - its going back to the old kernel behaviour
>> when it used to be usable
>
>	So, maybe it would be a nice idea to remove it from the 2.5.X
>kernel to force a "spring cleanup" of the old code. If it's no longer
>usable and only confusing, it should be purged...

It's still usable, but under rather specific conditions, namely:
 - both sleeper and waker in process context and with BKL held.
 - OR if missing a wakeup isn't a horrible problem.

And there does seem to be a lot of legacy users out there.

I wouldn't mind a spring cleaning, but the fact is that right now in
2.5.x I'd rather have driver writers wake up to the fact that we had a
spring cleaning in the block layer several months ago, rather than
introduce a new one ;)

		Linus
