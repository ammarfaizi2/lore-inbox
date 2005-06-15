Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVFOUKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFOUKR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFOUKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:10:17 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:62886 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261199AbVFOUJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:09:58 -0400
Date: Wed, 15 Jun 2005 22:09:57 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Gr?goire Favre <gregoire.favre@gmail.com>, dino@in.ibm.com,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
Message-ID: <20050615200957.GA23096@janus>
References: <1118590709.4967.6.camel@mulgrave> <20050613145000.GA12057@gmail.com> <1118674783.5079.9.camel@mulgrave> <20050613183719.GA8653@gmail.com> <1118695847.5079.41.camel@mulgrave> <20050613214208.GA7471@janus> <1118703593.5079.56.camel@mulgrave> <20050614214226.GA15560@janus> <20050615120237.GB19645@janus> <1118844888.5045.18.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118844888.5045.18.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 09:14:48AM -0500, James Bottomley wrote:
> 
> http://parisc-linux.org/~jejb/scsi_diffs/scsi-misc-2.6.diff

Not an improvement for me: now the driver goes into battle with my other
SCSI device, a CD burner. It hangs completely during boot, no alt-sysrq-anything.

Screen capture at hanging point, see http://www.frankvm.com/tmp/hang.jpg

/proc/scsi info under 2.6.11-rc5 (it just happens to be the previous
kernel I use):

$ cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: WANGTEK  Model: 5525ES SCSI      Rev: 73F 
  Type:   Sequential-Access                ANSI SCSI revision: 02
$ cat /proc/scsi/aic7xxx/0 
Adaptec AIC7xxx driver version: 6.2.36
Adaptec aic7890/91 Ultra2 SCSI adapter
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Allocated SCBs: 4, SG List Length: 128

Serial EEPROM:
0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3b3 0xc3bb 0xc3bb 0xc3bb 
0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 0xc3bb 
0x18a2 0x1c5e 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x98b4 

Target 0 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 1 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 2 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 3 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
        Goal: 10.000MB/s transfers (10.000MHz, offset 15)
        Curr: 10.000MB/s transfers (10.000MHz, offset 15)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 8
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 4 Negotiation Settings
        User: 6.600MB/s transfers (16bit)
        Goal: 3.300MB/s transfers
        Curr: 3.300MB/s transfers
        Channel A Target 4 Lun 0 Settings
                Commands Queued 2
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Target 5 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 6 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 7 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 8 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 9 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 10 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 11 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 12 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 13 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 14 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 15 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)

-- 
Frank
