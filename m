Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135590AbRD1ScP>; Sat, 28 Apr 2001 14:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135591AbRD1ScG>; Sat, 28 Apr 2001 14:32:06 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:20372 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S135590AbRD1Sby>; Sat, 28 Apr 2001 14:31:54 -0400
Date: Sat, 28 Apr 2001 20:31:43 +0200
From: Cliff Albert <cliff@oisec.net>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010428203143.A27784@oisec.net>
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010428202225.D11994@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sat, Apr 28, 2001 at 08:22:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2001 at 08:22:25PM +0200, Matthias Andree wrote:

> These have further devices (CD writer, CD-ROM drive), and these machines
> are 100% in 2.2.19. With 2.4.3 and 2.4.4-pre8, I get this problem
> (pencil & paper copy for Machine #2, DO NOT "grep"):
> 
> AIC 7XXX EISA/VLB/PCI SCSI HBA DRIVER 6.1.5
> aic7880: wide Channel A, SCSI ID=7, 16/255 SCBs
> scsi0: SCSI host adapter emulation for IDE devices
> PCI: found IRQ 5 for dev 00:09.0
> scsi1:0:0:0: Attempting to queue an abort message.
>              Command found on device queue
> aic7xxx_abort returns 8194

Getting the same errors here, but only a few seconds after my adaptec gets initialized and all disks/cdrs/zips get attached + mounted. On 2.4.3-ac14 it only gives these errors and happily runs afterwards. But on 2.4.4 it panics after $random time.

My setup is a P2B-S motherboard with a Quantum Fireball ST 6.4 GB HDD

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.11
        <Adaptec aic7890/91 Ultra2 SCSI adapter>
        aic7890/91: Wide Channel A, SCSI Id=7, 32/255 SCBs

 Vendor: QUANTUM   Model: FIREBALL ST6.4S   Rev: 0F0C
 Type:   Direct-Access                      ANSI SCSI revision: 02
 (scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)

And the specific errors are

scsi0:0:0:0: Attempting to queue a TARGET RESET message
scsi0:0:0:0: Command not found
aic7xxx_dev_reset returns 8194
Device not ready.  Make sure there is a disc in the drive.

> Then, the Kernel detects the SECOND SCSI disk and attaches it as sda
> (Linux 2.2 would mount that as sdb), the first disk is "gone" (Linux 2.2
> would mount that as sda).  Regretfully, my root partition is on the
> FIRST SCSI disk, so the kernel panicks since it cannot mount /.
> 
> That's all I copied in a hurry, maybe it's sufficient to debug, if not,
> I can try to grab a null modem cable and catch the full sequence; I'd be
> glad if someone could mention the "canonical" aic7xxx LILO append
> parameters for a full debug trace in that case.

-- 
Cliff Albert		| IRCNet:    #linux.nl, #ne2000, #linux, #freebsd.nl
cliff@oisec.net		| 	     #openbsd, #ipv6, #cu2.nl
-[ICQ: 18461740]--------| 6BONE:     CA2-6BONE       RIPE:     CA3348-RIPE
