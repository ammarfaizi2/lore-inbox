Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVAYVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVAYVPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVAYVNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:13:55 -0500
Received: from alog0154.analogic.com ([208.224.220.169]:27776 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262131AbVAYVHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:07:33 -0500
Date: Tue, 25 Jan 2005 16:05:48 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: John Richard Moser <nigelenki@comcast.net>
cc: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <41F6A45D.1000804@comcast.net>
Message-ID: <Pine.LNX.4.61.0501251542290.8986@chaos.analogic.com>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> 
 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>  <41F6604B.4090905@tmr.com>
  <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>  <41F6816D.1020306@tmr.com>
 <41F68975.8010405@comcast.net>  <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>
  <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com>
 <41F6A45D.1000804@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
>
> Dmitry Torokhov wrote:
>> On Tue, 25 Jan 2005 13:37:10 -0500, John Richard Moser
>> <nigelenki@comcast.net> wrote:
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>>
>>> Linus Torvalds wrote:
>>>
>>>> On Tue, 25 Jan 2005, John Richard Moser wrote:
>>>>
>>>>
>>>>> It's kind of like locking your front door, or your back door.  If one is
>>>>> locked and the other other is still wide open, then you might as well
>>>>> not even have doors.  If you lock both, then you (finally) create a
>>>>> problem for an intruder.
>>>>>
>>>>> That is to say, patch A will apply and work without B; patch B will
>>>>> apply and work without patch A; but there's no real gain from using
>>>>> either without the other.
>>>>
>>>>
>>>> Sure there is. There's the gain that if you lock the front door but not
>>>> the back door, somebody who goes door-to-door, opportunistically knocking
>>>> on them and testing them, _will_ be discouraged by locking the front door.
>>>>
>>>
>>> In the real world yes.  On the computer, the front and back doors are
>>> half-consumed by a short-path wormhole that places them right next to
>>> eachother, so not really.  :)
>>>
>>
>>
>> Then one might argue that doing any security patches is meaningless
>> because, as with bugs, there will always be some other hole not
>> covered by both A and B so why bother?
>>
>
> I'm not talking about bugs, I'm talking about mitigation of unknown bugs.
>
> You have to remember that I think mostly in terms of proactive security.
> If there's a buffer overflow, temp file race condition, code injection
> or ret2libc in a userspace program, it can be stopped.  this narrows
> down what exploits an attacker can actually use.
>
> This puts pressure on the attacker; he has to find a bug, write an
> exploit, and find an opportunity to use it before a patch is written and
> applied to fix the exploit.  If say 80% of exploits are suddenly
> non-exploitable, then he's left with mostly very short windows that are
> far and few, and thus may be beyond his level of UNION(task->skill,
> task->luck) in many cases.
>
> Thus, by having fewer exploits available, fewer successful attacks
> should happen due to the laws of probability.  So the goal becomes to
> fix as many bugs as possible, but also to mitigate the ones we don't
> know about.  To truly mitigate any security flaw, we must make a
> non-circumventable protection.
>

So you intend to make so many changes to the kernel that a
previously thought-out exploit may no longer be workable?

A preemptive strike, so to speak? No thanks, to quote Frank
Lanza of L3 communications; "Better is the enemy of good enough."

> If you can circumvent protection A by simply using attack B* to disable
> protection A to do more interesting attack A*, then protection A is
> smoke and mirrors.  If you have protection B that stops B*, but can be
> circumvented by A*, then deploying A and B will reciprocate and prevent
> both A* and B*, creating a protection scheme that can't be circumvented.
>

It makes sense to add incremental improvements to security as
part of the normal maturation of a product. It does not make
sense to dump a new pile of snakes in the front yard because
that might keep the burglars away.

> In this context, it doesn't make sense to deploy a protection A or B
> without the companion protection, which is what I meant.  You're
> thinking of fixing specific bugs; this is good and very important (as
> effective proactive security BREAKS things that are buggy), but there is
> a better way to create a more secure environment.  Fixing the bugs
> increases the quality of the product, while adding protections makes
> them durable enough to withstand attacks targetting their own flaws.
>

Adding protections for which no known threat exists is a waste of
time, effort, and adds to the kernel size. If you connect a machine
to a network, it can always get hit with so many broadcast packets
that it has little available CPU time to do useful work. Do we
add a network throttle to avoid this? If so, then you will hurt
somebody's performance on a quiet network. Everything done in
the name of "security" has its cost. The cost is almost always
much more than advertised or anticipated.

> Try reading through (shameless plug)
> http://www.ubuntulinux.org/wiki/USNAnalysis and then try to understand
> where I'm coming from.
>

This isn't relevant at all. The Navy doesn't have any secure
systems connected to a network to which any hackers could connect.
The TDRS communications satellites provide secure channels
that are disassembled on-board. Some ATM-slot, after decryption
is fed to a LAN so the sailors can have an Internet connection
for their lap-tops. The data took the same paths, but it's
completely independent and can't get mixed up no matter how
hard a hacker tries.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
