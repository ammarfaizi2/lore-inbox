Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSHaNKI>; Sat, 31 Aug 2002 09:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSHaNKI>; Sat, 31 Aug 2002 09:10:08 -0400
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:35775 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S314514AbSHaNKH>; Sat, 31 Aug 2002 09:10:07 -0400
Date: Sat, 31 Aug 2002 15:14:21 +0200 (CEST)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@ultra60
To: pwaechtler@mac.com
cc: Amos Waterland <apw@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues
In-Reply-To: <EE7BCBB6-BCD6-11D6-87AD-00039387C942@mac.com>
Message-ID: <Pine.GSO.4.40.0208311454260.7165-100000@ultra60>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Aug 2002 pwaechtler@mac.com wrote:
> > The mq_maxmsg and mq_msgsize members of the mq_attr structure required
> > if O_CREAT is passed to mq_open() ensure that an implementation can
> > prevent the kernel memory DoS you mention: a malicious application can
> > only fill up the MQ memory.
> And how many mqueues am I allowed to create?
> You would need an extra resource limit for that.

Some explanation about limits:
1) POSIX states about following limits:

You can specify when creating a new queue mq_maxmsg (max number of mes. in
this queue) and mq_msgsize (max mes. size). Values of those parameters are
limited by MQ_MAXMSG and MQ_MSGSIZE. Defaults are 40 and 16384, but you
can change them. Max number of queues (in system) is limited by MQ_MAX
(default=64). Anyway the problem is how to, keeping this constants at
sensible level, prevent from DOS. (40*16384*64= ca 40Mb)

So we added
2) non-POSIX limit:

MQ_MAXSYSSIZE which limits space used by all messages (NOT queues) system
wide. Maybe it isn't POSIX but useful I think. Default is 1Mb. It can be
given MQ_MAX*MQ_MAXMSG*MQ_MAXSIZE value; then it do nothing => and
you have only POSIX limits if you want so.

