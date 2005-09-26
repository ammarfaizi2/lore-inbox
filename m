Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751666AbVIZQdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbVIZQdn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbVIZQdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:33:43 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:25538 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S1751666AbVIZQdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:33:43 -0400
Message-ID: <43382271.90400@cs.aau.dk>
Date: Mon, 26 Sep 2005 18:31:45 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Bellion <mbellion@hipac.org>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
References: <200509260445.46740.mbellion@hipac.org> <200509261638.12731.mbellion@hipac.org> <43380E4A.1060604@cs.aau.dk> <200509261803.28150.mbellion@hipac.org>
In-Reply-To: <200509261803.28150.mbellion@hipac.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bellion wrote:
> 
> Sorry, but this is far away from the worst case for your scheme. Actually it 
> is a quite good case for your compiler, because every rule is fully specified 
> (meaning there are no wildcards in any rule) and there are no ranges or masks 
> involved. 
> Try using a mixed rule set that contains rules that only specify certain 
> dimensions and have wildcards on the other dimensions. Try using rules with 
> ranges and masks.
> Try using overlapping rules, meaning rules that completely or partly overlap 
> other rules in certain dimensions.
> This will make your data structure grow!

I think you misunderstood our experiment. In fact, we were trying to
generate as much possible different singletons on the domain (each of
our rule was the header of a packet which have not been seen before),
because if we can group these rules into intervals, then our scheme is
having some advantages.

We were using IDD (Interval Decision Diagrams) which is a kind of
extended BDD (Binary Decision Diagrams) where you take your decision by
looking at a partition of the possible values of the variable. For
example, looking at the value x in [0,1024] where [0,128] leads to one
node in the decision tree, [129,256] to another and [257,1024] to a last
one. More this partition is fragmented more you increase the size of the
structure. Having a lot of overlap does certainly increase the number of
partitions, but adding singletons is the simplest way to increase the
number of partitions.

Take a look at this paper, maybe you can get some idea for your scheme
(it might be that some hybrid between your ideas and ours can make it):
http://www.cs.aau.dk/~fleury/download/papers/tc04.pdf

> Yes, you are right. The HiPAC project has gone through some tough times over 
> the last 2 years. With MARA Systems the HiPAC Project has finally found a 
> strong partner that is fully committed to the concept of Open Source 
> Software. This allows me to continue the development of HiPAC under the GNU 
> GPL license.

I'm always happy to see a firm funding some Open Source project. So, I
can do anything else but wishing you good luck for the future. :)

> Ok, I'll do that :)

Good. :)

Regards
-- 
Emmanuel Fleury

As usual, goodness hardly puts up a fight.
  -- Calvin & Hobbes (Bill Waterson)
