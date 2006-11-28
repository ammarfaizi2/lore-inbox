Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935972AbWK1Rlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935972AbWK1Rlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 12:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935974AbWK1Rlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 12:41:42 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:63353 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S935972AbWK1Rlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 12:41:40 -0500
Message-ID: <456C74F7.3060902@cfl.rr.com>
Date: Tue, 28 Nov 2006 12:42:15 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Entropy Pool Contents
References: <ek2nva$vgk$1@sea.gmane.org> <456B3483.4010704@cfl.rr.com> <ekfehh$kbu$1@taverner.cs.berkeley.edu> <456B4CD2.7090208@cfl.rr.com> <ekfifg$n41$1@taverner.cs.berkeley.edu>
In-Reply-To: <ekfifg$n41$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Nov 2006 17:41:51.0649 (UTC) FILETIME=[7CBEA110:01C71314]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14840.003
X-TM-AS-Result: No--11.391400-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, please don't remove the Cc: list.

David Wagner wrote:
> Sorry, but I disagree with just about everything you wrote in this
> message.  I'm not committing any logical fallacies.  I'm not assuming
> it works because it would be a bug if it didn't; I'm just trying to

>> Nope, I don't think so.  If they could, that would be a security hole,
>> but /dev/{,u}random was designed to try to make this impossible, assuming
>> the cryptographic algorithms are secure.

That sure reads to me like you were saying that it would be a security 
hole, so that can't be how it works.   Maybe I just misinterpreted, but 
at any rate it is a non sequitur, so let's move on.


> help you understand the intuition.  I have looked at the algorithm
> used by /dev/{,u}random, and I am satisfied that it is safe to feed in
> entropy samples from malicious sources, as long as you don't bump up the
> entropy counter when you do so.  Doing so can't do any harm, and cannot
> reduce the entropy in the pool.  However, there is no guarantee that
> it will increase the entropy.  If the adversary knows what bytes you
> are feeding into the pool, then it doesn't increase the entropy count,
> and the entropy estimate should not be increased.

I still don't see how feeding tons of zeros ( or some other carefully 
crafted sequence ) in will not decrease the entropy of the pool ( even 
if it does so in a way that is impossible to predict ), but assuming it 
can't, what good does a non root user do by writing to random?  If it 
does not increase the entropy estimate, and it may not actually increase 
the entropy, why bother allowing it?

>   - Whether you automatically bump up the entropy estimate when
>     root users write to /dev/random is a design choice where you could
>     reasonably go either way.  On the one hand, you might want to ensure
>     that root has to take some explicit action to allege that it is
>     providing a certain degree of entropy, and you might want to insist
>     that root tell /dev/random how much entropy it added (since root
>     knows best where the data came from and how much entropy it is likely
>     to contain).  On the other hand, you might want to make it easier
>     for shell scripts to add entropy that will count towards the overall
>     entropy estimate, without requiring them to go through weird
>     contortions to call various ioctl()s.  I can see arguments both
>     ways, but the current behavior seems reasonable and defensible.
> 

I would favor the latter argument since the entropy estimate is only 
that: an estimate.  Trying to come up with an estimate of the amount of 
entropy that will be added to the existing unknown pool after it is 
stirred by the new data seems to be an exercise in futility.


