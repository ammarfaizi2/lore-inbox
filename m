Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbTGOOsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268276AbTGOOsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:48:55 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:57519 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S268260AbTGOOsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:48:54 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Andi Kleen" <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Date: Tue, 15 Jul 2003 11:14:16 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <m3el0stw23.fsf@averell.firstfloor.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply, Andi.

>> We have a proprietary PCI board installed in a (UP) system with an ASUS
P4PE
>> motherboard (uses Intel 845PE chipset). This system is running Red Hat
9.0

>Have you checked the 845 errata sheets on the Intel website?
>Perhaps it is some known hardware bug.

>One thing you could try is to use Local APIC / IO APIC interrupt processing
>instead of 8259.

Our hardware engineer has combed the Intel and ASUS websites, but found
nothing.  I'll give the APIC a try and see if I get different results and
let you know.

>>
>> /* start timer */
>> dmatimer.expires = jiffies + 0.5*HZ;

>That's a serious bug. You cannot use floating point in the kernel.
>It will corrupt the FP state of the user process.

HZ on the INTEL platform is 100, so this should simply add 50 to the current
value of jiffies.  Besides, assigning the value to the unsigned int field
(expires) will truncate it to an integer anyway.  Is there a more
appropriate way to handle a short timeout?

Thanks,
Kathy

