Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRLGNAC>; Fri, 7 Dec 2001 08:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280026AbRLGM7w>; Fri, 7 Dec 2001 07:59:52 -0500
Received: from uisge.3dlabs.com ([193.133.230.45]:1746 "EHLO uisge.3dlabs.com")
	by vger.kernel.org with ESMTP id <S279768AbRLGM72>;
	Fri, 7 Dec 2001 07:59:28 -0500
Date: Fri, 7 Dec 2001 12:58:21 +0000
From: Paul Sargent <Paul.Sargent@3dlabs.com>
To: linux-kernel@vger.kernel.org
Subject: 2GB process crashing on 2.4.14
Message-ID: <20011207125821.D31161@3dlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi People,

I looking for some theories for a problem I've got on a Linux 2.4.14 box.
Basically we're using this box for running large chip design jobs on. These
processes reglarly get up to the 1-2GB size. All has been fine, until
recently the jobs started getting a little larger and growing above the 2GB
boundary. At this point the process crashes reporting that it's unable to
obtain any more memory. The kernel messages are silent.

I'm trying to work out why the process doesn't start using swap. Swap
appears to be working, as all other processes have been swapped out. Is it
possible for a running process to be partially swapped out? Could it be that
the process is asking for memory which can't be swapped?

Does anybody who has knowledge of the VM system, have any ideas what could
be going on, or any debugging techniques which might allow me to get some
more info. I've included a dump of the /proc/<pid>/maps output when the
process is around the 1GB level. Hopefully it may give some clues. Please
bear in mind when offering debug tips, that the job has a run time of about
12 hours before it crashes, so quick spins aren't feasible.

I realise this could well not be a kernel issue, and just an app issue, but
I thought this would be the place where the knowledge would reside.

Thanks

Paul

P.S. I'll be monitoring the list from the Archives, but if people could cc
     me on replies that would make things easier.

-------------------------------------------------------

Configuration of the box:

AMD Athlon 1GHz
AMD 760 North Bridge
Via South Bridge

2GB Physical RAM (2x1GB DIMMs)
4GB Swap (2x2GB Partitions)

Linux Kernel 2.4.14 (Compiled with CONFIG_HIGHMEM4G, but not 64G)
libc6-2.2.4

-------------------------------------------------------

/proc/x/maps:

00002000-0140b000 r-xp 00000000 00:0c 4064305 /homes/magma_rel/blast2/2001_08_22.1047/linux22_x86/bin/mantle
0140b000-01c6a000 rw-p 01408000 00:0c 4064305 /homes/magma_rel/blast2/2001_08_22.1047/linux22_x86/bin/mantle
01c6a000-4b653000 rwxp 00000000 00:00 0
bca9a000-bd174000 rw-p 4792c000 00:00 0
bd1a5000-beb2e000 rw-p 480d1000 00:00 0
bec50000-bed89000 rw-p 0d88a000 00:00 0
bee5a000-bf050000 rw-p 0d696000 00:00 0
bf12b000-bf4b8000 rw-p 0d95f000 00:00 0
bf4c0000-bf658000 rw-p 0dcf4000 00:00 0
bf658000-bf661000 r-xp 00000000 03:02 1047       /lib/libnss_nis-2.2.4.so
bf661000-bf662000 rw-p 00008000 03:02 1047       /lib/libnss_nis-2.2.4.so
bf662000-bf673000 r-xp 00000000 03:02 1040       /lib/libnsl-2.2.4.so
bf673000-bf675000 rw-p 00010000 03:02 1040       /lib/libnsl-2.2.4.so
bf675000-bf677000 rw-p 00000000 00:00 0
bf677000-bf680000 r-xp 00000000 03:02 1048       /lib/libnss_nisplus-2.2.4.so
bf680000-bf682000 rw-p 00008000 03:02 1048       /lib/libnss_nisplus-2.2.4.so
bf682000-bf696000 r-xp 00000000 03:02 989        /lib/ld-2.2.4.so
bf696000-bf697000 rw-p 00013000 03:02 989        /lib/ld-2.2.4.so
bf697000-bf698000 rw-p 00000000 00:00 0
bf698000-bf7b0000 r-xp 00000000 03:02 1003       /lib/libc-2.2.4.so
bf7b0000-bf7b6000 rw-p 00117000 03:02 1003       /lib/libc-2.2.4.so
bf7b6000-bf7ba000 rw-p 00000000 00:00 0
bf7ba000-bf7c2000 r-xp 00000000 03:02 1045       /lib/libnss_files-2.2.4.so
bf7c2000-bf7c4000 rw-p 00007000 03:02 1045       /lib/libnss_files-2.2.4.so
bf7c7000-bf7ff000 rw-p 00014000 00:00 0
bffe5000-c0000000 rwxp fffe6000 00:00 0

-------------------------------------------------------

Snippets of dmesg:

Linux version 2.4.14 (root@gringo) (gcc version 2.95.4 20011006 (Debian prerelease)) #1 Thu Nov 8 13:01:18 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=302
Memory: 2061972k/2097088k available (1133k kernel code, 34732k reserved, 327k data, 200k init, 1179584k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces

-------------------------------------------------------

-- 
Paul Sargent
mailto: Paul.Sargent@3Dlabs.com
