Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUFSUBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUFSUBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUFSUBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:01:24 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:35547 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263448AbUFSUBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:01:22 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Ricky Beam <jfbeam@bluetronic.net>
Subject: Re: SATA 3112 errors on 2.6.7
Date: Sat, 19 Jun 2004 22:10:05 +0200
User-Agent: KMail/1.5
Cc: Eric Buddington <ebuddington@verizon.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.33.0406181831180.25702-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0406181831180.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406192210.05455.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 of June 2004 01:06, Ricky Beam wrote:
> On Sat, 19 Jun 2004, R. J. Wysocki wrote:
> >Are your drives out of Seagate, maybe?  If not, what make are they?
>
> (As I said in a previous email...) 4 x Seagate ST3160023AS's RAID0'd
> together in a BIOS "raid" mode compatable manner.

Sorry, I should have noticed.

Anyway, it looks like a pattern is forming which smells bad to me.

Apparently, we have:
1) A serious error condition that occurs on Seagate SATA drives connected to 
Silicon Image controllers.
2) As of today we can say that it only occurs on Seagate drives (Ricky, do I 
remember correctly that you see faulty behavior of such drives with a 3ware 
RAID?).
3) The error is reported by the kernel like that:

ata1: DMA timeout, stat 0x1
ATA: abnormal status 0x58 on port 0xCF819087
scsi0: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 03 ca 47 00 00 00 
00
Current sda: sense key Medium Error
Additional sense: Unrecovered read error - auto reallocate failed
end_request: I/O error, dev sda, sector 248391

Afterwards, the drive blocks its SATA bus in a "busy" mode and cannot be 
accessed by any means (ie. hardware reset is necessary).
4) The most "reliable" way to trigger this condition is to copy a lot of data 
(eg. 2 GB) to the drive in one shot.

Do we agree on that?

rjw

