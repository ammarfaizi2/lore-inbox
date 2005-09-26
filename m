Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVIZPHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVIZPHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVIZPHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 11:07:43 -0400
Received: from smtp.cs.aau.dk ([130.225.194.6]:62395 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S932212AbVIZPHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 11:07:43 -0400
Message-ID: <43380E4A.1060604@cs.aau.dk>
Date: Mon, 26 Sep 2005 17:05:46 +0200
From: Emmanuel Fleury <fleury@cs.aau.dk>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Bellion <mbellion@hipac.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
References: <200509260445.46740.mbellion@hipac.org> <4337DA7C.2000804@cs.aau.dk> <200509261638.12731.mbellion@hipac.org>
In-Reply-To: <200509261638.12731.mbellion@hipac.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bellion wrote:
> 
> The current version of the algorithm used in nf-HiPAC does not optimize 
> certain aspects of the lookup data structure in order to increase the speed 
> of dynamic rule set updates.
> This means that the lookup data structure is larger than it really needs to be 
> because it contains some unnecessary redundancy.

Could you quantify how much this "unnecessary redundancy" does hit the
size of the filter. Because last time I looked it was quite huge (you
may have improve it). And having a fat kernel does not help in backbones.

> But your performance tests have a serious flaw:
> You construct your rule set by creating one rule for each entry in your packet 
> header trace. This results in an completely artificial rule set that creates 
> a lot of redundancy in the nf-HiPAC lookup data structure making it much 
> larger than the Compact Filter data structure.

Yes, it was intended to be a worst case for our scheme (not realistic
but worst case). We were more interested in comparing the complexity of
the different algorithms better than the efficiency of several
implementations.

I don't consider this as a flaw in our experiment because our goal was
different from having a real proof of concept (kind of having an
empirical evidence of a theoretical result).

> You have to understand that with real world rule sets the size of the computed 
> lookup data structure will not be much different for Compact Filter and 
> nf-HiPAC. This means that when you use real world rule sets there shouldn't 
> be any noticeable difference in lookup performance betweeen Compact Filter 
> and nf-HiPAC.

Might be right, but admit that the big problem of your algorithm is the
size of your data-structure in kernel-space. What you gain in speed, you
loose it in memory. And this IS an issue on routers (IMHO).

> I am currently working on a new improved version of the algorithm used in 
> nf-HiPAC. The new algorithmic core will reduce memory usage while at the same 
> time improving the running time of insert and delete operations. The lookup 
> performance will be improved too, especially for bigger rulesets. The 
> concepts and the design are already developed, but the implementation is 
> still in its early stages.
> 
> The new algorithmic core will make sure that the lookup data structure in the 
> kernel is always fully optimized while at the same time allowing very fast 
> dynamic updates.
> 
> At that point Compact Filter will not be able to win in any performance test 
> against  nf-HiPAC anymore, simply because there is no way to optimize the 
> lookup data structure any further.

Well, you already said this last time we had exchanged some mails
(it was more than one year ago if I count well).

Anyway, I doubt you can get something that you can update dynamically
AND small in size following your way of doing. But, prove me wrong and
I'll be happy. :)

Regards
-- 
Emmanuel Fleury

Ideals are dangerous things. Realities are better.
They wound but they are better.
  -- Oscar Wilde
