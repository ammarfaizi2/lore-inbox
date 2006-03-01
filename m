Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWCAJyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWCAJyp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 04:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbWCAJyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 04:54:45 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:3167 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932689AbWCAJyo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 04:54:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HveitBCpx8e2XC4fT7NFnoAL8ApJTWtw241O/zrBzCvqI9v11evQnIIqdB7fxfG2o6N8vNWmmhnSWw6DGW/FUlOWRhN0maT6J3w5gB2Sh7g1vCEEN7WTmQKP95K/soGR22tSoLJTwWU6eYA/yyhSPB+Q6NguqxxAXA2pRGEQht0=
Message-ID: <6d6a94c50603010154hbbcdb68n8cd7e05f7f30aba5@mail.gmail.com>
Date: Wed, 1 Mar 2006 17:54:43 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: page allocation failure when cached memory is close to the total memory.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm working on the blackfin uclinux. And the kernel version is 2.6.12.
I have an application to malloc 0Mb memory. When cached memory is
small, the allocation will be successful.
But when the cached memory is close to the total memory. The
applicaton memory allocation will fail. See below. I think the cached
memory should be released when there is no enough free memory to
allocate. So far no idea what's wrong. Did anyone ever run into the
problem? Many thanks to your any suggestions and comments.

Regards,
-Aubrey

=========================================================
root:/mnt> cat /proc/meminfo
MemTotal:        54600 kB
MemFree:          6228 kB
Buffers:          2340 kB
Cached:          38464 kB
SwapCached:          0 kB
Active:          11432 kB
Inactive:        29348 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        54600 kB
LowFree:          6228 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:            6904 kB
Writeback:           0 kB
Mapped:              0 kB
Slab:             7292 kB
CommitLimit:     27300 kB
Committed_AS:        0 kB
PageTables:          0 kB
VmallocTotal:        0 kB
VmallocUsed:         0 kB
VmallocChunk:        0 kB
root:/mnt> ../ma
ma: page allocation failure. order:12, mode:0xd0
Stack from 0137bddc:<0>
       <0> 00000000<0> 00024cb0<0> 00072b88<0>
036b8220<0> 0000000c<0> 000000d0<0>
00000000<0> 00000000<0>
       <0> 00000010<0> 00000000<0> 001be5ec<0>
000270c6<0> 001bf760<0> 001bf640<0>
001be5e0<0> 00000001<0>
       <0> 00000000<0> 000000d0<0> 00000000<0>
0000001f<0> 00000000<0> 00102758<0>
0000000e<0> 00000001<0>
       <0> 000000d0<0> 0304ca60<0> 00026e8e<0>
00000000<0> 0270bb60<0> 00000021<0>
0000ffff<0> 00000073<0>
       <0> 00000000<0> 00000004<0> 00000000<0>
0002aee0<0> 00000000<0> 0002b19c<0>
00000003<0> 001035bc<0>
       <0> 03576c00<0> 0000000e<0> 00000021<0>
0368f00c<0> 009f7d54<0> 0002d460<0>
00000004<0> 00a00000<0>
Call Trace:<0>
       <0> [<00003706>]<0>
[<0002d55e>]<0> [<00006f3e>]<0>
[<000036a4>]<0>
       <0> [<00008000>]<0>
[<00007cd4>]<0> [<00001004>]<0>
Allocation of length 10485760 from process 144 failed
DMA per-cpu: empty
Normal per-cpu:
cpu 0 hot: low 14, high 42, batch 7
cpu 0 cold: low 0, high 14, batch 7
HighMem per-cpu: empty

Free pages:        7536kB (0kB HighMem)
Active:2794 inactive:7321 dirty:1725 writeback:1 unstable:0 free:1884
slab:1564 mapped:0 pagetables:0
DMA free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 55 55
Normal free:7536kB min:948kB low:1184kB high:1420kB active:11176kB
inactive:29284kB present:56320kB pages_scanned:0 all_unreclaimable?
no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: empty
Normal: 58*4kB 7*8kB 3*16kB 1*32kB 0*64kB 0*128kB 0*256kB 6*512kB
4*1024kB 0*2048kB 0*4096kB 0*8192kB 0*16384kB 0*32768kB = 7536kB
HighMem: empty
Alloc failed
================================================================
