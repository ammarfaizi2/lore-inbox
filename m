Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVACMmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVACMmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVACMmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 07:42:32 -0500
Received: from mail.tmr.com ([216.238.38.203]:2762 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261347AbVACMmT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 07:42:19 -0500
Message-ID: <41D9402A.2080405@tmr.com>
Date: Mon, 03 Jan 2005 07:52:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: William Lee Irwin III <wli@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de>
In-Reply-To: <20050103004551.GK4183@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Jan 02, 2005 at 04:30:11PM -0800, William Lee Irwin III wrote:
> 
>>Adrian Bunk wrote:
>>
>>>>The main advantage with stable kernels in the good old days (tm) when 4 
>>>>and 6 were even numbers was that you knew if something didn't work, and 
>>>>upgrading to a new kernel inside this stable kernel series had a 
>>>>relatively low risk of new breakages. This meant one big migration every 
>>>>few years and relatively easy upgrades between stable series kernels.
>>>>Nowadays in 2.6, every new 2.6 kernel has several regressions compared 
>>>>to the previous one, and additionally obsolete but used code like 
>>>>ipchains and devfs is scheduled for removal making upgrades even harder 
>>>>for many users.
>>
>>On Sun, Jan 02, 2005 at 05:49:08PM -0500, Bill Davidsen wrote:
>>
>>>And there you have my largest complaint with the new model. If 2.6 is 
>>>stable, it should not have existing features removed just because 
>>>someone has a new wet dream about a better but incompatible way to do 
>>>things. I expect working programs to be deliberately broken in a 
>>>development tree, but once existing features are removed there simply is 
>>>no stable set of features.
>>
>>The presumption is that these changes are frivolous. This is false.
>>The removals of these features are motivated by their unsoundness,
>>and those removals resolve real problems. If they did not do so, they
>>would not pass peer review.
> 
> 
> The netfilter people plan to remove ipfwadm and ipchains before 2.6.11 .
> 
> This is legacy code that makes their development sometimes a bit harder, 
> but AFAIK ipchains in 2.6.10 doesn't suffer from any serious real 
> problems.

This is exactly the type of change I meant. Anyone who has put 2.6 on an 
older distro is probably still using ipchains. I can't imagine anyone 
still using ipfwadm, but why didn't it go away during the 2.5 phase, 
when everyone would have said that it was expected behaviour.

And there have been repeated suggestions the cryptoloop go away, which 
was one of the reasons to go to 2.6 in the first place. I spent a year 
during 2.5 time convincing {company} that having laptops around without 
crypto was a very bad thing, and that cryptoloop was far better even if 
professionals could break the security, casual theves would be less 
likely to do so. They are NOT going to redo the setup on every laptop to 
use {something else}, they would ignore any future security issues in 
thge kenrel because they can't send out a "boot this CD" new kernel upgrade.

What's next, ext2? jfs? Features should be added in a stable tree, not 
deleted. "sometimes a bit harder" hardly sounds like a great reason to 
break existing  systems.
> 
> 
>>Adrian Bunk wrote:
>>
>>>>There's the point that most users should use distribution kernels, but 
>>>>consider e.g. that there are poor souls with new hardware not supported 
>>>>by the 3 years old 2.4.18 kernel in the stable part of your Debian 
>>>>distribution.
>>
>>On Sun, Jan 02, 2005 at 05:49:08PM -0500, Bill Davidsen wrote:
>>
>>>The stable and development kernel model worked for a decade, partly 
>>>because people could build on a feature set and not have that feature 
>>>just go away, leaving the choice of running without fixes or not 
>>>running. Since we manage to support 2.2 and 2.4 (and perhaps even 2.0?) 
>>>I don't see why the definition of "stable" can't simply mean "no 
>>>deletions from the feature set" and let new features come in for those 
>>>who want them. Absent that 2.4 will be the last stable kernel, in the 
>>>sense that features won't be deliberately broken or removed.
>>
>>I can't speak for anyone during the times of more ancient Linux history;
>>however, developers' dissatisfaction with the development model has been
>>aired numerous times in certain fora. It has not satisfactorily served
>>developers or users. Users are locked into distro kernels for
>>incompatible extensions, and developers are torn between multiple
>>codebases.

> 
> 
> At least on Debian, ftp.kernel.org kernels work fine.
> 
> 
>>This fragmentation of programmer effort is trivially recognizable as
>>counterproductive. A single focal point for programmer effort is far
>>superior for a development model. If the standard of stability is not
>>passed then the code is not ready to be included in any kernel. Then
>>the distinction is lost, and each of the fragmented codebases gets a
>>third-class effort, and a spurious expenditure of effort is wasted on
>>porting fixes and features across numerous different codebases.
>>...

Can you give an example of some feature which had to be removed because
no progress could be made while it was present? Remember that I am not
advocating "no new features," nor is anyone else AFAIK, just no removed
features. Developers may have had multiple streams for new stuff, but
the argument that this is now cured is BS. We have (major) lines
of -mm -ck, -aa and -ac, just to name the ones I've tried in the
last 3-4 months, not to mention Nick Piggin patch sets which come
and go in -mm, and Reiser_N patches.

In other words, I don't buy that keeping features is holding people
back, nor that there aren't many parallel development lines of
new patches.

> 
> 
> My impression is that currently 2.4 doesn't take that much time of 
> developers (except for Marcelo's), and that it's a quite usable and 
> stable kernel.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
