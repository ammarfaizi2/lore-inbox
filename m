Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbSJISh4>; Wed, 9 Oct 2002 14:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJISgP>; Wed, 9 Oct 2002 14:36:15 -0400
Received: from thinkpad.c0202001.roe.itnq.net ([217.112.132.138]:2176 "EHLO
	thinkpad.c0202001.roe.itnq.net") by vger.kernel.org with ESMTP
	id <S262403AbSJISeD>; Wed, 9 Oct 2002 14:34:03 -0400
Date: Wed, 9 Oct 2002 20:40:10 +0200 (CEST)
From: Karel Gardas <kgardas@objectsecurity.com>
X-X-Sender: karel@thinkpad.c0202001.roe.itnq.net
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps
 forever)
In-Reply-To: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
Message-ID: <Pine.LNX.4.43.0210091942420.489-100000@thinkpad.c0202001.roe.itnq.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have more information for bugreport below.

I've tested some kernel versions today and results are (BUG means hd
sleeps forever on this kernel, OK means hd finally wake up)

2.4.18      - OK (I'm using this now)
2.4.19pre1  - OK
2.4.19pre2  - OK
2.4.19pre3  - doesn't boot for me.^
2.4.19pre4  - BUG
2.4.19pre5  - BUG
2.4.19      - BUG
2.4.20pre10 - BUG


^ 2.4.19pre3 doesn't boot for me. The last messages from kernel during
boor are:

CPU: L1 I cache: 16k, L1 D cache: 16k
CPU: L2 cache: 256k
Intel machine check architecture supported.
^ here kernel hangs forever

With this boot problem, I'm not able to exactly detect which pre is broken
and brings the BUG first.

Is there anything which I should try to better debug this problem?

Note that copying arch/i386/kernel/apm.c file from 2.4.18 into 2.4.19pre4
and 2.4.19 doesn't help too, so maybe problem is somewhere else...

Note2: nearly after each (as I think) resume there is following text in
syslog:

Oct  9 10:20:24 thinkpad apmd[205]: User Suspend
Oct  9 10:20:47 thinkpad apmd[205]: apmd_call_proxy: Executing proxy: '/etc/apm/apmd_proxy' 'resume' 'suspend'
Oct  9 10:21:04 thinkpad kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Oct  9 10:21:04 thinkpad kernel: hda: lost interrupt
Oct  9 10:21:07 thinkpad apmd[205]: apmd_call_proxy: +  Setting the System Clock using the Hardware Clock as reference... System Clock set. Local time: Wed Oct  9 10:21:07 CEST 2002
Oct  9 10:21:07 thinkpad apmd[205]: Normal Resume


Thanks,

Karel

On Wed, 25 Sep 2002, Karel Gardas wrote:

>
>   Hello,
>
> I have problem with resume from suspend on IBM T22 with kernel 2.4.19
> patched with rmap-14a and usagi-20020916. Actually the problem is that OS
> resume well from suspend (it prints some messages to console for example
> from FW droping some packets), but harddisc is still sleeping and never
> wake up...
>
> Kernel is compiled with frame-buffer support and I always run XFree now at
> version 4.1.0. I've tested suspend/resume cycle with X and without them
> but the behavior is still the same - harddisc sleeps forever (or to reset)
> - as I said kernel seems to run, there is 50-70% chance that console
> (graphics) resume well and so I'm even able to type some command into
> xterm (like cd /usr; find), but then it hangs on sleeping harddisc. Magic
> system request keys are working too.
>
> Kernel is compiled with Debian's gcc 2.95.4/binutils 2.12.90.0.1. Full
> config is attached to this email. I have to add that I've not experienced
> such problems with 2.4.18 - patched with older version of usagi and
> rmap-12<something> yet. It always waits a bit after resume, but harddrive
> is always finally woken up.
>
> Any other information which I have to provide you for better debugging
> this problem?
>
> Thanks a lot for your help,
>
> Karel
> --
> Karel Gardas                  kgardas@objectsecurity.com
> ObjectSecurity Ltd.           http://www.objectsecurity.com
>

--
Karel Gardas                  kgardas@objectsecurity.com
ObjectSecurity Ltd.           http://www.objectsecurity.com


