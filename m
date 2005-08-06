Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263200AbVHFOfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbVHFOfA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 10:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbVHFOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 10:35:00 -0400
Received: from lucidpixels.com ([66.45.37.187]:903 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S263200AbVHFOe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 10:34:59 -0400
Date: Sat, 6 Aug 2005 10:34:55 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.xx - NFSv3 vs. Samba Data Transfer Semantics
Message-ID: <Pine.LNX.4.63.0508061017150.19178@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have three machines with the same motherboard and gigabit ethernet, ABIT 
IC7-G.

Two are Linux (Debian)
One is Windows 2000.

When I copy 100 gigabytes from a Windows 2000 PC to either one of my Linux 
machines, I get a *SUSTAINED* transfer rate of 40-50MB/s over gigabit. 
Sustained meaning, when I watch gkrellm, eth0 never dips below 40MB/s.

When I copy 100 gigabytes from one Linux box to the other over NFS, I see 
all sorts of weirdness, 64MB/s for a few seconds, then 40MB/s, then 
10-30MB/s, then 0MB/s for 2-3 seconds then 7MB/s, it goes all over the 
place.  I have tried different (r|w)sizes without any conclusive results, 
they do not seem to make much of a difference.

A few examples, copy an ~800MB file to a Linux box:

TCP/FTP:

226 65.484 seconds (measured here), 11.98 Mbytes per second
822514728 bytes received in 65.48 secs (12266.2 kB/s)

UDP/NFSv3:

0.15user 12.00system 0:26.22elapsed 46%CPU (0avgtext+0avgdata 
0maxresident)k0inputs+0outputs (0major+148minor)pagefaults 0swaps

0.14user 13.96system 0:28.31elapsed 49%CPU (0avgtext+0avgdata 
0maxresident)k0inputs+0outputs (0major+148minor)pagefaults 0swaps

UDP/Samba, Win2K->Linux box:

$ date +%s
1123338368
$ date +%s
1123338399
1123338399 - 1123338368
31 seconds

I suppose NFS makes up for it bursting at such high speeds, but in some 
cases, a constant data rate is preferred.  Are there any methods to 
duplicate the way Samba works to NFS?  When NFS transfers are taking 
place, watching gkrellm, I see 64MB/s for a few seconds then it goes to 0 
as the disk (hda) continues to write for 3-4 seconds, this continues on 
and off.  With Samba and the W2K box pushing the data, it is more of a 
consistent stream with very few delays that are found with NFS.

I am using the Intel e1000 driver for gigabit:
0000:02:01.0 Ethernet controller: Intel Corp. 82547GI Gigabit Ethernet
Controller.

I *do* have the NAPI option enabled for the driver on both Linux machines.
[*]   Use Rx Polling (NAPI)

Samba Config:
# Increase overall throughput of samba.
socket options = IPTOS_LOWDELAY TCP_NODELAY SO_SNDBUF=32768 SO_RCVBUF=8192
# Set max xmit size.
max xmit = 8192

NFS Config/fstab Entry:
machine:/mount  /local/mount  nfs rw,hard,intr,nfsvers=3 0 0

I am using XFS filesystems on both Linux machines.  The drives are 7200RPM 
Seagate HDDs with either 2MB or 8MB of cache.

Are there any 'tweaks' or 'hacks' to make NFS behave more like Samba or 
just to tune it in general that are not commonly known or found on google?

Thanks,

Justin.
