Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932859AbWKJQnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbWKJQnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932860AbWKJQnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:43:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932859AbWKJQnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:43:20 -0500
Message-ID: <4554AC12.6040407@osdl.org>
Date: Fri, 10 Nov 2006 08:42:58 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
References: <200611090757.48744.a1426z@gawab.com>	 <20061109090502.4d5cd8ef@freekitty>	 <200611101852.14715.a1426z@gawab.com> <9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com>
In-Reply-To: <9a8748490611100816v573418f4gcd5cbe34d0dd3715@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 10/11/06, Al Boldi <a1426z@gawab.com> wrote:
>> Stephen Hemminger wrote:
> [...]
>> > There are bugfixes which are too big for stable or -rc releases, 
>> that are
>> > queued for 2.6.20. "Bugfix only" is a relative statement. Do you 
>> include,
>> > new hardware support, new security api's, performance fixes.  It 
>> gets to
>> > be real hard to decide, because these are the changes that often cause
>> > regressions; often one major bug fix causes two minor bugs.
>>
>> That's exactly the point I'm trying to get across; the 2.6 dev model 
>> tries to
>> be two cycles in one, dev and stable, which yields an awkward catch22
>> situation.
>>
>> The only sane way forward in such a situation is to realize the 
>> mistake and
>> return to the focused dev-only / stable-only model.
>>
>> This would probably involve pushing the current 2.6 kernel into 2.8 and
>> starting 2.9 as a dev-cycle only, once 2.8 has structurally stabilized.
>>
>
> That was not what I was arguing for in the initial mail at all.
> I think the 2.6 model works very well in general. All I was pushing
> for was a single cycle focused mainly on bug fixes once in a while.
>
I like the current model fine. From a developer point of view:
  * More branches means having to fix and retest a bug more places.
     Workload goes up geometrically with number of versions.
     So most developers end up ignoring fixing more than 2 versions;
     anything more than -current and -stable are ignored.
 * Holding off the tide of changes doesn't work. It just leads to
    massive integration headaches.
 * Many bugs don't show up until kernel is run on wide range of hardware,
    but kernel doesn't get exposed to wide range of hardware and
    applications until after it is declared stable. It is a Catch-22.
    The current stability range  of
           -subtree ... -mm ... 2.6.X ... 2.6.X.Y... 2.6.vendor
     works well for most people. The people it doesn't work for are trying
     to get something for nothing. They want stability and the latest kernel
     at the same time.

There are some things that do need working on:
  * Old bugs die, the bugzilla database needs a 6mo prune out.

  * Bugzilla.kernel.org is underutilized and is only a small sample of the
    real problems. Not sure if it is a training, user, behaviour issue or
    just that bugzilla is crap.

  * Vendor bugs (that could be fixed) aren't forwarded to lkml or bugzilla

  * LKML is an overloaded communication channel, do we need:
      linux-bugs@vger.kernel.org ?

   * Developers can't get (or afford to buy) the new hardware that causes
      a lot of the pain. Just look at the number of bug reports due to new
      flavors of motherboards, chipsets, etc. I spent 3mo on a bug that took
      one day to fix once I got the hardware.

