Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVA1JnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVA1JnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVA1JnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:43:11 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:15571 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261241AbVA1Jmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:42:39 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Memory leak report
Date: Fri, 28 Jan 2005 09:17:06 GMT
Message-ID: <051EPSJ13@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a set of computers that seem to have memory leak under 2.6 kernels
(2.6.9 and 2.6.10)

The set of machines that suffer this memory leak are the ones using ICH5 SATA
and Broadcom gigabit (tigon3) on PCI Express, as opposed to other machines with
IDE and Intel gigabit. Both sets of machines use hyper threading.
On all machines, the memory report below is after restarting all but init
processes, so memory consumed by applications is less than 50 MB.

/proc/meminfo just after booting:
MemTotal:       906784 kB
MemFree:        859228 kB
Buffers:          1852 kB
Cached:          15624 kB
SwapCached:          0 kB
Active:          27600 kB
Inactive:        10640 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       906784 kB
LowFree:        859228 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              28 kB
Writeback:           0 kB
Mapped:          21492 kB
Slab:             5640 kB
CommitLimit:    453392 kB
Committed_AS:    32532 kB
PageTables:         80 kB
VmallocTotal:   122804 kB
VmallocUsed:      8160 kB
VmallocChunk:   114416 kB

/proc/meminfo after several days of intense activity (after restarting all
user land processes except init):
MemTotal:       906784 kB
MemFree:        438796 kB
Buffers:          9304 kB
Cached:          14088 kB
SwapCached:          0 kB
Active:         273772 kB
Inactive:       179304 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       906784 kB
LowFree:        438796 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              40 kB
Writeback:           0 kB
Mapped:          39700 kB
Slab:            11256 kB
CommitLimit:    453392 kB
Committed_AS:    55308 kB
PageTables:        120 kB
VmallocTotal:   122804 kB
VmallocUsed:      8160 kB
VmallocChunk:   114416 kB

Hardware of boxes having memory leak problems:
8086 	Intel Corporation 	2580 	915G/P/GV 	0 		Host Bridge / DRAM Controller
8086 	Intel Corporation 	2581 	915G/P/GV, 925X/XE? 	0 		Host-PCI Express Bridge
8086 	Intel Corporation 	2582 	82915G 	B 		Graphics device
8086 	Intel Corporation 	2782 		0 		
8086 	Intel Corporation 	2660 	82801FB/FR/FW/FRW 	0 		PCI Express Port 1
8086 	Intel Corporation 	2662 	82801FB/FR/FW/FRW 	0 		PCI Express Port 2
8086 	Intel Corporation 	2658 	82801FB/FR/FW/FRW 	15 		USB UHCI Controller
8086 	Intel Corporation 	2659 	82801FB/FR/FW/FRW 	16 		USB UHCI Controller
8086 	Intel Corporation 	265A 	82801FB/FR/FW/FRW 	12 		USB UHCI Controller
8086 	Intel Corporation 	265B 	82801FB/FR/FW/FRW 	17 		USB UHCI Controller
8086 	Intel Corporation 	265C 	82801FB/FR/FW/FRW 	9 		USB 2.0 EHCI Controller
8086 	Intel Corporation 	244E 	82801BA/CA/DB/DBL/Ex/Fx/FRW, 6300ESB 	0 		Hub Interface to PCI Bridge
8086 	Intel Corporation 	266E 	82801FB/FR/FW/FRW 	A 		AC '97 Audio Controller
8086 	Intel Corporation 	2640 	82801FB/FR 	0 		LPC Interface Bridge
8086 	Intel Corporation 	266F 		10 		
8086 	Intel Corporation 	2651 	82801FB/FW 	14 		SATA Controller
8086 	Intel Corporation 	266A 	82801FB/FR/FW/FRW 	A 		SMBus Controller
14E4 	Broadcom Corporation 	1677 	BCM5751 	10 		NetXtreme Gigabit Ethernet PCI Express

Hardware of machines with no memory leak problems:
8086 	Intel Corporation 	2570 	82865G/PE/P, 82848P 	0 		DRAM Controller / Host-Hub Interface
8086 	Intel Corporation 	2572 	82865G 	B 		Integrated Graphics Device
8086 	Intel Corporation 	24D2 	82801EB/ER 	B 		USB UHCI Controller #1
8086 	Intel Corporation 	24D7 	82801EB/ER 	A 		USB UHCI Controller #3
8086 	Intel Corporation 	24DE 	82801EB/ER 	B 		USB UHCI Controller #4
8086 	Intel Corporation 	24DD 	82801EB/ER 	9 		USB EHCI Controller
8086 	Intel Corporation 	244E 	82801BA/CA/DB, 6300ESB 	0 		Hub Interface to PCI Bridge
8086 	Intel Corporation 	24D0 	82801EB/ER 	0 		LPC Interface Bridge
8086 	Intel Corporation 	24DB 	82801EB/ER 	12 		EIDE Controller
8086 	Intel Corporation 	24D3 	82801EB/ER 	5 		SMBus Controller
8086 	Intel Corporation 	24D5 	82801EB/ER 	5 		AC'97 Audio Controller
8086 	Intel Corporation 	100E 	82540EM 	12 		Gigabit Ethernet Controller


