Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132308AbQKXIlr>; Fri, 24 Nov 2000 03:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132333AbQKXIli>; Fri, 24 Nov 2000 03:41:38 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:63243 "EHLO
        rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
        id <S132308AbQKXIlY>; Fri, 24 Nov 2000 03:41:24 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Nov 2000 09:10:58 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.16: How to freeze the kernel
CC: linux-scsi@vger.kernel.org
Message-ID: <3A1E309C.26058.40EA98@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is for your interest, amusement, and for "what not to do":

I managed to freeze the kernel (2.2.16 from SuSE Linux 7.0) in a way 
that I could not even switch virtual consoles. Completely silent 
eberything...

It all started when Windows/95 ruined another CD-R while trying to 
write an image to the media. So I decided to try it with Linux, using 
the same CD writer.

I plugged the device to the so far unused SCSI channel and used the 
"add-sigle-device" method to avoid reboot, and I succeeded:

kgate kernel: scsi singledevice 0 0 4 0
kgate kernel:   Vendor: WAITEC    Model: WT624             Rev: 7.0F
kgate kernel:   Type:   CD-ROM                             ANSI SCSI 
revision: 0
kgate kernel: Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
kgate kernel: (scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
kgate kernel: sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda 
tray

Then I used "cdrecord-1.8.1" to simulate writing at "speed=8". It 
worked so far, but there was a warning about possible problems with 
"simulated fixation", and actually several minutes nothing happened 
while the simulated fixation was expected to take place.

At some point I hit ^C, returning to the prompt. As the device did not 
seem to be ready, I thought "remove the device and reconnect", so I did 
"remove-single-device" (possibly while a command was still "busy"). The 
remove suceeded, but a second later everything had stopped!

Should a device with busy commands be able to be removed? I guess no...

The last message in the syslog was:

kgate kernel: scsi : aborting command due to timeout : pid 8358,
 scsi0, channel 0, id 4, lun 0 UNKNOWN(0x5b) 00 02 00 00 00 00 00 00 00

At that point I pressed "RESET", and interestingly the builtin BIOS of 
the Adaptec 2740 (EISA) hung while trying to detect the device.

Only after powering down both, the CD writer and the machine (a HP 
Netserver LD Pro), the BIOS detected the device again. So I guess 
something badly hung...

The driver being used was
Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4

After that, everything worked fine.

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
