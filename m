Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267230AbSLEFjp>; Thu, 5 Dec 2002 00:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267231AbSLEFjp>; Thu, 5 Dec 2002 00:39:45 -0500
Received: from 12-237-135-160.client.attbi.com ([12.237.135.160]:5640 "EHLO
	skarpsey.dyndns.org") by vger.kernel.org with ESMTP
	id <S267230AbSLEFjo> convert rfc822-to-8bit; Thu, 5 Dec 2002 00:39:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Qlogic 1080 controller+Quantum Atlas 10K...
Date: Wed, 4 Dec 2002 23:41:37 -0600
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212042341.37998.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just spent half a day trying to coax this combo to work on 
kernel 2.4.18.  The kernel boots, the qla1280 driver probes the 
bus, it identifies the drive...and that's the last good word I 
get from it.  After that, it ends up repeatedly trying to reset 
the bus, then gives up and decides there are no devices 
attached.  Since the root FS is on the Quantum drive, this 
obviously causes the kernel to punt.

I'm not actually able to catch all the messages, obviously, but 
the general gist is something like this:

----------
  scsi0 channel 0 : resetting for second half of retries
  SCSI bus is being reset for host 0 channel 0
  scsi0 : device driver called scsi_done() for a synchronous 
      reset
      [note: this is bad driver behavior since what, 2.1?]
  SCSI disk error: host 0 channel 0 id 0 lun 0 return code = 
      27070002
      [this gets repeated many times.]
----------

The drive works on a different controller, so that's not the 
problem (but the other controller is horribly mismatched for the 
drive's performance class--it's an ncr53c810!!! :( )

The controller works with a different drive attached, so that's 
not the problem (but the other drive is too small to be useful).

I can take the drive, controller, and cable to an x86 box, get 
into FASTutil, and do a full sector check on the disk with no 
problem--so the hardware is apparently working fine.  I've tried 
jumpering the controller for manual termination, jumpering the 
drive to force single-ended operation, and various combinations, 
all to no effect.

(By the way, I flashed the controller to the latest BIOS/firmware 
while it was in the x86 box--it didn't help, but I figured it 
wouldn't hurt.)

So now it's down to the kernel...any ideas here?  At the very 
least, I'd like to know what return code "27070002" means...

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

