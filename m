Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129720AbQKTTWS>; Mon, 20 Nov 2000 14:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129553AbQKTTWI>; Mon, 20 Nov 2000 14:22:08 -0500
Received: from f-197-65.cvx.ipdial.viaginterkom.de ([62.180.197.65]:20484 "HELO
	stargate.schirmacher.de") by vger.kernel.org with SMTP
	id <S129166AbQKTTV7>; Mon, 20 Nov 2000 14:21:59 -0500
Message-ID: <01C0532B.427002B0.arne@schirmacher.de>
From: Arne Schirmacher <arne@schirmacher.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: strange interaction between IDE and ieee1394 driver
Date: Mon, 20 Nov 2000 19:51:21 -0000
X-Mailer: Microsoft Internet E-Mail/MAPI - 8.0.0.4211
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I user the ieee1394 subsystem to transmit data from a camcorder to an 
IDE disk and the IDE driver is not using DMA, then there will be some data 
lost in the ieee1394 driver. If I turn on DMA in the IDE driver (hdparm -d1 
/dev/hda), I do not have any data loss in the ieee1394 driver. Also, on a 
system that is using a SCSI disk instead of an IDE disk everything is ok 
too.

This behavior has been observed on several different systems. I can 
reproduce it on my system with kernel 2.2.16 and 2.4.0 test10 with several 
versions of the ieee1394 driver.

My guess is that using the non-DMA mode in the IDE driver is somehow more 
demanding compared to the DMA mode. Since both IDE and ieee1394 chips are 
accessed via the PCI bus, perhaps the traffic is so high that the ieee1394 
data doesn't make it through. But this is just a guess.

The data rate from the camcorder is about 3.6 MByte/sec, the hdparm -Tt 
benchmark show 4.5 MByte/sec transfer speed when not using DMA and 19 
MByte/sec when using DMA. (However even the slow disk speed is fast enough 
to store the video data. The video packets get lost at the ieee1394 driver 
side, not when attempting writing them to a disk file).

Another thing is that there is no handshake available between camcorder and 
ieee1394 interface (it wouldn't make sense for a video appplication). If 
the interface is not listening, the dropped packet can't be retransmitted.

Any insights into the nature of this problem would be very appreciated.


Arne Schirmacher

(I am not the developer of the ieee1394 driver, just a (currently unhappy) 
user of both ieee1394 and IDE driver)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
