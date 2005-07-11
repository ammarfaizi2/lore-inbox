Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVGKOCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVGKOCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 10:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGKOAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 10:00:19 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:50070 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261736AbVGKN7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:59:25 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 11 Jul 2005 07:00:32 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eventpoll : Suppress a short lived lock from struct file
In-Reply-To: <42D23BDF.8020701@cosmosbay.com>
Message-ID: <Pine.LNX.4.63.0507110642550.7209@localhost.localdomain>
References: <4263275A.2020405@lab.ntt.co.jp>  <20050418040718.GA31163@taniwha.stupidest.org>
  <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org>
  <1113800136.355.1.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com> 
 <42D21D43.3060300@cosmosbay.com> <1121070867.24086.6.camel@localhost.localdomain>
 <42D23BDF.8020701@cosmosbay.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-969892002-1121090432=:7209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-969892002-1121090432=:7209
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Jul 2005, Eric Dumazet wrote:

> Peter Zijlstra a =E9crit :
>> On Mon, 2005-07-11 at 09:18 +0200, Eric Dumazet wrote:
>>=20
>> Have you tested the impact of this change on big SMP/NUMA machines?
>> I hate to see an Altrix crashing to its knees :-)
>>=20
>
> I tested on a small NUMA machine (2 nodes), with a epoll enabled applicat=
ion,
> that use around 100 epoll ctl per second.
>
> Of course, one may write a special benchmark on a BIG SMP/NUMA machine th=
at
> defeat these patch, using thousands of epoll ctl per second, but, a norma=
l=20
> (well written ?)
> epoll application doesnt constantly add/remove epoll ctl.
>
> Should we waste 8 bytes per 'struct file' for a very unlikely micro bench=
mark=20
> ?

Eric, I can't really say I like this one. Not at least after extensive=20
tests run on top of it. You are asking to add a bottleneck to save 8 bytes=
=20
on an entity that taken alone in more than 120 bytes. Consider that when=20
you have a "struct file" allocated, the cost on the system is not only the=
=20
struct itself, but all the allocations associated with it. For example, if=
=20
you consider that a case where you might feel a "struct file" pressure is=
=20
when you have hundreds of thousands of network connections, the 8 bytes=20
saved compared to all the buffers associated with those sockets boils down=
=20
to basically nothing.



- Davide

--8323328-969892002-1121090432=:7209--
