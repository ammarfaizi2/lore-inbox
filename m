Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVEQRAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVEQRAE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 13:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEQQ7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:59:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:2045 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261854AbVEQQ6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:58:40 -0400
Date: Tue, 17 May 2005 22:38:24 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, gregoire.favre@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050517170824.GA3931@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050516085832.GA9558@gmail.com> <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org> <1116340465.4989.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116340465.4989.2.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 09:34:25AM -0500, James Bottomley wrote:
> > >  target0:0:1: Ending Domain Validation
> > > (scsi0:A:15:0): refuses WIDE negotiation.  Using 8bit transfers   <============
> > > scsi0:0:15:0: Attempting to queue an ABORT message
> > > CDB: 0x12 0x0 0x0 0x0 0x36 0x0
> 
> Actually, this isn't a me too.  The previous one looks like some strange
> DV failure.  This is a problem with the initial inquiry.  What's the
> device at target 15?

Not sure what is it that you want, but here is the lspci -vv
(It is a IBM x370 box)

00:0e.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
        Subsystem: Adaptec: Unknown device 080f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 100 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 51
        BIST result: 00
        Region 0: I/O ports at 2200 [disabled] [size=256]
        Region 1: Memory at f9ffd000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


And here is the output when it boots up fine without the warnings on 2.6.12-rc2

May  9 12:03:32 llm09 kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
May  9 12:03:32 llm09 kernel:         <Adaptec aic7896/97 Ultra2 SCSI adapter>
May  9 12:03:32 llm09 kernel:         aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs
May  9 12:03:32 llm09 kernel:
May  9 12:03:32 llm09 kernel: (scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
May  9 12:03:32 llm09 kernel:   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
May  9 12:03:32 llm09 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May  9 12:03:32 llm09 kernel: scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
May  9 12:03:32 llm09 kernel: ACPI: No ACPI bus support for 0:0:0:0
May  9 12:03:32 llm09 kernel: (scsi0:A:1): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
May  9 12:03:32 llm09 kernel:   Vendor: IBM-PSG   Model: ST39103LC     !#  Rev: B227
May  9 12:03:32 llm09 kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
May  9 12:03:32 llm09 kernel: scsi0:A:1:0: Tagged Queuing enabled.  Depth 32
May  9 12:03:32 llm09 kernel: ACPI: No ACPI bus support for 0:0:1:0
May  9 12:03:32 llm09 kernel:   Vendor: IBM CORP  Model: GEM312 V002       Rev: 4.1b
May  9 12:03:32 llm09 kernel:   Type:   Processor                          ANSI SCSI revision: 02
May  9 12:03:32 llm09 kernel: ACPI: No ACPI bus support for 0:0:15:0
May  9 12:03:32 llm09 kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
May  9 12:03:32 llm09 kernel:         <Adaptec aic7896/97 Ultra2 SCSI adapter>
May  9 12:03:33 llm09 kernel:         aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
May  9 12:03:33 llm09 kernel:
May  9 12:03:33 llm09 kernel: SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
May  9 12:03:33 llm09 kernel: SCSI device sda: drive cache: write through
May  9 12:03:33 llm09 kernel: SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
May  9 12:03:33 llm09 kernel: SCSI device sda: drive cache: write through
May  9 12:03:33 llm09 kernel:  sda: sda1 sda2 sda3
May  9 12:03:33 llm09 kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
May  9 12:03:33 llm09 kernel: SCSI device sdb: 17774160 512-byte hdwr sectors (9100 MB)
May  9 12:03:33 llm09 kernel: SCSI device sdb: drive cache: write through
May  9 12:03:33 llm09 kernel: SCSI device sdb: 17774160 512-byte hdwr sectors (9100 MB)
May  9 12:03:33 llm09 kernel: SCSI device sdb: drive cache: write through
May  9 12:03:33 llm09 kernel:  sdb: sdb1
May  9 12:03:33 llm09 kernel: Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
May  9 12:03:33 llm09 kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
May  9 12:03:33 llm09 kernel: Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
May  9 12:03:33 llm09 kernel: Attached scsi generic sg2 at scsi0, channel 0, id 15, lun 0,  type 3


Hope this helps

	-Dinakar	

