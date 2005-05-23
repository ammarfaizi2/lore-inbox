Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVEWMH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVEWMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVEWMH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:07:26 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:12998 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261252AbVEWMHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:07:14 -0400
Date: Mon, 23 May 2005 14:09:00 +0200
From: DervishD <lkml@dervishd.net>
To: Hans Henrik Happe <hhh@imada.sdu.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with INET sockets through loopback (lo)
Message-ID: <20050523120900.GA339@DervishD>
Mail-Followup-To: Hans Henrik Happe <hhh@imada.sdu.dk>,
	linux-kernel@vger.kernel.org
References: <200505231317.44716.hhh@imada.sdu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200505231317.44716.hhh@imada.sdu.dk>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Hans :)

    I've not read the code in order to not make assumptions about
proper parameters or how to make the tests. I've tested using an AMD
Athlon XP 1900+, using a self compiled 2.4.29 kernel. The measures
were made using zsh 'time'. Not quite exact but I think that's good
for comparisons anyway.

 * Hans Henrik Happe <hhh@imada.sdu.dk> dixit:
> To test this further i wrote a program (attach: random-inet.c) that shows this 
> behavior. It starts a number processes and connects them with INET sockets. 
> Then n startup messages are sent. When a process receives a message it 
> randomly selects a destination to forward it to. This way there will always 
> be n messages in transit. The issues can be observed with just 3 processes 
> and 1 message. Usage:
> 
> random-init <# processes> <# messages>

    With 3-1 I get an usage of 20% more or less. But with 16-1 the
CPU usage is nearly 0! and with 16-16 the usage is 5% more or less.

> I have tried more regular communication patterns but this gives full CPU 
> utilization as expected. For instance sending messages in a ring (attach: 
> ring-inet.c). 

    Not here. It uses 29% instead of 20% with 3-1, but drops to 6%
when using 16 processes. Far from full CPU usage. A test with 16-160
doesn't make the system slower or irresponsive, at least here...
 
> I discovered another issue when using many messages (i.e. 16 processes and 16 
> messages). The responsiveness of the system degrades massively. It takes 
> seconds before keyboard input are displayed. Of cause there are many very IO 
> bound processes, but I'm not sure if the impact should be that high.   

    Not here. I haven't noticed any slow-down or latency increase
using high number of messages. Using 16-160 only uses at most 7% of
CPU per process, and I don't feel the system irresponsive.

    If you want more accurate results, try to modify your test
programs: make them run for a couple of minutes (you decide how much
time, the longer, the better) and kill all children processes. After
that, use getrusage() (with RUSAGE_CHILDREN) or wait3(). That should
give more accurate results.

    Hope that helps. If you want to make any other test, tell me.
I'll try to help.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
