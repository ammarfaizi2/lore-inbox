Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbVJCV0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbVJCV0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbVJCV0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:26:38 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:18440 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S932630AbVJCV0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:26:36 -0400
DomainKey-Signature: a=rsa-sha1; b=F+C209pMANvN2KQNfvzdiIU5p02DBVbQQw+pSMZm8H+RVfR3J5sxkqgD1xl25+tQXLndqRxUoVKxEGG3HDTtTMqSdOA2WhiQ/dMhV/o2FeV/Zy0DgbCsPX2h475QkhR/mMaSY+6djKgFpy7WxKp/F+2gx1bon8ttSLrTlmcsN3w=; c=nofws; d=rudy.mif.pg.gda.pl; q=dns; s=prime
Date: Mon, 3 Oct 2005 23:26:34 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Luben Tuikov <luben_tuikov@adaptec.com>
cc: andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
In-Reply-To: <43415EC0.1010506@adaptec.com>
Message-ID: <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>
  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>
  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com> 
 <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>
  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl> <1128357350.10079.239.camel@bluto.andrew>
 <43415EC0.1010506@adaptec.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-679877017-1128370904=:28198"
Content-ID: <Pine.BSO.4.62.0510032312200.28198@rudy.mif.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-679877017-1128370904=:28198
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.BSO.4.62.0510032312201.28198@rudy.mif.pg.gda.pl>

On Mon, 3 Oct 2005, Luben Tuikov wrote:

> On 10/03/05 12:35, Andrew Patterson wrote:
>> On Mon, 2005-10-03 at 18:29 +0200, Marcin Dalecki wrote:
>>> They give a means of possible synchronization between beneviolent
>>> users, but not a mandatory lock on the shared resource.
>>>
>>
>>
>> Nor do they protect against external events, such as disk
>> insertion/removals, and someone kicking a cable.
>
> As has _always_ been the case in UNIX:  Provide capability,
> not policy.
>
> The more things are off loaded to userspace the better.
>
> Look at it this way: the deadbolt on your house door does
> not _eliminate_ the possibility of someone cleaning out
> your house, even if you have a security system and/or
> a guard dog.

But using fs like "presentation" layer have some additional "possibilities"
for race conditions because between open() and flock() some other process
can try open the same file. Also this semantics does not provide locking
tree or subtree of files (do I mention procfs and sysfs do not support
locking ? :)
Next is time/cpu concumption because operate on fs like structures
requires open() -> (flock() ->) read()/write() -> close() .. three or more 
context swiching. This is main reason why simple ps takes so many time on
Linux.

Something like simple MIB/OID like semantics for read, write, lock single 
OID or subtree could be very good to mandatory locking for operate on
atributes sets and probably will take less memory than sysfs.

<mode=cynic>
But I know this is like fantasy because seems no one want work on
stabilize kernel API. Even more .. Documentation/stable_api_nonsense.txt
included in *stable* line documents real kernel strategy .. it is 
*pure folclor* (because from this is possible suck something like: "we are
using specyfication: 'we are hate use specyfications'").
If (cytation from Linus) "a 'spec' is close to useless" ..
Q: why the hell in kernel tree is included Documentation/ subdirectory ?
Is it raly content of this directory is "close to useless" or maybe it not
contains some specyfications ? :>
If it is true maybe better will be remove this ? ;->
Maybe after removing Documentation/ with stable_api_nonsense.txt some 
people will can grant permission to start thinking on prepare
specyfication for kernel API usable in longer chunk of time (?)
</mode>

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-679877017-1128370904=:28198--
