Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUCHT0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 14:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUCHT0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 14:26:51 -0500
Received: from devil.servak.biz ([209.124.81.2]:27882 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S261153AbUCHT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 14:26:46 -0500
Subject: 2.6.4-rc1-mm2 ieee1394 and/or framebuffer crash
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux-Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078774964.23108.48.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 08 Mar 2004 11:42:44 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this while switching VC consoles during a large, long rsync backup
from my workstation's RAID0 "/home" to an external firewire drive.  I'm
using the Radeon framebuffer, if that matters?  

I doubt it was a coincidence that the crash happened while switching
consoles, since the rsync had been running for a long time before the
crash.

The kernel was compiled with SMP, preempt, HT scheduluer support,
register parameter passing, various kernel debug options.

Copied by hand from a digicam pic of the screen, hopefully accurately.

---
 printing eip:
f983e944
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
CPU:    1
EIP:    0060:[<f983e944>]   Not tainted VLI
EFLAGS: 00010047
EIP is at hpsb_packet_sent+0x1d/0x91 [ieee1394]
eax: 00000009   ebx: f6f68000   ecx: 00200200   edx: ef9d3ac4
esi: 00000001   edi: ef9d3ac4   ebp: f2421f24   esp: f2421f20
ds: 007b   es: 007b   ss: 0068
Process rsync (pid: 20642, threadinfo=f2420000 task=f1729800)
Stack: f6f6a1bc f2421f54 f98595b3 00010800 f7fff080 00000000 f2421f6c f6f6a1e7
       00000292 f6f6a078 f6f6a1fc 00000000 f2420000 f2421f6c c01281f0 c04066ac
       00000001 c03d7aa8 0000000a f2421f80 c0127f39 00000046 f2420000 00000012
Call Trace:
 [<f98595b3>] dma_trm_tasklet+0xac/0x1be [ohci1394]
 [<c01281f0>] tasklet_action+0x65/0xae
 [<c0127f39>] __do_softirq+0xa5/0xa7
 [<c0127f6c>] do_softirq+0x31/0x33
 [<c010aa87>] do_IRQ+0x155/0x1b9
 [<c02fb728>] common_interrupt+0x18/0x20

Code: 8e c6 0f b6 8e 92 00 00 00 e9 ec fe ff ff 55 89 e5 43 88 4a 15 89 c3 0f b6
 42 17 a8 02 75 77 83 f9 02 74 45 f0 ff 4a 30 8b 4a 0f <39> 11 75 30 8b 02 39 50
 04 75 1f 89 48 04 89 01 c7 42 04 00 02
<0>Kernel panic: fatal exception in interrupt
In interrupt handler - not syncing
 _ interrupt handler - not syncingin interrupt8b 4a 04 <39> 11 75 30 8b 02 39 50


-- 
Torrey Hoffman <thoffman@arnor.net>

