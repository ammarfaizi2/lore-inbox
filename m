Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292869AbSCITpM>; Sat, 9 Mar 2002 14:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292898AbSCITpD>; Sat, 9 Mar 2002 14:45:03 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:2518 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S292869AbSCITox>; Sat, 9 Mar 2002 14:44:53 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: "Martin J. Bligh" <fletch@aracnet.com>
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Date: Sat, 9 Mar 2002 20:44:43 +0100
X-Mailer: KMail [version 1.3.9]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrea Arcange <andrea@suse.de>, Ingo Molnar <mingo@elte.hu>,
        Robert Love <rml@tech9.net>, Oleg Drokin <green@namesys.com>,
        ReiserFS List <reiserfs-list@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200203092044.43456.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 9. März 2002 05:47:04, Martin J. Bligh wrote:
> "time make -j32 bzImage" is now down to 23 seconds.
> (16 way NUMA-Q, 700MHz P3's, 4Gb RAM).

I want such a beast, too:-)))

[-]
Planned work next:

1. Try John Stultz's mcslocks 
        (note high max wait vs low max hold currently)
2. Try rmap + pagemap_lru_breakup from Arjan
3. Try radix tree pagecache.
4. Try grafting NUMA-Q page local alloc onto -aa tree
5. Try SGI NUMA zone ordering stuff.
6. [HARD] Break up ZONE_NORMAL between nodes 
   (all currently on node 0).
[-]

No flamewar intended, but shouldn't you start with 4. and 5.?
-aa is the way to go for the 2.4.18+ tree. -rmap later for 2.5.x.

Have you tried the OOM case?
vm_29 and before fixed it for me.
Throughput is much improved with -aa.

Have you checked latency?
I found weird behavior of latest O(1)-K3 with latencytest0.42-png and higher 
latency then with clean 2.4.18.
Do you have some former O(1) versions around? Ingo removed them form his 
archive.

Preemption?

Running 2.4.19-pre2-dn1 :-)
Taken from -jam3:
00-vm-29
01-vm-io-3
10-x86-fast-pte-1
11-spinlock-cacheline-3
12-clone-flags
20-sched-O1-K3
21-sched-balance
22-sched-aa-fixes
23-lowlatency-mini
24-read-latency-2
30-aic7xxx-6.2.5
31-ide-20020215
all latest ReiserFS stuff 2.4.18.pending
preempt-kernel-rml-2.4.18-rc1-ingo-K3-1.patch
lock-break-rml-2.4.18-1

Regards,
	Dieter

BTW Anyone out there who have a copy of the mem "test" prog handy?
I've accidentally removed one of my development folders...

Would be nice to see some "Hammer" systems from IBM next winter;-)

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
