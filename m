Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSIEUzu>; Thu, 5 Sep 2002 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIEUzu>; Thu, 5 Sep 2002 16:55:50 -0400
Received: from Scotty-EUnet.AT.EU.net ([193.83.12.34]:25757 "EHLO
	www.scotty.co.at") by vger.kernel.org with ESMTP id <S318032AbSIEUzs>;
	Thu, 5 Sep 2002 16:55:48 -0400
Message-ID: <3D77C5C7.3010909@fl.priv.at>
Date: Thu, 05 Sep 2002 22:59:51 +0200
From: Friedrich Lobenstock <fl@fl.priv.at>
Reply-To: Linux-SCSI Mailingliste <linux-scsi@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; ast-ES; rv:1.0.0) Gecko/20020529
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dag Nygren <dag@newtech.fi>
CC: Linux-SCSI Mailingliste <linux-scsi@vger.kernel.org>,
       Linux-Kernel Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: blocksize limitations in scsi tape driver (st) when used with
  DLT1 tape drives?
References: <20020905200208.22430.qmail@dag.newtech.fi>
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dag Nygren wrote:
> I have successfully been using Legato Networker with a
> blocksize of 32k with my DLT here.
> 
> But the way Legato wants to do it is to decide about the
> blocksize itself.
> This means that the driver should NOT decide on the BS, but
> pass on anything written through it, meaning a blocksize setting
> of 0 (or variable blocksize).
> 
> Perhaps Arkeia works the same way ?

I used variable blocksize (=0) before but then after about 3.5 gigs stored
on the tape I get scsi-error and arkeia interprets this as end-of-tape.

Aug  6 02:13:50 filesrv kernel: st0: Error with sense data: Info fld=0x2000, Deferred st09:00: sns = f1  3
Aug  6 02:13:50 filesrv kernel: ASC=80 ASCQ= 1
Aug  6 02:13:50 filesrv kernel: Raw sense data:0xf1 0x00 0x03 0x00 0x00 0x20 0x00 0x16 0x00 0x00 0xe6 0xc2 0x80 0x01 0x00 0x00 0x00 0x00 0x83 0x00 0x37 0x00 0x00 0x00 0x21 0x00 0x90 0x7f 0x3a 0x00
Aug  6 02:13:50 filesrv kernel: klogd 1.4.1, ---------- state change ----------
Aug  6 02:13:50 filesrv kernel: Inspecting /boot/System.map-2.4.18-64GB-SMP
Aug  6 02:13:50 filesrv kernel: Loaded 13537 symbols from /boot/System.map-2.4.18-64GB-SMP.
Aug  6 02:13:50 filesrv kernel: Symbols match kernel version 2.4.18.
Aug  6 02:13:50 filesrv kernel: Loaded 481 symbols from 13 modules.
Aug  6 02:13:50 filesrv kernel: st0: Error with sense data: Info fld=0x1, Current st09:00: sns = f0  3
Aug  6 02:13:50 filesrv kernel: ASC= c ASCQ= 0
Aug  6 02:13:50 filesrv kernel: Raw sense data:0xf0 0x00 0x03 0x00 0x00 0x00 0x01 0x16 0x00 0x00 0xe6 0xc2 0x0c 0x00 0x00 0x00 0x00 0x00 0x83 0x00 0x37 0x00 0x00 0x00 0x21 0x00 0x90 0x7f 0x3a 0x00

I had this problem with LTO drives too and here the arkeia faq tells one
to set fixed block size.

And when you look a the HP document referenced in my last mail:

    ISSUE: Block sizes of LESS THAN 64 KB for DLT1/DLT VS80 and 32 KB for
           all other DAT and DLT drives can drastically increase the backup/restore
           time and severely affect the performance of the drive.

SOLUTION: Most backup applications allow viewing and adjusting the block
           size used for a particular device. See below for advice on how
           to achieve this for CA ARCserve, Veritas Backup Exec and Tapeware.

(I capitalized "less than" to emphasis its occurance)

I you missed the link here it is again:
   http://www.hp.com/cposupport/information_storage/support_doc/lpg50167.html

Did you check with mt after Legato Networker did a backup which blocksize
it set?

-- 
MfG / Regards
Friedrich Lobenstock


