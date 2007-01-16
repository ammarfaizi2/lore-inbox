Return-Path: <linux-kernel-owner+w=401wt.eu-S1751432AbXAPUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXAPUDW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXAPUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:03:22 -0500
Received: from mga03.intel.com ([143.182.124.21]:28779 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXAPUDU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:03:20 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,197,1167638400"; 
   d="scan'208"; a="169492540:sNHT986414597"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree e1000 driver (regression)
Date: Tue, 16 Jan 2007 12:02:49 -0800
Message-ID: <36D9DB17C6DE9E40B059440DB8D95F5201A78A3B@orsmsx418.amr.corp.intel.com>
In-Reply-To: <4807377b0701161118g7f15f201yea4a4c16c252a864@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: intel 82571EB gigabit fails to see link on 2.6.20-rc5 in-tree e1000 driver (regression)
Thread-Index: Acc5o2q7wpqtLtMlRU+M4lirTrJTPgABctbA
From: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>,
       "Allen Parker" <parker@isohunt.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Kok, Auke-jan H" <auke-jan.h.kok@intel.com>,
       <linux-pci@atrey.karlin.mff.cuni.cz>
X-OriginalArrivalTime: 16 Jan 2007 20:02:50.0652 (UTC) FILETIME=[4CF1CDC0:01C739A9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

added Linux-pci

Jesse Brandeburg wrote:
> On 1/16/07, Allen Parker <parker@isohunt.com> wrote:
>> Allen Parker wrote:
>>> I have a PCI-E pro/1000 MT Quad Port adapter, which works quite well
>>> under 2.6.19.2 but fails to see link under 2.6.20-rc5. Earlier
>>> today I reported this to e1000-devel@lists.sf.net, but thought I
>>> should get the word out in case someone else is testing this kernel
>>> on this nic chipset. 
> 
> Upon some further investigation with Allen, I got this info, and it
> appears that his system is not freeing MSI irq's correctly.
> 
> from our discussion:
>> Allen wrote:
>>> Jesse Brandeburg wrote:
>>> I believe you may have an interrupt delivery problem, due to kernel
>>> changes.  When you don't get interrupts delivered correctly, you may
>>> not achieve link up.
>>> 
>>> you can try disabling CONFIG_PCI_MSI in the kernel, as another
>>> trouble shooting step.  Also, what model motherboard/machine are you
>>> using, and please check to make sure your BIOS is up to date.
>> 
>> CONFIG_PCI_MSI seems to fix it as well, however, i'm not sure about
>> possible performance implications with leaving it turned off.
>> 
>> Tyan S2927G2NR w/ 2x Opteron 2210 bios rev 1.02 iirc
> 
> Also, here is an excerpt of his his proc/interrupts
> Allen Parker wrote:
>        CPU0       CPU1       CPU2       CPU3
> 498:      1          8        129       8723   PCI-MSI-edge      eth3
> 499:      0         42        122      17135   PCI-MSI-edge      eth2
> 500:      0         19        275    1418326   PCI-MSI-edge      eth1
> 501:      0          0          0          0   PCI-MSI-edge      eth1
> 502:      0        414         26      25227   PCI-MSI-edge      eth1
> 503:      0         37        264    1418695   PCI-MSI-edge      eth0
> 504:      0          0          0        139   PCI-MSI-edge      eth0
> 505:      0          6        714      22806   PCI-MSI-edge      eth0
> NMI:    275        207        225        262
> LOC:3531851    3531829    3531805    3531778
> ERR:      0
> 
> The disturbing bit is that on this Hypertransport to PCIe system, his
> interrupts appear to be getting registered multiple times on different
> IRQ numbers.
> 
> help?
