Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbRDLTQN>; Thu, 12 Apr 2001 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135268AbRDLTQD>; Thu, 12 Apr 2001 15:16:03 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:56974 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135267AbRDLTPy>; Thu, 12 Apr 2001 15:15:54 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 12:15:32 -0700
Message-Id: <200104121915.MAA03715@baldur.yggdrasil.com>
To: vonbrand@inf.utfsm.cl
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Adam J. Richter <adam@yggdrasil.com>
>  = Horst von Brand <vonbrand@inf.utfsm.cl>

>> 	I suppose that running the child first also has a minor
>> advantage for clone() in that it should make programs that spawn lots
>> of threads to do little bits of work behave better on machines with a
>> small number of processors, since the threads that do so little work that
>> they accomplish they finish within their time slice will not pile up
>> before they have a chance to run.  So, rather than give the parent's CPU
>> priority to the child only if CLONE_VFORK is not set, I have decided to
>> do a bit of machete surgery and have the child always inherit all of the
>> parent's CPU priority all of the time.  It simplifies the code and
>> probably saves a few clock cycles (and before you say that this will
>> cost a context switch, consider that the child will almost always run
>> at least one time slice anyhow).

>And opens the system up to DoS attacks: You can't have a process fork(2)
>at will and so increase its (aggregate) CPU priority.

	My change does not increase the aggregate priority of
parent+child.  Perhaps I misunderstand your comment.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
