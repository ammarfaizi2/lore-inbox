Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279329AbRJWJQa>; Tue, 23 Oct 2001 05:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279330AbRJWJQU>; Tue, 23 Oct 2001 05:16:20 -0400
Received: from four.malevolentminds.com ([216.177.76.238]:14090 "EHLO
	four.malevolentminds.com") by vger.kernel.org with ESMTP
	id <S279329AbRJWJQM>; Tue, 23 Oct 2001 05:16:12 -0400
Date: Tue, 23 Oct 2001 09:16:49 +0000 (GMT)
From: Khyron <khyron@khyron.com>
X-X-Sender: <khyron@four.malevolentminds.com>
To: <linux-kernel@vger.kernel.org>
Subject: AIC-7xxx and 2.4.8 (or which release *should* I use)?
Message-ID: <Pine.BSF.4.33.0110230610580.31719-100000@four.malevolentminds.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to build a 2.4.8 kernel for use on a VA Linux
2230 system. The system, running the stock VA kernel, reports
itself as containing an "<Adaptec AIC-7896/7 Ultra2 SCSI host
adapter>".

I have been patching 2.4.8 with Justin Gibbs' patches from
http://people.freebsd.org/~gibbs/linux/, specifically the
6.2.4 patch for 2.4.8.

Now, I have yet to encounter a situation where using this
kernel (with everything compiled in - I'm kickstarting the
VA box with this kernel) _fails_ to generate the following
errors (in no particular order):

aic7xxx_abort returns 0x2002
aic7xxx_dev_reset returns 0x2002
scsi: device set offline - not ready or command retry failed
after bus reset host 1 channel 0 id 0 lun 0

>From looking thru the messages file on a second 2230 (they
were a pair), I see this:

(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 395 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 395 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.27/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.27/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi : 2 hosts.

Which leads me to believe that there are 2 busses served by
this adapter. Correct, incorrect or otherwise?

There are 4 Seagate ST318404LW disks on the bus. The Adaptec
BIOS reads as a 7896 version 2.20S1B1.

I compiled a 2.4.8 kernel w/o the 6.2.4 driver and now I get
these errors:

aic7xxx_abort returns 8194
aic7xxx_dev_reset returns 8194
scsi: device set offline - not ready or command retry failed
after bus reset host 0 channel 0 id 0 lun 0

Apparently, its probing the bus incessantly since the target ID
keeps incrementing thru 15 then starts at 0 again. This behavior
has happened with both the 2.4.8+6.2.4 and stock 2.4.8 before
oopsing out. I can collect the oops data but I haven't as yet.

I have tried adjusting the TCQ per device to 128 and 64 (on
2.4.8+6.2.4) and to 128 and 8 on the stock 2.4.8 build.

So my ultimate question is is this kernel rev (2.4.8), with or
w/o the 6.2.4 driver, appropriate? Should I be looking at 2.4.12
or even an -ac release? What steps should I be taking in this
regard? Is there any other useful information I should provide
for this to make sense? What do these errors indicate?

Any and all advice accepted. This is killing me!

I receive the LKML digests from Dell but not individual submissions.
Direct replied are fine.

TIA!


"Everyone's got a story to tell, and everyone's got some pain.
 And so do you. Do you think you are invisble?
 And everyone's got a story to sell, and everyone is strange.
 And so are you. Did you think you were invincible?"
 	- "Invisible", Majik Alex





