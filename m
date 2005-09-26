Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751653AbVIZQDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbVIZQDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbVIZQDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:03:39 -0400
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:15551 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S1751652AbVIZQDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:03:39 -0400
From: Michael Bellion <mbellion@hipac.org>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Subject: Re: [ANNOUNCE] Release of nf-HiPAC 0.9.0
Date: Mon, 26 Sep 2005 18:03:27 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200509260445.46740.mbellion@hipac.org> <200509261638.12731.mbellion@hipac.org> <43380E4A.1060604@cs.aau.dk>
In-Reply-To: <43380E4A.1060604@cs.aau.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261803.28150.mbellion@hipac.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Mon, 26 Sep 2005 18:03:28 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.32.0.6; VDF 6.32.0.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > But your performance tests have a serious flaw:
> > You construct your rule set by creating one rule for each entry in your
> > packet header trace. This results in an completely artificial rule set
> > that creates a lot of redundancy in the nf-HiPAC lookup data structure
> > making it much larger than the Compact Filter data structure.
>
> Yes, it was intended to be a worst case for our scheme (not realistic
> but worst case)..

Sorry, but this is far away from the worst case for your scheme. Actually it 
is a quite good case for your compiler, because every rule is fully specified 
(meaning there are no wildcards in any rule) and there are no ranges or masks 
involved. 
Try using a mixed rule set that contains rules that only specify certain 
dimensions and have wildcards on the other dimensions. Try using rules with 
ranges and masks.
Try using overlapping rules, meaning rules that completely or partly overlap 
other rules in certain dimensions.
This will make your data structure grow!

> > I am currently working on a new improved version of the algorithm used in
> > nf-HiPAC. The new algorithmic core will reduce memory usage while at the
> > same time improving the running time of insert and delete operations. The
> > lookup performance will be improved too, especially for bigger rulesets.
> > The concepts and the design are already developed, but the implementation
> > is still in its early stages.
> >
> > The new algorithmic core will make sure that the lookup data structure in
> > the kernel is always fully optimized while at the same time allowing very
> > fast dynamic updates.
> >
> > At that point Compact Filter will not be able to win in any performance
> > test against  nf-HiPAC anymore, simply because there is no way to
> > optimize the lookup data structure any further.
>
> Well, you already said this last time we had exchanged some mails
> (it was more than one year ago if I count well).

Yes, you are right. The HiPAC project has gone through some tough times over 
the last 2 years. With MARA Systems the HiPAC Project has finally found a 
strong partner that is fully committed to the concept of Open Source 
Software. This allows me to continue the development of HiPAC under the GNU 
GPL license.

> Anyway, I doubt you can get something that you can update dynamically
> AND small in size following your way of doing. But, prove me wrong and
> I'll be happy. :)

Ok, I'll do that :)

Regards,
    +---------------------------+
    |      Michael Bellion      |
    |   <mbellion@hipac.org>    |
    +---------------------------+

