Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264863AbSKSQeO>; Tue, 19 Nov 2002 11:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSKSQeO>; Tue, 19 Nov 2002 11:34:14 -0500
Received: from A17-250-248-85.apple.com ([17.250.248.85]:48882 "EHLO
	smtpout.mac.com") by vger.kernel.org with ESMTP id <S264872AbSKSQeM>;
	Tue, 19 Nov 2002 11:34:12 -0500
Message-ID: <3DDA6A04.5A2D60F3@mac.com>
Date: Tue, 19 Nov 2002 17:42:44 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
CC: Michal Wronski <wrona@mat.uni.torun.pl>, linux-kernel@vger.kernel.org,
       "Gustafson, Geoffrey R" <geoffrey.r.gustafson@intel.com>,
       "Abbas, Mohamed" <mohamed.abbas@intel.com>
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
References: <Pine.GSO.4.40.0211191219060.17529-100000@Jan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak schrieb:
> 
> Hello,
> 
> After some looking into your code, I think there is a bug.
> Please correct me if I'm wrong.
> 
> The problem occur when awake processes which wait for message (or free
> space). I think that your code will wake them up in random order. POSIX
> says:
> 
> > If more than one thread is waiting to send when space becomes
> > available in the message queue and the Priority Scheduling option is
> > supported, then the thread of the highest priority that has been
> > waiting the longest shall be unblocked to send its message
> 
> I've written a test and it shows that my suspects are rather true?
> 
> BTW: I've had some problems with your patch when linking kernel - in your
> main file were used static functions from msg.c?? Maybe my patch (taken
> from lkml - post date: XI 10) was incomplete? If there is more recent
> version could you inform me? Thanks.
> 

The patch included 2 attachments - one was making the 3 function non static.

SuSv3 - mq_receive:
	If more than one thread is waiting to receive a message when a message
arrives at an empty queue and the Priority Scheduling option is supported, then
the thread of highest priority that has been waiting the longest shall be
selected to receive the message. Otherwise, it is unspecified which waiting
thread receives the message.

--- snip ---

We could implement some kind of priority sorted waitqueue.
I read about some prio aware waitqueue patch (from Ingo Molnar) used
by a NGPT developer for the futexes (I.Gonzalez?)

I thought about some waitqueue in the kernel, that at least put
realtime processes at the front of the waitqueue.

It would be nice to have some generic mechanism in the kernel since
only prio aware message read feature does not buy you much, IMHO

I will look in Ingos folder and also for the patch for the futexes.
