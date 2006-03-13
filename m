Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWCMSCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWCMSCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCMSCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:02:42 -0500
Received: from web50101.mail.yahoo.com ([206.190.38.29]:20331 "HELO
	web50101.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751361AbWCMSCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:02:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=o7vYAIuZG+HCP0G4JHWR67DKf6CsBAzfvRvjqoedST7q9y2oQrncl6O17zoJrhIAVj0IhtRrqYzq63tHMHP1XL6u855CF7bRdVpHWy82+jAOf/rfGLuvHk2fhwalExNd3sW8D87cqnKrT7pKdF8scwxnW1qINi60Cg8kmLwNKpo=  ;
Message-ID: <20060313180238.10166.qmail@web50101.mail.yahoo.com>
Date: Mon, 13 Mar 2006 10:02:38 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: BUG: soft lockup detected on CPU#0!  on 2.6.16-rc5
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Tyan S881 quad socket mobo with 4 880 opterons on which I am transitioning to our
manufacturing. In that process I am building up a 24 burnin process test script. I left it running
over the weekend as a 3 development stage (2 Previous test runs). This run added more memory
testing and disk testing, as well more CPU stressing.

This morining I got the following:

BUG: soft lockup detected on CPU#0!
CPU 0:
Modules linked in: ipv6 sata_sil 3w_9xxx 3w_xxxx mptspi mptscsih mptbase aic79xx
scsi_transport_spi af_packet i2c_nforce2 sata_nv libata forcedeth k8_edac edac_mc tg3
Pid: 28099, comm: tee Not tainted 2.6.16-rc5 #3
RIP: 0010:[<ffffffff80329de1>] <ffffffff80329de1>{_write_lock_irqsave+109}
RSP: 0000:ffff81012eab1d98  EFLAGS: 00000283
RAX: 0000000000fffffe RBX: ffffffff80329d67 RCX: 0000000000000003
RDX: 0000000000000213 RSI: ffff81012eab0010 RDI: 0000000000000003
RBP: 0000000000000001 R08: ffff81010ae28b90 R09: ffffffff801879b0
R10: ffff810008002260 R11: ffffffff801879b0 R12: 0000000000000000
R13: ffffffff801879b0 R14: ffffffff801852c3 R15: ffff81007f406780
FS:  00002b4d28b394c0(0000) GS:ffffffff804ae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b4d289797d3 CR3: 0000000000101000 CR4: 00000000000006e0

Call Trace: <ffffffff80329dc9>{_write_lock_irqsave+85}
       <ffffffff8012e2c5>{do_exit+1334} <ffffffff8012e742>{sys_exit_group+0}
       <ffffffff80137b94>{get_signal_to_deliver+1415} <ffffffff8010a06d>{do_signal+109}
       <ffffffff80329d67>{_spin_unlock+44} <ffffffff8016ade0>{shmem_file_write+511}
       <ffffffff8010af6c>{retint_signal+61}

Not all the modules have associated hardware.

lspci output follows:

0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
0000:00:04.1 Modem: nVidia Corporation: Unknown device 0058 (rev a2)
0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
0000:00:07.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Controller (rev f3)
0000:00:08.0 RAID bus controller: nVidia Corporation CK804 Serial ATA Controller (rev f3)
0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
0000:00:0a.0 Ethernet controller: nVidia Corporation CK804 Ethernet Controller (rev a3)
0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport
Technology Configuration
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport
Technology Configuration
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport
Technology Configuration
0000:00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport
Technology Configuration
0000:00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
0000:00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
0000:00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
0000:01:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller
(PHY/Link)
0000:01:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:08:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:08:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
0000:08:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:08:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
0000:09:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:09:02.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)


The test output indicates the test reached 23 h 55 minutes and no further progression is occuring.
But the BUG output re-occurs every 30 seconds or so.

FYI

doug t




"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

