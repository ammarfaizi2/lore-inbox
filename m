Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVCIVXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVCIVXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVCIUdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:33:23 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16523 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262393AbVCIUUD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:20:03 -0500
Message-ID: <422F5BA5.3000604@tmr.com>
Date: Wed, 09 Mar 2005 15:25:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] -stable, how it's going to work.
References: <20050309072833.GA18878@kroah.com><20050309072833.GA18878@kroah.com> <m1sm35w3am.fsf@muc.de>
In-Reply-To: <m1sm35w3am.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://localhost/blogAndi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> 
>>Rules on what kind of patches are accepted, and what ones are not, into
>>the "-stable" tree:
>> - It must be obviously correct and tested.
>> - It can not bigger than 100 lines, with context.
> 
> 
> This rule seems silly. What happens when a security fix needs 150 lines? 
> 
> Better maybe a rule like "The patch should be the minimal and safest 
 > change to fix an issue". But see below for an exception.

I was willing to accept that there might be an exploitable security 
issue taking more than 100 lines to plug the hole (remember, check your 
elegance at the door), and I like your suggestion regardless of length. 
But I don't think any more exceptions are desirable. As you said, "see 
below."
> 
>> - It must fix only one thing.
>> - It must fix a real bug that bothers people (not a, "This could be a
>>   problem..." type thing.)
>> - It must fix a problem that causes a build error (but not for things
>>   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>>   security issue, or some "oh, that's not good" issue.  In short,
>>   something critical.
>> - No "theoretical race condition" issues, unless an explanation of how
>>   the race can be exploited.
>> - It can not contain any "trivial" fixes in it (spelling changes,
>>   whitespace cleanups, etc.)
>> - It must be accepted by the relevant subsystem maintainer.

I have the feeling that drivers will need some special consideration, 
like allowing additions to an existing blacklist to prevent "almost 
working" with similar but not identical chips and the like.

> One rule I'm missing:
> 
> - It must be accepted to mainline. 
> 
> That is what big enterprise distributions often require and I think
> it's a good rule. Otherwise you risk code and feature set drift
> and we don't want to repeat the 2.4 mistakes again where some 
> subsystems had more fixes in 2.4 than 2.6.

Right problem, wrong solution. What you is that SOME solution go in 
mainline. My example above of adding a chipset to a blacklist is a 
perfect case, where you want the chipset to become supported, not long 
term "officially unsupported." And band-aids like using the BKL or long 
linear searches just to prevent something which causes a hard hang or 
oops should not be blessed and included in mainline.

I know you understand this, I just think it's worth saying more clearly.
> 
> Also your rules encourage to do different patches for -stable
> (e.g. with less comment changes etc.) than for mainline. I don't
> think that's a very good thing. Sometimes it is unavoidable
> and sometimes the mainline patches are just too big and intrusive,
> but in general it's imho best to apply the same patches
> to mainline and backport trees.  This has also the advantage
> that the patch is best tested as possible; slimmed down patches
> usually have a risk of malfunction.

Different in function as well as style. Testing complex patches can be 
done in -mm, reliable is often easier than optimal.

> So in general there should be a preference to apply the same
> patch as mainline, unless it is very big.

I can't imagine anyone not using a good patch in mainline, I can imagine 
some really brute force patches in stable, because they are easier to 
vat than a really correct solution.
> 
> 
>> - Security patches will be accepted into the -stable tree directly from
>>   the security kernel team, and not go through the normal review cycle.
>>   Contact the kernel security team for more details on this procedure.
> 
> 
> This also sounds like a bad rule. How come the security team has more
> competence to review patches than the subsystem maintainers?  I can
> see the point of overruling maintainers on security issues when they
> are not responsive, but if they are I think the should be still the
> main point of contact.

I was actually thinking that the normal patch might want a fast path in 
practice. Some things are clearly wrong, like off by one errors in array 
handling and the like, using pointers to freed data or which could be 
null, that kind of thing is pretty unsubtle, and I would think would 
need fewer eyes-on. But until we see how this works in practice, let's 
not fix it. The stable kernel should have a stable process, which should 
not be changed unless there's a demonstrated problem.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
