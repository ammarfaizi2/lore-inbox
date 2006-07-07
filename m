Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWGGXg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWGGXg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWGGXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:36:28 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:29586 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932410AbWGGXg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:36:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 7 Jul 2006 16:36:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060708000531.410cd672@werewolf.auna.net>
Message-ID: <Pine.LNX.4.64.0607071602160.2654@alien.or.mcafeemobile.com>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com> <m34pxt8emn.fsf@defiant.localdomain>
 <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
 <20060708000531.410cd672@werewolf.auna.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1795850513-720723553-1152314192=:2654"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1795850513-720723553-1152314192=:2654
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 8 Jul 2006, J.A. Magall=C3=B3n wrote:

> On Fri, 7 Jul 2006 17:22:31 -0400, "linux-os \(Dick Johnson\)" <linux-os@=
analogic.com> wrote:
>
>>
>> On Fri, 7 Jul 2006, Linus Torvalds wrote:
>>
>>>
>>> On Fri, 7 Jul 2006, linux-os (Dick Johnson) wrote:
>>>>
>>>> Now Linus declares that instead of declaring an object volatile
>>>> so that it is actually accessed every time it is referenced, he wants
>>>> to use a GNU-ism with assembly that tells the compiler to re-read
>>>> __every__ variable existing im memory, instead of just one. Go figure!
>>>
>>> Actually, it's not just me.
>>>
>>> Read things like the Intel CPU documentation.
>>>
>>> IT IS ACTIVELY WRONG to busy-loop on a variable. It will make the CPU
>>> potentially over-heat, causing degreaded performance, and you're simply
>>> not supposed to do it.
>>
>> This is a bait and switch argument. The code was displayed to show
>> the compiler output, not an example of good coding practice.
>>
>
> volatile means what it means, is usefull and is right. If it is used
> in kernel for other things apart from what it was designed for it is
> kernel or programmer responsibility. It does not mention nothing about
> locking.

(looking at your code ...)
I think you guys mixed the concepts about *if* a memory access happens=20
(volatile), and *where* the memory access happens (barrier).
As far as kernel coding goes (or MT userspace), if you happen to care *if*
a memory access happens, you probably want to care even *where* the memory=
=20
access happens. And modern CPUs and compilers do not respect the WYSIWYG=20
property ;)
This is not always true (*if* -> *where*), but it's very frequent.
And using "volatile" can make your code work in some cases, and misbehave=
=20
in others.
Can we now all move on to a more refreshing "C++ kernel rewrite" thread :)



- Davide
--1795850513-720723553-1152314192=:2654--
