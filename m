Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVAZPNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVAZPNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVAZPNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:13:16 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:38071 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262325AbVAZPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:12:32 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: MPT fusion still unable to recover properly under 2.6, ok under 2.4
Date: Wed, 26 Jan 2005 14:47:02 GMT
Message-ID: <051BFQE12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell PowerEdge 2600 than run smoothly on Linux 2.6 for 6 monthes,
then three days ago, it started to have tiny problems on the SCSI.
Now the bug is that 2.6.9 is unable to recover from these tiny problems
(it enters an infinit loop that locks all processes attempting to access disk)
whereas 2.4.29 recovers nicely.

I noticed exactly the same several monthes ago with older 2.6 and 2.4 kernels.


Here is the kind of kernel messages in 2.4:

<4>scsi : aborting command due to timeout : pid 1035770, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 42 d7 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b0c00)
<4>scsi : aborting command due to timeout : pid 1035771, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 44 17 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b0e00)
<4>scsi : aborting command due to timeout : pid 1035772, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 45 57 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1000)
<4>scsi : aborting command due to timeout : pid 1035773, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 46 97 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1200)
<4>scsi : aborting command due to timeout : pid 1035774, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 47 d7 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1400)
<4>scsi : aborting command due to timeout : pid 1035775, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 49 17 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1600)
<4>scsi : aborting command due to timeout : pid 1035776, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 4a 57 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1800)
<4>scsi : aborting command due to timeout : pid 1035777, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 4b 97 00 01 48 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1a00)
<4>scsi : aborting command due to timeout : pid 1035778, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 4c df 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1c00)
<4>scsi : aborting command due to timeout : pid 1035779, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 4e 1f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b1e00)
<4>scsi : aborting command due to timeout : pid 1035780, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 4f 5f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2000)
<4>scsi : aborting command due to timeout : pid 1035781, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 50 9f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2200)
<4>scsi : aborting command due to timeout : pid 1035782, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 51 df 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2400)
<4>scsi : aborting command due to timeout : pid 1035783, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 53 1f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2600)
<4>scsi : aborting command due to timeout : pid 1035784, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 54 5f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2800)
<4>scsi : aborting command due to timeout : pid 1035785, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 55 9f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2a00)
<4>scsi : aborting command due to timeout : pid 1035786, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 56 df 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2c00)
<4>scsi : aborting command due to timeout : pid 1035787, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 58 1f 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79b2e00)
<4>scsi : aborting command due to timeout : pid 1035788, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 59 5f 00 01 48 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bb000)
<4>scsi : aborting command due to timeout : pid 1035789, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 5a a7 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bb200)
<4>scsi : aborting command due to timeout : pid 1035790, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 5b e7 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bb400)
<4>scsi : aborting command due to timeout : pid 1035791, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 5d 27 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bb600)
<4>scsi : aborting command due to timeout : pid 1035792, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 5e 67 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bb800)
<4>scsi : aborting command due to timeout : pid 1035793, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 5f a7 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bba00)
<4>scsi : aborting command due to timeout : pid 1035794, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 60 e7 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bbc00)
<4>scsi : aborting command due to timeout : pid 1035795, scsi0, channel 0, id 0, lun 0 0x2a 00 10 09 62 27 00 01 40 00 
<4>mptscsih: OldAbort scheduling ABORT SCSI IO (sc=f79bbe00)
<4>SCSI host 0 abort (pid 1035770) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b0c00)
<4>SCSI host 0 abort (pid 1035771) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b0e00)
<4>SCSI host 0 abort (pid 1035772) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1000)
<4>SCSI host 0 abort (pid 1035773) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1200)
<4>SCSI host 0 abort (pid 1035774) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1400)
<4>SCSI host 0 abort (pid 1035775) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1600)
<4>SCSI host 0 abort (pid 1035776) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1800)
<4>SCSI host 0 abort (pid 1035777) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1a00)
<4>SCSI host 0 abort (pid 1035778) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1c00)
<4>SCSI host 0 abort (pid 1035779) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1e00)
<4>SCSI host 0 abort (pid 1035780) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2000)
<4>SCSI host 0 abort (pid 1035781) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2200)
<4>SCSI host 0 abort (pid 1035782) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2400)
<4>SCSI host 0 abort (pid 1035783) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2600)
<4>SCSI host 0 abort (pid 1035784) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2800)
<4>SCSI host 0 abort (pid 1035785) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2a00)
<4>SCSI host 0 abort (pid 1035786) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2c00)
<4>SCSI host 0 abort (pid 1035787) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2e00)
<4>SCSI host 0 abort (pid 1035788) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb000)
<4>SCSI host 0 abort (pid 1035789) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb200)
<4>SCSI host 0 abort (pid 1035790) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb400)
<4>SCSI host 0 abort (pid 1035791) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb600)
<4>SCSI host 0 abort (pid 1035792) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb800)
<4>SCSI host 0 abort (pid 1035793) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bba00)
<4>SCSI host 0 abort (pid 1035794) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bbc00)
<4>SCSI host 0 abort (pid 1035795) timed out - resetting
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bbe00)
<4>SCSI host 0 channel 0 reset (pid 1035770) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b0c00)
<4>SCSI host 0 channel 0 reset (pid 1035771) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b0e00)
<4>SCSI host 0 channel 0 reset (pid 1035772) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1000)
<4>SCSI host 0 channel 0 reset (pid 1035773) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1200)
<4>SCSI host 0 channel 0 reset (pid 1035774) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1400)
<4>SCSI host 0 channel 0 reset (pid 1035775) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1600)
<4>SCSI host 0 channel 0 reset (pid 1035776) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1800)
<4>SCSI host 0 channel 0 reset (pid 1035777) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1a00)
<4>SCSI host 0 channel 0 reset (pid 1035778) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1c00)
<4>SCSI host 0 channel 0 reset (pid 1035779) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b1e00)
<4>SCSI host 0 channel 0 reset (pid 1035780) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2000)
<4>SCSI host 0 channel 0 reset (pid 1035781) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2200)
<4>SCSI host 0 channel 0 reset (pid 1035782) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2400)
<4>SCSI host 0 channel 0 reset (pid 1035783) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2600)
<4>SCSI host 0 channel 0 reset (pid 1035784) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2800)
<4>SCSI host 0 channel 0 reset (pid 1035785) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2a00)
<4>SCSI host 0 channel 0 reset (pid 1035786) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2c00)
<4>SCSI host 0 channel 0 reset (pid 1035787) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79b2e00)
<4>SCSI host 0 channel 0 reset (pid 1035788) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb000)
<4>SCSI host 0 channel 0 reset (pid 1035789) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb200)
<4>SCSI host 0 channel 0 reset (pid 1035790) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb400)
<4>SCSI host 0 channel 0 reset (pid 1035791) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb600)
<4>SCSI host 0 channel 0 reset (pid 1035792) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bb800)
<4>SCSI host 0 channel 0 reset (pid 1035793) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bba00)
<4>SCSI host 0 channel 0 reset (pid 1035794) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bbc00)
<4>SCSI host 0 channel 0 reset (pid 1035795) timed out - trying harder
<4>SCSI bus is being reset for host 0 channel 0.
<4>mptscsih: OldReset scheduling BUS_RESET (sc=f79bbe00)
<4>SCSI host 0 reset (pid 1035770) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035771) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035772) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035773) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035774) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035775) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035776) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035777) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035778) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035779) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035780) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035781) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035782) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035783) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035784) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035785) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035786) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035787) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035788) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035789) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035790) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035791) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035792) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035793) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035794) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI host 0 reset (pid 1035795) timed out again -
<4>probably an unrecoverable SCSI bus or device hang.
<4>SCSI Error: (0:1:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 2A 00 10 09 5E 6F 00 01 40 00
<4>
<4>SCSI Error: (0:0:0) Status=02h (CHECK CONDITION)
<4> Key=6h (UNIT ATTENTION); FRU=00h
<4> ASC/ASCQ=29h/02h "SCSI BUS RESET OCCURRED"
<4> CDB: 28 00 0D B5 00 47 00 00 08 00
<4>

And now the same with 2.6.9:

<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ece00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ece00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ecc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ecc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ecb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ecb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec680)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec500)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec200)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=de3ec080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72ce00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72ce00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72cc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72cc80)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72cb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72cb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c980)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c680)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c500)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c380)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=ee72c080)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340de00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340de00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340dc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340dc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340db00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340db00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d980)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d800)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d680)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f340d080)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7be00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7be00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7bc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7bc80)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7bb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7bb00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b980)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b380)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b200)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f7b080)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79e00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79e00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79c80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79c80)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79b00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79b00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79380)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79200)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=e6f79080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690e00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690e00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690c80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690c80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690b00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690b00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690680)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690500)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690080)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=dc519e00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=dc519e00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=dc519c80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=dc519c80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=d8690200)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=dc519b00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=dc519b00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting target reset! (sc=de3ece00)
<4>mptscsih: ioc0: >> Attempting target reset! (sc=de3ec800)
<4>mptscsih: ioc0: >> Attempting bus reset! (sc=de3ece00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated

