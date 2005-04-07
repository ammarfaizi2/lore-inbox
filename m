Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVDGJyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVDGJyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVDGJyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:54:22 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:29201 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP id S262410AbVDGJvc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:51:32 -0400
In-Reply-To: <200504062109.51344.blaisorblade@yahoo.it>
References: <20050405164539.GA17299@kroah.com> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <200504062109.51344.blaisorblade@yahoo.it>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <448f048a060cc7db1fc00a489c86ac05@xs4all.nl>
Content-Transfer-Encoding: 8BIT
Cc: jdike@karaya.com, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       stable@kernel.org, Greg KH <gregkh@suse.de>
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Thu, 7 Apr 2005 11:16:08 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 6, 2005, at 9:09 PM, Blaisorblade wrote:

> For Jörn Engel and the issue he opened: at the end of this mail I 
> describe
> another bug caught by 2.95 and not by 3.x.
>
> On Tuesday 05 April 2005 22:18, Renate Meijer wrote:
>> On Apr 5, 2005, at 8:53 PM, Blaisorblade wrote:
>>> On Tuesday 05 April 2005 20:47, Renate Meijer wrote:
>>>> On Apr 5, 2005, at 6:48 PM, Greg KH wrote:
>
>>>> The use of '__' violates compiler namespace.
>>>
>>> Why? The symbol is defined by the compiler itself.
>
>> If a function is prefixed with a double underscore, this implies the
>> function is internal to
>> the compiler, and may change at any time, since it's not governed by
>> some sort of standard.
>> Hence that code may start suffering from bitrot and complaining to the
>> compiler guys won't help.
>
>> They'll just tell you to RTFM.
> Ok, agreed in general. However, the -stable tree is for "current" GCC. 
> Your
> objections would better refer to the fact that the same patch has 
> already
> been merged into the main trunk.
>
> Also, they have no point in doing this, probably. And the __va_copy 
> name was
> used in the draft C99 standard so it's widespread (I've read this on 
> "man 3
> va_copy").


>>>> If 2.95.4 were not easily
>>>> replaced by
>>>> a much better version (3.3.x? 3.4.x) I would see a reason to 
>>>> disregard
>>>> this, but a fix
>>>> merely to satisfy an obsolete compiler?
>>>
>>> Let's not flame, Linus Torvalds said "we support GCC 2.95.3, because
>>> the newer
>>> versions are worse compilers in most cases".
>
>> You make it sound as if you were reciting Ye Holy Scribings. When did
>> Linus Thorvalds say this? In the Redhat-2.96 debacle? Before or after
>> 3.3? I have searched for that quote,

> Sorry for the quote marks, it was a resume of what he said (and from
> re-reading, it's still a correct resume).


>> but could not find it, and having
>> suffered under 3.1.1, I can well understand his wearyness for the
>> earlier versions.
>

> I've read the same kerneltrap article you quote.
>> See
>>
>> http://kerneltrap.org/node/4126, halfway down.
> Ok, read.
>> For the cold, hard facts...
>>
>> http://www.suse.de/~aj/SPEC/
> Linus pointed out that SPEC performances are not a good test case for 
> the
> kernel compilation in that article. Point out a kernel compilation 
> case.


>> <snip>
>>
>>> Consider me as having no opinion on this except not wanting to break
>>> on purpose Debian users.
>>
>> If Debian users are stuck with a pretty outdated compiler, i'd
>> seriously suggest migrating to some
>> other distro which allows more freedom.
> I guess they can, if they want, upgrade some selected packages from 
> newer
> trees, maybe by recompiling (at least, on Gentoo it's trivial, maybe 
> on a
> binary distro like Debian it's harder).

On a binary distro they can recompile, too. Althoughg i'll admit it's 
not something
a newbie should do.
>> If linux itself is holding them
>> back, there's a need for some serious patching.
>
>> If there are serious
>> issues in the gcc compiler, which hinder migration to a more 
>> up-to-date
>> version our efforts should be directed at solving them in that 
>> project,
>> not this.
> Linus spoke about the compiler speed, which isn't such a bad reason.

It may be a reason for folks who do  a lot of development. But that can 
hardly serve
as a "main" reason. Speed of compilation, after all, is a one-time 
thing. Howver, as i've
understood, there are more pressing reasons.

>  He's
> unfair in saying that GCC 3.x does not optimize better than older 
> releases,
> probably; I guess that the compilation flags (I refer to
> -fno-strict-aliasing, which disables some optimizations) make some
> difference, as do the memory barriers (as pointed in the comments).
>
>>> If you want, submit a patch removing Gcc 2.95.3 from supported
>>> versions, and get ready to fight
>>> for it (and probably loose).
>
>> I don't fight over things like that, i'm not interested in politics. I
>> merely point out the problem. And yes.
>> I do think support for obsolete compiler should be dumped in favor of 
>> a
>> more modern version. Especially if that compiler requires invasions of
>> compiler-namespace. The patch, as presented, is not guaranteed to be
>> portable over versions, and may thus introduce another problem with
>> future versions of GCC.

> When and if that will happen, I'll come with an hack.

Ok. And a couple of hacks down the road, and the code will look nice 
and cryptic and a newbie trying to understand what's going on, will 
have a nice set of puzzles to solve.

> UML already has need for some GCC - version specific behaviour
> (see arch/um/kernel/gmon_syms.c on a recent BitKeeper snapshot,
> even -rc1-bk5 has this code).

Perhaps. But i think you'll agree it's not "The way to go".

>>> Also, that GCC has discovered some syscall table errors in UML - I
>>> sent a
>>> separate patch, which was a bit big sadly (in the reduced version,
>>> about 70
>>> lines + description).
>
>> I am not quite sure what is intended here... Please explain.
> I'm reattaching the patch, so that you can look at the changelog (I'm 
> also
> resending it as a separate email so that it is reviewed and possibly 
> merged).
> Basically this is an error in GCC 2 and not in GCC 3:
>
> int [] list = {
>  [0] = 1,
>  [0] = 1
> }
> (I've not tested the above itself, but this should be a stripped down 
> version
> of one of the bugs fixed in the patch).
>
> That sort of code in the UML syscall table is not the safer one - in 
> fact,
> apart this patch for the stable tree, I'm refactoring the UML syscall 
> table
> completely (for 2.6.12 / 2.6.13).
>
> Btw: I've not investigated which one of the two behaviours is the 
> buggy one -
> if you know, maybe you or I can report it.

 From a strict ISO-C point of view, both are. It's a gcc-specific 
"feature" which (agreed) does come in handy sometimes. However it makes 
it quite hard to say which is the buggy version, since the 
"appropriate" behavior
is a question of definition (by the gcc-folks). They may even argue 
that, having changed their minds about it, neither is buggy, but both 
conform to the specifications (for that specific functionality).

That's pretty much the trouble with relying on gcc-extensions: since 
there's no standard, it's difficult to tell what's wrong and what's 
right. I'll dive into it.

Regards,

Renate Meijer.


timeo hominem unius libri

Thomas van Aquino

