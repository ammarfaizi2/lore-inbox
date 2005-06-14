Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFNMUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFNMUM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 08:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFNMUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 08:20:12 -0400
Received: from alog0098.analogic.com ([208.224.220.113]:392 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261207AbVFNMUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 08:20:01 -0400
Date: Tue, 14 Jun 2005 08:19:50 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gzip zombie / spawned from init
In-Reply-To: A<yw1xvf4h6uni.fsf@ford.inprovide.com>
Message-ID: <Pine.LNX.4.61.0506140815590.9068@chaos.analogic.com>
References: <20050614085436.GA1467@schottelius.org> <42AEB756.2030809@etpmod.phys.tue.nl>
 A<yw1xvf4h6uni.fsf@ford.inprovide.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-647636777-1118751590=:9068"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-647636777-1118751590=:9068
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Jun 2005, [iso-8859-1] M=E5ns Rullg=E5rd wrote:

> Bart Hartgers <bart@etpmod.phys.tue.nl> writes:
>
>> Nico Schottelius wrote:
>>> Hello!
>>> I wrote an init replacement (cinit), which is now in the beta-phase.
>>> The only problem I do have currently is that when calling
>>> 'loadkeys dvorak' directly from init (without a shell or anything)
>>> it will leave behind a gzip zombie (which was forked by loadkeys).
>>> Now my question is: Is that a problem of loadkeys or from my init
>>> and what could be the reasons that it's still there?
>>
>> Not really a kernel issue but:
>>
>> Yes and no. If a parent exits before its child, the child is
>> reparented to init. loadkeys probably doesn't wait properly for gzip
>> to finish.
>>
>>> cinit forks() loadkeys and does waitpid() for it. There is no
>> > loadkeys zombie, only gzip.
>>
>> Use waitpid(-1,...) or wait(...) to wait on all childeren in your
>> init. gzip will become a child of cinit.
>
> In fact, init must reap any zombies that are reparented to it.
> Otherwise, the system will sooner or later run out of PIDs.  There are
> a lot of misbehaving programs out there, and even if they were all
> well-behaved, they could be killed before having waited for their
> children, leaving zombies behind.
>
> --=20
> M=E5ns Rullg=E5rd
> mru@inprovide.com


Normally an `init` program will provide a SIGCHLD handler like:

void reaper(int sig)
{
     while(wait3(&sig, WNOHANG, NULL) > 0)
         ;
}

This will 'reap' and throw away the status of all dead children,
preventing zombies.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-647636777-1118751590=:9068--
