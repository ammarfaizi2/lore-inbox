Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVFKXBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVFKXBL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 19:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVFKXBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 19:01:11 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:4791 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S261844AbVFKXBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 19:01:07 -0400
Date: Sat, 11 Jun 2005 19:00:52 -0400 (EDT)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd causing giant load
In-Reply-To: <Pine.LNX.4.61.0506051243500.9689@chimarrao.boston.redhat.com>
Message-ID: <Pine.SOL.4.58.0506111856570.22565@titan.cfa.harvard.edu>
References: <Pine.SOL.4.58.0506041232030.14011@titan.cfa.harvard.edu>
 <Pine.LNX.4.61.0506051243500.9689@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rik,

RE:
> Looks like your system is NUMA, meaning that the system
> memory is divided in half, and the threshold at which a
> memory dirtying process is throttled might be higher than
> the amount of memory available in the zone.
>
> Can you reproduce this problem if you boot with "numa=off"
> or if you "echo 20 > /proc/sys/vm/dirty_ratio" ?

After the "echo 20 > /proc/sys/vm/dirty_ratio", the system load still
goes up to aboe 3.0, with kswapd0 and kswapd1 (plus cp on top of the
list).  By the way, i am using cp between to SATA disks, this time,
with the 3ware arrays not involved in the process at all.

---------------
top - 18:50:20 up 7 days,  6:15,  1 user,  load average: 3.15, 2.15, 1.14
Tasks:  91 total,   1 running,  89 sleeping,   1 stopped,   0 zombie
Cpu(s):  0.2% us, 11.7% sy,  0.0% ni,  1.5% id, 84.0% wa,  0.8% hi,  1.8% si
Mem:   4011484k total,  3987444k used,    24040k free,        0k buffers
Swap:  7823576k total,    22176k used,  7801400k free,  3823104k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 7521 root      18   0 44420  636  548 D 17.3  0.0   0:34.02 cp
  174 root      15   0     0    0    0 S  3.0  0.0  20:18.99 kswapd1
  175 root      15   0     0    0    0 S  2.3  0.0  33:05.12 kswapd0
 7526 root      15   0     0    0    0 D  1.0  0.0   0:00.71 pdflush
----------------

2.6.11-1.14_FC3smp #1 SMP Thu Apr 7 19:36:23 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux

Cheers
Gaspar
