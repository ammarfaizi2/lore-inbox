Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWIFLCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWIFLCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIFLCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:02:24 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:33489 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1750717AbWIFLCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:02:22 -0400
Date: Wed, 6 Sep 2006 13:01:47 +0200
From: Olaf Hering <olaf@aepfle.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060906110147.GA12101@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060905122656.GA3650@aepfle.de> <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, James Bottomley wrote:

> On Tue, 2006-09-05 at 14:26 +0200, Olaf Hering wrote:
> > <4>Machine check in kernel mode.
> > <4>Caused by (from SRR1=49030): Transfer error ack signal
> > <4>Oops: Machine check, sig: 7 [#1]
> [...]
> > <4> scsi0: PCI error Interrupt at seqaddr = 0x8
> 
> Is this actually a PCI bus error?  In which case it's probably the
> ahc_inb(,SBLKCTL) of ahc_linux_get_signalling().  Can you verify this?
> And what happens when you try to cat /proc/scsi_host/host<n>/signalling
> for this card?

This causes another machine check because it runs ahc_inb(ahc, SBLKCTL) again.
With debug I get:

CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=2047
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y


<4>ahc_pci:1:4:0: hardware scb 64 bytes; kernel scb 52 bytes; ahc_dma 8 bytes
<6>scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
<4>        <Adaptec 2940B Ultra2 SCSI adapter>
<4>        aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
<4>
<5>  Vendor: IBM       Model: DDRS-39130D       Rev: DC2A
<5>  Type:   Direct-Access                      ANSI SCSI revision: 02
<4>scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
<6> target0:0:0: Beginning Domain Validation
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0xc0
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x20
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x3
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x2
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x3
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_OUT PHASEMIS in Message-in phase
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x2
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x3
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x1
<4>scsi0:A:0:0: Asserting ATN for response
<4>scsi0:A:0:0: INITIATOR_MSG_IN PHASEMIS in Message-out phase
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x3
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x45
<4>scsi0:A:0:0: INITIATOR_MSG_OUT byte 0x0
<4>scsi0:A:0:0: INITIATOR_MSG_OUT PHASEMIS in Message-in phase
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x3
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x1
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x45
<4>scsi0:A:0:0: INITIATOR_MSG_IN byte 0x0
<6> target0:0:0: wide asynchronous
<4>scsi0:A:0:0: INITIATOR_MSG_IN PHASEMIS in Command phase
<4>Machine check in kernel mode.
<4>Caused by (from SRR1=49030): Transfer error ack signal
<4>Oops: Machine check, sig: 7 [#1]
<4>
<4>Modules linked in: aic7xxx scsi_transport_spi cpufreq_ondemand loop nfs nfs_acl lockd sunrpc sg st sd_mod sr_mod scsi_mod ide_cd cdrom
<4>NIP: D21F0604 LR: D20D9494 CTR: D21F05EC
<4>REGS: cf80d9f0 TRAP: 0200   Not tainted  (2.6.18-rc6-20060905-default)
<4>MSR: 00049030 <EE,ME,IR,DR>  CR: 22022242  XER: 00000000
<4>TASK = cf7e8760[963] 'insmod' THREAD: cf80c000
<6>GPR00: 000000FF CF80DAA0 CF7E8760 CEA58400 CF80DA6C CEA58000 CEA58100 00000000
<6>GPR08: 00000001 D105C000 CF6E3C00 00000000 2155D240 100290EC 0000000F D22C0498
<6>GPR16: 0000001E D229F258 C373D500 D229F230 CEA589CC CEA58818 CEA588BC CEA58400
<6>GPR24: CEA58800 CEA589A0 FFFFFFFF C37C2000 CEA589A0 CEA58800 CEA59C00 CEA58C00
<4>NIP [D21F0604] ahc_linux_get_signalling+0x18/0xa8 [aic7xxx]
<4>LR [D20D9494] spi_dv_device+0x338/0x51c [scsi_transport_spi]
<4>Call Trace:
<4>[CF80DAA0] [D20D9364] spi_dv_device+0x208/0x51c [scsi_transport_spi] (unreliable)
<4>[CF80DAF0] [D21F0A6C] ahc_linux_slave_configure+0xfc/0x114 [aic7xxx]
<4>[CF80DB30] [D20B71D8] scsi_probe_and_add_lun+0x8d4/0xa40 [scsi_mod]
<4>[CF80DB90] [D20B78F8] __scsi_scan_target+0xd8/0x630 [scsi_mod]
<4>[CF80DC20] [D20B7E9C] scsi_scan_channel+0x4c/0x9c [scsi_mod]
<4>[CF80DC40] [D20B7FD4] scsi_scan_host_selected+0xe8/0x140 [scsi_mod]
<4>[CF80DC70] [D21F3CA4] ahc_linux_register_host+0x344/0x35c [aic7xxx]
<4>[CF80DD10] [D21F4998] ahc_linux_pci_dev_probe+0x1a8/0x1c8 [aic7xxx]
<4>[CF80DD80] [C016A49C] pci_device_probe+0x6c/0xa0
<4>[CF80DDA0] [C01F0AF4] driver_probe_device+0x60/0xf4
<4>[CF80DDC0] [C01F0CC4] __driver_attach+0x8c/0xf0
<4>[CF80DDE0] [C01F0424] bus_for_each_dev+0x50/0x94
<4>[CF80DE10] [C01F0A08] driver_attach+0x24/0x34
<4>[CF80DE20] [C01F000C] bus_add_driver+0x78/0x128
<4>[CF80DE40] [C01F0FC4] driver_register+0xa0/0xb4
<4>[CF80DE50] [C016A2C8] __pci_register_driver+0x4c/0x8c
<4>[CF80DE60] [D21F47D8] ahc_linux_pci_init+0x20/0x38 [aic7xxx]
<4>[CF80DE70] [D105A3C0] ahc_linux_init+0x3c0/0x530 [aic7xxx]
<4>[CF80DEA0] [C004EB50] sys_init_module+0x1368/0x14f8
<4>[CF80DF40] [C00125A4] ret_from_syscall+0x0/0x40
<4>--- Exception: c01 at 0xff698a4
<4>    LR = 0x10001100
<4>Instruction dump:
<4>38600000 4e800020 38600000 4e800020 4e800020 4e800020 814302ac 800a0000
<4>2f800000 409e0018 812a0004 8809001f <0c000000> 4c00012c 48000028 812a0004
<4> scsi0: PCI error Interrupt at seqaddr = 0x8
<4>scsi0: Signaled a Target Abort

