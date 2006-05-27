Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWE0VHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWE0VHl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWE0VHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 17:07:40 -0400
Received: from h-68-166-120-83.cmbrmaor.covad.net ([68.166.120.83]:52876 "EHLO
	qix.demiurgestudios.com") by vger.kernel.org with ESMTP
	id S964969AbWE0VHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 17:07:40 -0400
Date: Sat, 27 May 2006 17:07:15 -0400
From: Andrew Moise <chops@demiurgestudios.com>
To: linux-kernel@vger.kernel.org
Subject: DMA errors, then I/O errors, on 2.6.16
Message-ID: <20060527210715.GA2866@qix.demiurgestudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Running 2.6.16 (and some earlier 2.6 kernels as well), I get
occasional DMA failures, which are always followed by the disk not
working at all (any request leads to an I/O error).  The log and whatnot
follows.  Can anyone tell me what the source of this trouble might be
(disk, controller, cable, software)?
  Please CC replies to me, as I'm not on the list.  Thanks.

--- Log:

May 27 16:34:44 vino kernel: hda: dma_intr: status=0x7f { DriveReady DeviceFault
 SeekComplete DataRequest CorrectedError Index Error } 
May 27 16:34:44 vino kernel: hda: dma_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=1495
68083689343, high=8914952, low=8355711, sector=356876123 
May 27 16:34:44 vino kernel: ide: failed opcode was: unknown 
May 27 16:34:44 vino kernel: hda: DMA disabled 
May 27 16:34:44 vino kernel: ide0: reset: master: error (0x0a?) 
May 27 16:34:44 vino kernel: hda: task_in_intr: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error } 
May 27 16:34:44 vino kernel: hda: task_in_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=
149568083689343, high=8914952, low=8355711, sector=356876123 
May 27 16:34:44 vino kernel: ide: failed opcode was: unknown 
May 27 16:34:44 vino kernel: ide0: reset: master: error (0x0a?) 
May 27 16:34:44 vino kernel: end_request: I/O error, dev hda, sector 356876123 
May 27 16:34:44 vino kernel: end_request: I/O error, dev hda, sector 356876131 

  ... and so on, for many more I/O errors.

--- Version:

Linux version 2.6.16-1-486 (Debian 2.6.16-12) (waldi@debian.org) (gcc version 4.0.4 20060422 (prerelease) (Debian 4.0.3-2)) #2 Thu May 4 18:15:54 UTC 2006

--- Disk controller:

0000:00:11.1 IDE interface: VIA Technologies, Inc.  VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.: Unknown device aa01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

