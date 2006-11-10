Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966101AbWKJURE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966101AbWKJURE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 15:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966103AbWKJURE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 15:17:04 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:40297 "EHLO
	outbound1-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S966101AbWKJURB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 15:17:01 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: 2.6.19-rc5 x86_64 irq 22: nobody cared
Date: Fri, 10 Nov 2006 12:16:20 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071DD@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc5 x86_64 irq 22: nobody cared
Thread-Index: AccEroVUW44BdLukSuSTWnsxTIAIOgARK99wAARL5vA=
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@suse.de>, "Olivier Nicolas" <olivn@trollprod.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Andrew Morton" <akpm@osdl.org>
cc: "Adrian Bunk" <bunk@stusta.de>, "Stephen Hemminger" <shemminger@osdl.org>,
       "Takashi Iwai" <tiwai@suse.de>, "Jaroslav Kysela" <perex@suse.cz>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com,
       linux-acpi@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Lu, Yinghai" <yinghai.lu@amd.com>
X-OriginalArrivalTime: 10 Nov 2006 20:16:21.0167 (UTC)
 FILETIME=[165F53F0:01C70505]
X-WSS-ID: 694A019E1X42333334-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That didn't fix the bug.



-----Original Message-----
From: Olivier Nicolas [mailto:olivn@trollprod.org] 
Sent: Friday, November 10, 2006 12:03 PM
To: Lu, Yinghai
Subject: Re: 2.6.19-rc5 x86_64 irq 22: nobody cared

Bad day today,

Kernel compiled with the first parch irq_mcp55.diff

and with the disable_msi option removed.



#options snd-hda-intel disable_msi=1


ACPI: PCI Interrupt Link [ASA2] enabled at IRQ 21
__assign_irq_vector: irq=15, vector=79, domain=000000ff, mask=00000003,
cpu_online_map=00000003
ACPI: PCI Interrupt 0000:00:0d.2[C] -> Link [ASA2] -> GSI 21 (level,
low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:0d.2 to 64
ata5: SATA max UDMA/133 cmd 0xC400 ctl 0xC002 bmdma 0xB400 irq 21
ata6: SATA max UDMA/133 cmd 0xBC00 ctl 0xB802 bmdma 0xB408 irq 21

ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0e.1[B] -> Link [AAZA] -> GSI 21 (level,
low) -> IRQ 21
__assign_irq_vector: irq=139, vector=91, domain=000000ff, mask=00000003,
cpu_online_map=00000003
__assign_irq_vector: irq=139, old_vector=91, domain=000000ff,
mask=00000003, cpu_online_map=00000003
PCI: Setting latency timer of device 0000:00:0e.1 to 64
irq 21: nobody cared (try booting with the "irqpoll" option)

Call Trace:
 <IRQ>  [<ffffffff8025a055>] __report_bad_irq+0x35/0x90
 [<ffffffff8025a2d3>] note_interrupt+0x223/0x280
 [<ffffffff8025ad41>] handle_fasteoi_irq+0xb1/0xf0
 [<ffffffff8020b17c>] call_softirq+0x1c/0x30
 [<ffffffff8020d1ba>] do_IRQ+0x8a/0xe0
 [<ffffffff802092f0>] default_idle+0x0/0x50
 [<ffffffff8020a571>] ret_from_intr+0x0/0xa
 <EOI>  [<ffffffff80209319>] default_idle+0x29/0x50
 [<ffffffff8020939b>] cpu_idle+0x5b/0x80
 [<ffffffff8050039c>] start_secondary+0x50c/0x520

handlers:
[<ffffffff8807f150>] (nv_generic_interrupt+0x0/0xc0 [sata_nv])
Disabling IRQ #21
ALSA sound/pci/hda/hda_intel.c:543: hda_intel: No response from codec,
disabling MSI...

So kernl assign irq 21 to sata2, and later share irq 21 with audio.

But audio get MSI, and at that time, it may do sth bad to irq21 that it
is still shared with SATA2.

YH



