Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031366AbWLANfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031366AbWLANfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031376AbWLANfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:35:34 -0500
Received: from py-out-1112.google.com ([64.233.166.177]:60746 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1031366AbWLANfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:35:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=F5IRBvIC9rq3sl63RFVtvC0/qL7k2WJJhIEBW1YkpCfQwHCywUcNWrKxndlBDglkHgh9eNHS95iAYYoizIqRFmAk0awonxXW7aKEB1gcH6VtSkZy7nreXInksrbM3i1sdIoj2mi2R5AR7mveQyPBUm2VkTCeGR0/PuKEUiqxcdo=
Message-ID: <45702F9A.5020406@gmail.com>
Date: Fri, 01 Dec 2006 06:35:22 -0700
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com> <455B5ADF.2040503@gmail.com> <20061127033550.GB11250@htj.dyndns.org> <456AA89C.909@gmail.com> <456D4B17.4080503@gmail.com> <456DD70D.1050808@gmail.com> <456FD4CB.8020608@gmail.com>
In-Reply-To: <456FD4CB.8020608@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Berck E. Nash wrote:
>> [   68.242305] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [   98.221334] ata2.00: qc timeout (cmd 0xec)
>> [   98.225467] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
>> [  108.063137] ata2: port is slow to respond, please be patient (Status 0x80)
>> [  131.003980] ata2: port failed to respond (30 secs, Status 0x80)
>> [  131.009930] ata2: COMRESET failed (device not ready)
>> [  131.014926] ata2: hardreset failed, retrying in 5 secs
>> [  138.308717] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>> [  138.319554] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
>> [  138.325157] ata2.00: ata2: dev 0 multi count 1
>> [  138.334245] ata2.00: configured for UDMA/133
> [--snip--]
>> [  143.191590] scsi 2:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
>> [  143.199761] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
>> [  143.205550] sdd: Write Protect is off
>> [  143.209257] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>> [  143.218356] SCSI device sdd: 640 512-byte hdwr sectors (0 MB)
>> [  143.224143] sdd: Write Protect is off
>> [  143.227847] SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
>> [  143.236927]  sdd: unknown partition table
>> [  143.241194] sd 2:0:0:0: Attached scsi disk sdd
>> [  143.245707] sd 2:0:0:0: Attached scsi generic sg3 type 0
> 
> Ahh.. I can't believe I missed this again.  A Port Multiplier is
> attached to your ata2 which is probably a sil3726 or 4726.  Why this
> device fails initial reset is unknown yet.  Anyways, with proper PMP
> support, this problem will go away.  So, this isn't really a ahci issue
> and there's nothing wrong with your disks either.  I'll ask SIMG why
> this happens with the PMP.

Hrm.  It's not a Silicon Image chip, or at least doesn't claim to be:


00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 01) (prog-if 01 [AHCI 1.0])
        Subsystem: ASUSTeK Computer Inc. Unknown device 2606
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 316
        Region 0: I/O ports at e400 [size=8]
        Region 1: I/O ports at e080 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at dc00 [size=4]
        Region 4: I/O ports at d880 [size=16]
        Region 5: Memory at febfb800 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
                Address: fee0300c  Data: 4179
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

And, remember, this behavior started in 2.6.18 and didn't exist in
2.6.17.  Would it help if I narrowed down which patch caused it?

Berck
