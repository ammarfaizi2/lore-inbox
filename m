Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318500AbSGaU0p>; Wed, 31 Jul 2002 16:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSGaU0p>; Wed, 31 Jul 2002 16:26:45 -0400
Received: from vitelus.com ([64.81.243.207]:50188 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S318500AbSGaU0o>;
	Wed, 31 Jul 2002 16:26:44 -0400
Date: Wed, 31 Jul 2002 13:30:08 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: ATAPI CD-R lags system to hell burning in DAO mode; but not in TAO
Message-ID: <20020731203008.GA27702@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a Teac CD-W524E 24x CD-R writer, and ever since I got it
several months ago I have had the somewhat annoying issue that burning
a cd Disc-At-Once makes the system unusable during the burn. The X
cursor jerks, repaints take forever, etc. This problem doesn't occur
when burning Track-At-Once - I'm unable to notice any significant
increase in system latency when using that mode.

The burner is the only IDE device in the system, and it is the primary
master on the primary IDE controller, which is a SiS 5513. It's in
UDMA2 mode. I'm using ide-scsi emulation, of course. All 2.4 kernels
that I have tried exhibit this problem, including 2.4.17 and
2.4.18-ac3. It does not matter whether I burn with cdrdao or with
cdrecord -dao - both lag the system like crazy. I noticed that turning
on 32-bit I/O with hdparm helps immensely. This reduces the lag
significantly. Setting unmaskirq seems to help a lot too. However, I'm
still not satisfied. In particular, burning over NFS in DAO mode is
not practical (the data rate simply can't be sustained), even though I
can burn TAO CDs fine over NFS.

My friend has a Plextor PX-W2410A burner with similar specifications,
and it has the same symptoms as I do. I believe he has a VIA IDE
chipset.

I'd like to know if there's a workaround for the problem, and if not,
what tools and/or methods I can use to track down the source of the
noninteractivity so that a kernel hacker can fix it. The machine has
half a gigabyte of RAM, never swaps, and reports 2916.35 bogomips. I
think it should be able to burn CDs without too much sweat.
