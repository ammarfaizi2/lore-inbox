Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318866AbSHRGkq>; Sun, 18 Aug 2002 02:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318868AbSHRGkq>; Sun, 18 Aug 2002 02:40:46 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:3768 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S318866AbSHRGkp>; Sun, 18 Aug 2002 02:40:45 -0400
Subject: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 02:44:44 -0400
Message-Id: <1029653085.674.53.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(overview written in hindsight of writing email)  
I ran all these tests on ide/host2/bus0/target0/lun0/part1 
when dma was enabled or disabled is was done to both drives at the same
time.
I do not know if cerberus cares where it is run or not to do it's tests,
but the program was on the drive it was tested on when run and
throughout the email i assume it only runs it's drive tests primarily on
the partition you've run it on.   I see now that this is probably wrong
and instead of changing where i run the test i should alternate which
drive gets dma enabled and disabled and process of elimination will show
just the kind of dma bug i'm seeing
(/overview)


I've been trying to track down why i seem to get disk corruption on my
harddrives after some good amount of usage all the time.  It's been
happening for a long time across a number of different kernel versions. 
I believe this is because i stick to the same board manufacturer, Abit
and use via chipsets. 

I ran cerberus with dma enabled at UDMA4 and UDMA2, at udma4 cerberus
reports MEMORY errors and BBidehost2bus0target0lun0discN1 errors, but
mostly MEMORY errors before the kernel panics after a minute or two.  At
udma2 the cerberus reports no errors but panics after a minute or two.  
I ran cerberus a couple times on each, with UDMA4 it began to error
about 30 seconds into the test with MEMORY errors.  

I thought, well this could be ram errors, so i ran memtest for a couple
hours.  Nothing reported as being bad.  I then thought, my hardware
could be the problem, so I ran e2fsck -c on the partition I was running
cerberus on with dma disabled via hdparm -d0 and it completed with no
errors found.  I then rebooted, enabled udma2 and the kernel panic'd
with the same test after a few minutes.  

The rest of this email is just information regarding the setup 


First off the way my fs's are setup are as follows: 

swap + files are now all on my primary master ide drive on the
motherboard ide controller. Swap on my primary master promise controller
seemed too problematic because of corruption, but i'm not sure if the
corruption i've seen is related only to the promise controller or if
it's not controller specific. I'll have to run the test without swap on
the promise drive and then run the test on my primary motherboard hdd
and again without swap.  

cerberus version : 1.3.0pre4 
dmesg info : http://signal-lost.homeip.net/lkml/dmesg
hdparm info : http://signal-lost.homeip.net/lkml/hdparm
pci info : http://signal-lost.homeip.net/lkml/lspci

tests completed before escaping in pio mode:
http://signal-lost.homeip.net/lkml/tests_passed

Errors during last test that caused kernel panic (udma2)
http://signal-lost.homeip.net/lkml/memory

Errors during test of udma4 (first test) 
http://signal-lost.homeip.net/lkml/memory2
http://signal-lost.homeip.net/lkml/dmesg2
various segfaults of badblocks of BBidehost tests. 


I ran memtest for an extensive amount of time after the first test
reported memory errors and go absolutely no errors (wasn't using dma
mode at the time either).  And since these errors aren't produced when
not using DMA on my drives I find it very unlikely that it's "System
Ram" as the cause of them.  I'm going to rerun the test on my
motherboard primary  drive after posting this in case something happens
and i hose everything.  
 



