Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135292AbRDLTsg>; Thu, 12 Apr 2001 15:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135288AbRDLTq1>; Thu, 12 Apr 2001 15:46:27 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:64143 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135287AbRDLTps>; Thu, 12 Apr 2001 15:45:48 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 12 Apr 2001 12:45:45 -0700
Message-Id: <200104121945.MAA00280@baldur.yggdrasil.com>
To: frankeh@us.ibm.com
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
Cc: linux-kernel@vger.kernel.org, pratap@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@us.ibm.com> writes:

>Try this ... this will guarantee that (p->counter) > (current->counter)
>and it seems not as radical

>         p->counter = (current->counter + 1) >> 1;
>        current->counter = (current->counter - 1) >> 1;
>        if (!current->counter)
>                current->need_resched = 1;

>instead of this


>-       p->counter = (current->counter + 1) >> 1;
>-       current->counter >>= 1;
>-       if (!current->counter)
>-               current->need_resched = 1;
>+       p->counter = current->counter;
>+       current->counter = 0;
>+       current->need_resched = 1;


	No.  I tried your change and also tried it with setting
current->need_resched to 1 in all cases, and it still seems to run the
parent first in at least half of the tries.  Evidently,
current->counter must be zero to make the currently running process
give up the CPU immediately, which is the important thing (so that the
parent does not touch its virtual memory for a while).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


