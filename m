Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVAYT67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVAYT67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVAYT6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:58:00 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63182 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261928AbVAYT4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:56:03 -0500
Message-ID: <41F6A45D.1000804@comcast.net>
Date: Tue, 25 Jan 2005 14:56:13 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>	 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>	 <41F6604B.4090905@tmr.com>	 <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>	 <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net>	 <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>	 <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com>
In-Reply-To: <d120d50005012510571d77338d@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Dmitry Torokhov wrote:
> On Tue, 25 Jan 2005 13:37:10 -0500, John Richard Moser
> <nigelenki@comcast.net> wrote:
> 
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>
>>Linus Torvalds wrote:
>>
>>>On Tue, 25 Jan 2005, John Richard Moser wrote:
>>>
>>>
>>>>It's kind of like locking your front door, or your back door.  If one is
>>>>locked and the other other is still wide open, then you might as well
>>>>not even have doors.  If you lock both, then you (finally) create a
>>>>problem for an intruder.
>>>>
>>>>That is to say, patch A will apply and work without B; patch B will
>>>>apply and work without patch A; but there's no real gain from using
>>>>either without the other.
>>>
>>>
>>>Sure there is. There's the gain that if you lock the front door but not
>>>the back door, somebody who goes door-to-door, opportunistically knocking
>>>on them and testing them, _will_ be discouraged by locking the front door.
>>>
>>
>>In the real world yes.  On the computer, the front and back doors are
>>half-consumed by a short-path wormhole that places them right next to
>>eachother, so not really.  :)
>>
> 
> 
> Then one might argue that doing any security patches is meaningless
> because, as with bugs, there will always be some other hole not
> covered by both A and B so why bother?
> 

I'm not talking about bugs, I'm talking about mitigation of unknown bugs.

You have to remember that I think mostly in terms of proactive security.
 If there's a buffer overflow, temp file race condition, code injection
or ret2libc in a userspace program, it can be stopped.  this narrows
down what exploits an attacker can actually use.

This puts pressure on the attacker; he has to find a bug, write an
exploit, and find an opportunity to use it before a patch is written and
applied to fix the exploit.  If say 80% of exploits are suddenly
non-exploitable, then he's left with mostly very short windows that are
far and few, and thus may be beyond his level of UNION(task->skill,
task->luck) in many cases.

Thus, by having fewer exploits available, fewer successful attacks
should happen due to the laws of probability.  So the goal becomes to
fix as many bugs as possible, but also to mitigate the ones we don't
know about.  To truly mitigate any security flaw, we must make a
non-circumventable protection.

If you can circumvent protection A by simply using attack B* to disable
protection A to do more interesting attack A*, then protection A is
smoke and mirrors.  If you have protection B that stops B*, but can be
circumvented by A*, then deploying A and B will reciprocate and prevent
both A* and B*, creating a protection scheme that can't be circumvented.

In this context, it doesn't make sense to deploy a protection A or B
without the companion protection, which is what I meant.  You're
thinking of fixing specific bugs; this is good and very important (as
effective proactive security BREAKS things that are buggy), but there is
a better way to create a more secure environment.  Fixing the bugs
increases the quality of the product, while adding protections makes
them durable enough to withstand attacks targetting their own flaws.

Try reading through (shameless plug)
http://www.ubuntulinux.org/wiki/USNAnalysis and then try to understand
where I'm coming from.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9qRchDd4aOud5P8RAv74AJ9zvphwU8c7tX1bTa1YwofVJYxligCbBkgN
hLg9othWu96Oc+w47PI7+b0=
=XLFq
-----END PGP SIGNATURE-----
