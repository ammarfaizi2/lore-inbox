Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318120AbSGRPHy>; Thu, 18 Jul 2002 11:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSGRPHx>; Thu, 18 Jul 2002 11:07:53 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:44975 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S318120AbSGRPHv>;
	Thu, 18 Jul 2002 11:07:51 -0400
Subject: SMP & MCE [Was: 2.4.18 is not SMP friendly]
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
To: devik <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0207181244550.535-100000@devix>
References: <Pine.LNX.4.33.0207181244550.535-100000@devix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 18 Jul 2002 18:10:43 +0300
Message-Id: <1027005043.6817.76.camel@devil>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 13:51, devik wrote:
> Hello,
> 
> I someone here running 2.4.18 on PII SMP successfully ?
> My SMP box was happily running 2.4.3 but after upgrade
> to 2.4.18 I got 3 oopses in 4 days.

2 x PII (Deschutes, dA0 core). So far so good, uptime nearly 2 days now.
In fact, I'm starting to have a glimmer of hope that I might finally
have licked (fingers crossed) a really ugly system freeze problem which
has been bugging me ever since I moved on from 2.4.0-test9 [solid freeze
in less than 24 hours, on average]. I have tried numerous kernels after
that, none of them helped. Not one.

Well, a few days ago I got a Machine Check Exception in the log file,
basically complaining about a catastrophic memory system inconsistency.
First time I ever saw this, despite hundreds of lockups. I thought,
whaddaya know, maybe it really is a hardware problem.

So how come 2.4.0-test9 and older kernels appear to work ok?

[You might ask why I'm not running a kernel that I know is more stable.
Well, my home system is not that important and I've sort of learned to
live with the lockups. I usually shut it down for the night, so the
average uptime is good enough most days. It really is no worse than
trying to run Win98, and ext3 does help a lot.]

Anyway, I had already resigned to my fate, but now I decided to
investigate again. It turns out that Machine Check Exceptions were, for
the very first time, enabled by default in 2.4.0-test10. Also, it turns
out that the PII has a surprising number of Errata related to SMP and
MCEs. Almost all of them lead to a catastrophic failure and CPU
shutdown. Correct execution of the MCE handler is not guaranteed either.
Exactly the kind of behaviour I have been seeing. Coincidence? Maybe.
It's the only hypothesis I've got, so I'm putting it to the test.

According to the PII errata, some of the lockups could be eliminated by
simply not enabling MCE at all. Unfortunately, this is not true for all
of them. Besides, there appear to be other SMP related ones that are
really ugly and completely unrelated to MCE. The worst of the errata
could, however, be worked around with a BIOS patch (i.e., microcode
update). Fat chance. It turns out my mobo vendor never bothered to put
most of the IA32 microcode updates into the BIOS (thanks a lot
Giga-Byte!).

Anyway, I'm now running 2.4.18 with the machine check exceptions
disabled. I've also compiled the microcode upgrade driver into the
kernel and upgrade the microcode on both CPUs during Linux boot. Maybe
it helps.

I hope this tirade is useful to someone who is suffering from mysterious
lockups or strange MCEs. Mostly I'm just happy that I have finished it
and my machine is still running.

Cheers,

	MikaL


