Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWJBR2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWJBR2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWJBR2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:28:37 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:8516 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965159AbWJBR2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:28:36 -0400
X-IronPort-AV: i="4.09,245,1157353200"; 
   d="scan'208"; a="344157118:sNHT55678840"
To: linux-kernel@vger.kernel.org
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>,
       Satoru Takeuchi <takeuchi_satoru@jp.fujitsu.com>,
       Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: The change "PCI: assign ioapic resource at hotplug" breaks my system
X-Message-Flag: Warning: May contain useful information
References: <adar6xqwsuw.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 02 Oct 2006 10:28:34 -0700
In-Reply-To: <adar6xqwsuw.fsf@cisco.com> (Roland Dreier's message of "Mon, 02 Oct 2006 10:05:43 -0700")
Message-ID: <adafye6wrst.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Oct 2006 17:28:35.0099 (UTC) FILETIME=[306AFEB0:01C6E648]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One piece of information that might be useful is that lspci shows a
difference in the configuration of the PCI bridge IOAPIC.  In the good
(working) case, the IOAPIC memory region 0 is disabled, while in the
bad case it is enabled.

Here are full details: first, the good/working case:

	04:01.1 PIC: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC (rev 12) (prog-if 10 [IO-APIC])
		Subsystem: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0
		Region 0: Memory at <ignored> (64-bit, non-prefetchable)
	00: 22 10 59 74 06 00 00 02 12 10 00 08 00 00 00 00
	10: 04 e0 af fe 00 00 00 00 00 00 00 00 00 00 00 00
	20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 59 74
	30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00
	40: 00 00 00 00 03 00 00 00 04 e0 af fe 00 00 00 00

Then the bad (non-working e1000) case:

	04:01.1 PIC: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC (rev 12) (prog-if 10 [IO-APIC])
		Subsystem: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0
		Region 0: Memory at e2100000 (64-bit, non-prefetchable) [size=4K]
	00: 22 10 59 74 06 00 00 02 12 10 00 08 00 00 00 00
	10: 04 00 10 e2 00 00 00 00 00 00 00 00 00 00 00 00
	20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 59 74
	30: 00 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00
	40: 00 00 00 00 03 00 00 00 04 00 10 e2 00 00 00 00

I have no idea whether there's any significance to this.

 - R.
