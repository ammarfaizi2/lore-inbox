Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVBHUp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVBHUp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVBHUp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:45:56 -0500
Received: from gprs215-154.eurotel.cz ([160.218.215.154]:45975 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261661AbVBHUpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:45:40 -0500
Date: Tue, 8 Feb 2005 21:45:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Video recovery after S3 on arima / eMachines notebook (and if S3 works for you, please tell me)
Message-ID: <20050208204504.GA1197@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I found out that vbetool is enough to get me back video after
suspend/resume. Good and thanks! Here's my current version of
video.txt file. If you have any comment, or have machine where S3
works and it is not listed below, please let me know and I'll update
video.txt file.

							Pavel


                Video issues with S3 resume
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  2003-2005, Pavel Machek

During S3 resume, hardware needs to be reinitialized. For most
devices, this is easy, and kernel driver knows how to do
it. Unfortunately there's one exception: video card. Those are usually
initialized by BIOS, and kernel does not have enough information to
boot video card. (Kernel usually does not even contain video card
driver -- vesafb and vgacon are widely used).

This is not problem for swsusp, because during swsusp resume, BIOS is
run normally so video card is normally initialized.

There are few types of systems where video works after S3 resume:

* systems where video state is preserved over S3. (Athlon HP Omnibook xe3s)

* systems where it is possible to call video bios during S3
  resume. Unfortunately, it is not correct to call video BIOS at that
  point, but it happens to work on some machines. Use
  acpi_sleep=s3_bios (Athlon64 desktop system, HP NC6000)

* systems that initialize video card into vga text mode and where BIOS
  works well enough to be able to set video mode. Use
  acpi_sleep=s3_mode on these. (Toshiba 4030cdt)

* on some systems s3_bios kicks video into text mode, and
  acpi_sleep=s3_bios,s3_mode is needed (Toshiba Satellite P10-554)

* radeon systems, where X can soft-boot your video card. You'll need
  patched X, and plain text console (no vesafb or radeonfb), see
  http://www.doesi.gmxhome.de/linux/tm800s3/s3.html. (Acer TM 800)

* other radeon systems, where vbetool is enough to bring system back
  to life. Do vbetool vbestate save > /tmp/delme; echo 3 > /proc/acpi/sleep;
  vbetool post; vbetool vbestate restore < /tmp/delme; setfont
  <whatever>, and your video should work. (Athlon64 Arima W730a, eMachines XYZ)

Now, if you pass acpi_sleep=something, and it does not work with your
bios, you'll get hard crash during resume. Be carefull. Also it is
safest to do your experiments with plain old VGA console. vesafb and
radeonfb (etc) drivers have tendency to crash the machine during resume.

You may have system where none of above works. At that point you
either invent another ugly hack that works, or write proper driver for
your video card (good luck getting docs :-(). Maybe suspending from X
(proper X, knowing your hardware, not XF68_FBcon) might have better
chance of working.


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
