Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVHJCOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVHJCOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 22:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVHJCOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 22:14:44 -0400
Received: from amdext3.amd.com ([139.95.251.6]:4039 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S964870AbVHJCOo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 22:14:44 -0400
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Content-class: urn:content-classes:message
Subject: RE: Please help with following NUMA-related questions
MIME-Version: 1.0
Date: Wed, 10 Aug 2005 10:14:23 +0800
Message-ID: <1784BBD8D1F15B4C9FB0F09F0A939F9001C25198@SZEXMTA4.amd.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Please help with following NUMA-related questions
Thread-Index: AcWRH6JajsJNJ4yfQqK1BUre7Eg6awMMFJ7g
From: "Xie, Bill" <bill.xie@amd.com>
To: "Sheo Shanker Prasad" <ssp@creativeresearch.org>,
       linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 10 Aug 2005 02:14:29.0451 (UTC)
 FILETIME=[3D31C1B0:01C59D51]
X-WSS-ID: 6EE7BC822Q413330058-01-01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

"numactl --show" will tell whether NUMA support is  enabled.

If there is no numactl in your system, you can check the dmesg. System will report 
following words if NUMA support is enabled.

"Scanning NUMA topology in Northbridge 24 "
"  <6>Number of nodes 2 (10010) "
"  <6>Node 0 MemBase 0000000000000000 Limit 000000007fffffff "
"  <6>Node 1 MemBase 0000000080000000 Limit 00000000cbff0000 "

The benefit of NUMA is to bring better memory bandwidth. You can use STREAM to 
test your system memory bandwidth. If bandwidth is better than 6000MBps for your 
2 node Opterons, NUMA works fine.

Correct BIOS setting for NUMA:

band interleave : AUTO
node interleave : DISABLE
SRAT : AUTO

Best Regards
Bill Xie

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sheo Shanker Prasad
Sent: Monday, July 25, 2005 9:48 PM
To: linux-kernel@vger.kernel.org
Subject: Please help with following NUMA-related questions

I will greatly appreciate any help regarding the following matters:

(1) How to know whether my machine is NUMA-aware or not,

(2) Difference between memory bank interleaving and node interleaving

(3) When the BIOS asks me to set bank interleaving as AUTO, then it says that AUTO allows memory access to spread out over banks on the same node or across nodes decreasing memory access contentions. However, I have no idea when the memory access is spread over banks on the same node or across nodes. I also do not know how to tell the machine to access memory across the nodes or on the same node. I have no idea as to how the AUTO choice affects NUMA-awareness.

(4) The BIOS also tells me that I could choose bani interleaving as DISABLED. 
But I do not know what its implications are for NUMA awareness.

Here are other relevant details. I have a dual-Opteron 250 (2.4GHz) set in Tyan Thunder 2885 K8W with AMIBIOS version 2.05.

When I bought it last year, the machine was running under SuSE 9.1 Pro and the Linux kernel was 2.6.5-7.108-smp. At that time both the Hardware Info from YAST and /vat/log/messages were explicitly mentioning things :

Scanning NUMA topology in Northbridge 24
  <6>Number of nodes 2 (10010)
  <6>Node 0 MemBase 0000000000000000 Limit 000000007fffffff
  <6>Node 1 MemBase 0000000080000000 Limit 00000000cbff0000
  <6>Using node hash shift of 24

These messages indicated that NODE interleaving was off and the machine was NUMA-aware.

Then, after a few months, the motherboard failed and the machine was sent to the vendor for repair. It came back with SuSE 9.3 and the Linux kernel version 2.6.11.4-21.7-smp (geeko@buildhost) (gcc version 3.3.5 20050117
(prerelease) (SUSE Linux)) #1 SMP Thu Jun 2 14:23:14 UTC 2005.


Now  both the Hardware Info from YAST and /vat/log/messages DO NOT mention NUMA anywhere, and I do not have anyway to check whether the NODE-Interleaving is OFF or ON. My difficulties are compounded because I do not know how to interpret the chipset related setting in the BIOS.

Currently, in the BIOS setting (Chipset->memory config -> Bank Interleaving), I am asked to choose between AUTO & DISABLED. No choice is offered for Node Interleaving.

The only guidance for the choice is that interleaving allows memory access to spread out over banks on the same node or across nodes decreasing memory access contentions. Nothing is mentioned about what happens when Interleaving is disabled. Furthermore, if I choose AUTO, then I do not know when the memory is spread out over banks on the same node or across nodes.

Any help will be greatly appreciated.

Thanking you in advance.

--
Best regards.

Sheo
(Sheo S. Prasad)
Creative Research Enterprises
6354 Camino del Lago
Pleasanton, CA 94566, USA
Voice Phone: (+1) 925 426-9341
Fax   Phone: (+1) 925 426-9417
e-mail: ssp@CreativeResearch.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

