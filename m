Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282890AbRLVWh6>; Sat, 22 Dec 2001 17:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282969AbRLVWht>; Sat, 22 Dec 2001 17:37:49 -0500
Received: from [216.196.223.237] ([216.196.223.237]:44490 "HELO sin.sloth.org")
	by vger.kernel.org with SMTP id <S282968AbRLVWhe>;
	Sat, 22 Dec 2001 17:37:34 -0500
Date: Sat, 22 Dec 2001 17:44:12 -0500
From: Geoffrey Gallaway <geoffeg@sin.sloth.org>
To: linux-kernel@vger.kernel.org
Subject: Using USB floppy drive for root floppy
Message-ID: <20011222174412.A19622@sin.sloth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a Sony Vaio laptop with an external USB floppy drive with which I
have been trying to install linux (slackware 8 specifically). I do not have
a cdrom drive, so that is not an easy option.

Originally, I just downloaded the standard boot and root floppies. I booted
and got the "Insert root floppy disk to be loaded into RAM disk and press
ENTER" message. Upon inserting the root disk and pressing ENTER I get a
message saying "Unable to mount root fs on 02:00". I believe the kernel is
looking for the root disk on what would be the floppy controler. I had
expected that the VAIO would have made the USB floppy drive emulate a
regular floppy drive on a regular controller. Apparently I was wrong.

To get around this problem I compiled my own kernel (2.4.12) with USB and
SCSI floppy support. Upon booting that kernel, linux recognizes the USB
floppy drive and apparently assigns it to sda. I then tried booting with
root=/dev/fd0 which caused the "Unable to mount root fs on 02:00" again. I
then tried root=/dev/sda which caused the kernel to panic with "Unable to
mount root fs on 08:00". I even tried adding "load_ramdisk=1" and
"prompt_ramdisk=1" to the kernel boot and it never asked for the floppy.
Anytime I specify root=/dev/sda the kernel would try to mount /dev/sda
before the USB floppy driver had been loaded. I took a hint from a previous
message thread regarding this problem[1] and added a sleep(10) before the
kernel tried to mount root. This didn't help at all or change the way the
system acted.

Any suggestions? My next idea is to try mounting root via NFS. My concern
with this idea is that my network adaptor is a PCMCIA card. If that doesn't
work I'm going to have to try to combine the root and boot floppies (ala
RedHat but for slackware in this case) so that the system never has to load
a seperate root floppy.

Thanks in advance,
Geoffeg

[1] http://www.uwsg.indiana.edu/hypermail/linux/kernel/0108.1/0735.html
