Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317576AbSGTXo0>; Sat, 20 Jul 2002 19:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317578AbSGTXo0>; Sat, 20 Jul 2002 19:44:26 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49906 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317576AbSGTXoZ>; Sat, 20 Jul 2002 19:44:25 -0400
Subject: Re: [PATCH] VM strict overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: akpm@zip.com.au, Linus Torvalds <torvalds@transmeta.com>,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <1027207835.1116.861.camel@sinai>
References: <1027196403.1086.751.camel@sinai> 
	<1027211556.17234.55.camel@irongate.swansea.linux.org.uk> 
	<1027207835.1116.861.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 01:59:21 +0100
Message-Id: <1027213161.16818.65.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 00:30, Robert Love wrote:
> But "works for me" is a start and we can work on tuning it.  No
> "swapless" mode will be perfect and while 65% may work for, another load
> with gross overhead may need more room.
> 
> I sent you an email and told you I was doing this and asked your opinion
> on a percentage.  Why are you picking on me now?

When did you send me mail - I certainly never saw it. 

In terms of percentages I measured real world workloads. Its easy to
fail at apparently low values because the kernel has no kernel resource
management (beancounter never got merged) and because a process can
consume substantial real resources that are not its own address space
(page tables, kernel structures, file buffers and so forth)

Its also important to remember that executable pages are mapped
read-only and thus free. This means that the magic 50 value works on a
swapless ipaq in real use just as well as it does on a giant server.

If its actually a serious concern, eg for some of the weirder embedded
stuff you guys run at Montavista then I'd suggest changing it to have 
three modes

0 and 1 as before

2 - some percentage of memory (default 50), and expose the percentage
setting by sysctl too.

That allows people to experiment, handles weird cases and deals with the
problem.

BTW: The oracle tests were not swapless, they were on a system with lots
of swap. The kernel overhead in some cases is just plain scary as I
suspect the IBM folks who have been working on large oracle setups can
testify..

