Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbQKBUEK>; Thu, 2 Nov 2000 15:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129471AbQKBUEB>; Thu, 2 Nov 2000 15:04:01 -0500
Received: from smartmail.smartweb.net ([207.202.14.198]:58889 "EHLO
	smartmail.smartweb.net") by vger.kernel.org with ESMTP
	id <S129377AbQKBUDx>; Thu, 2 Nov 2000 15:03:53 -0500
Message-ID: <3A01C8B2.23D6E9C4@dm.ultramaster.com>
Date: Thu, 02 Nov 2000 15:04:02 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: blk-7 fails to boot (against 2.4.0-test10)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens.

I wanted to try out blk-7 to see if it cured the abysmal I/O
performance  
on 2.4.0-test10, but it won't boot on my system.  The last message I
see  
is the banner of the SCSI host adapter init (it found the card) but
it    
never actually lists the devices on the host...  weird place to crash
actually.  I tried it twice, and waited about a minute each time for it
to
make progress.

In other words, this appears:

(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 0/11/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>

But it never makes it to:

(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 15.
  Vendor: SEAGATE   Model: ST39102LW         Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:2:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: IBM       Model: DNES-318350W      Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03


Does this ring a bell?  I tried using SYSRQ and it shows the 'current'
as kapmd-idled and the showPc shows the PC at c01108ff ->
apm_bios_call_simple.  Hmm.

I'll try any subsequent patch you can offer.

My system is a single processor Athlon 700, 256mb ram, 2.4.0-test10 plus
blk-7.

David Mansfield

P.S. I added the #define ELEVATOR_MERGE_HOLE 3 like someone else
mentioned, and the patch applied cleanly except filemap.c which was
offset -20 lines.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
