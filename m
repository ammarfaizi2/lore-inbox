Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSLPXNR>; Mon, 16 Dec 2002 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262450AbSLPXNR>; Mon, 16 Dec 2002 18:13:17 -0500
Received: from smtp-server4.tampabay.rr.com ([65.32.1.43]:43488 "EHLO
	smtp-server4.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S262449AbSLPXNQ>; Mon, 16 Dec 2002 18:13:16 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: HT Benchmarks (was: /proc/cpuinfo and hyperthreading)
Date: Mon, 16 Dec 2002 18:21:08 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJAEOLDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20021216223848.GA2994@werewolf.able.es>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> HT can give no benefit in UP case, nobody knows that the sibling exists
> and the P4 does not paralelize itself. The gain you see is due to
> computation-io overlap.

I see the light! Thank you.

> This my render code, implemented with posix threads, running on a dual
> P4-Xeon@1.8GHz.

> Number of threads	Elapsed time   User Time   System Time
> 1                   53:216           53:220    00:000
> 2                   29:272           58:180    00:320
> 3                   27:162         1:21:450    00:540
> 4                   25:094         1:41:080    01:250
>
> Elapsed is measured by the parent thread, that is not doing anything
> but wait on a pthread_join. User and system times are the sum of
> times for all the children threads, that do real work.
>
> The jump from 1->2 threads is fine, the one from 2->4 is ridiculous...
> I have my cpus doubled but each one has half the pipelining for floating
> point...see the user cpu time increased due to 'worst' processors and
> cache pollution on each package.

>From what I can see, HT provides a 0-15% increase in performance, depending
heavily on the type of code being run. In other words, HT helps, but it is
*no* substitute for true multiple processors. And it is ONLY of value when
an SMP kernel is in use.

What you're seeing meshes with my results: our perfromance gains from HT are
about the same. HT didn't lose either of us anything, but it sure as heck
didn't make the kind of difference the hype seems to imply.

As for REAL SMP: I posted some more numbers on my web site (URL below),
using the same gcc compile test on my dual-proc with PIII-600s. Using a
single process, the compile took just under a 100 minutes, while with two
processes, it finished in 58.5 minutes. Real SMP reduced the time by 40%
(again, similar to your numbers).

..Scott

--
Scott Robert Ladd
Coyote Gulch Productions,  http://www.coyotegulch.com
No ads -- just very free (and somewhat unusual) code.

