Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280933AbRKCJjt>; Sat, 3 Nov 2001 04:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280934AbRKCJjl>; Sat, 3 Nov 2001 04:39:41 -0500
Received: from [196.28.7.2] ([196.28.7.2]:36793 "HELO netfinity.realnet.co.sz")
	by vger.kernel.org with SMTP id <S280933AbRKCJjZ>;
	Sat, 3 Nov 2001 04:39:25 -0500
Date: Sat, 3 Nov 2001 11:51:09 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.13-ac5-preempt, overflow in cached memory stat?
Message-ID: <Pine.LNX.4.33.0111031149260.30382-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced a power loss and upon booting of the system, fsck was run on
my / partition (ext3). When it was done i noticed the following;

zwane@montezuma:~ $ cat /proc/version
Linux version 2.4.13-ac5-preempt (zwane@montezuma.localnet) (gcc version
2.96 20000731 (Red Hat Linux 7.1 2.96-81)) #1 Wed Oct 31 19:55:49 SAST
2001

zwane@montezuma:~ $ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  525602816 243605504 281997312   552960 145076224
18446744073614016512
Swap: 139788288        0 139788288
MemTotal:       513284 kB
MemFree:        275388 kB
MemShared:         540 kB
Buffers:        141676 kB
Cached:       4294874000 kB
SwapCached:          0 kB
Active:         188024 kB
Inact_dirty:      2032 kB
Inact_clean:         0 kB
Inact_target:   104852 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513284 kB
LowFree:        275388 kB
SwapTotal:      136512 kB
SwapFree:       136512 kB

System still ran fine like this, but when i opened a 100Mb avi with
mplayer the disk cache dropped down to 2megs. There now seems to be a
slight discrepancy with regards to how ram is allocated, i just started X
but i seem to have more memory under used/shared in xosview than normal
(~100megs discrepancy)

zwane@montezuma:~ $ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  525602816 417894400 107708416  1089536 155455488  3702784
Swap: 139788288        0 139788288
MemTotal:       513284 kB
MemFree:        105184 kB
MemShared:        1064 kB
Buffers:        151812 kB
Cached:           3616 kB
SwapCached:          0 kB
Active:         192816 kB
Inact_dirty:    114424 kB
Inact_clean:         0 kB
Inact_target:   104852 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       513284 kB
LowFree:        105184 kB
SwapTotal:      136512 kB
SwapFree:       136512 kB


