Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbTIYJZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 05:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTIYJZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 05:25:58 -0400
Received: from eu40.st74-net74.ip.superonlinecorporate.com ([213.74.74.40]:19720
	"HELO viruswall.solmaz.com.tr") by vger.kernel.org with SMTP
	id S261600AbTIYJZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 05:25:57 -0400
Message-ID: <EA16D384EF89C942B5948FEB8E5D2FF3061C5A@mailserver>
From: Tarkan Erimer <TARKANE@solmaz.com.tr>
To: "'Mikael Pettersson'" <mikpe@csd.uu.se>
Cc: "lkml (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] Hard lock up exiting X on linux-2.6.0-test5/test5-mm4
Date: Thu, 25 Sep 2003 12:26:19 +0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply, Mikael. I will try that, when I back to the home. 

Tarkan Erimer

-----Original Message-----
From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
Sent: 25 Eylül 2003 Perþembe 12:18
To: Tarkan Erimer
Cc: lkml (linux-kernel@vger.kernel.org)
Subject: Re: [BUG] Hard lock up exiting X on linux-2.6.0-test5/test5-mm4


Tarkan Erimer writes:
 > I compile and run linux-2.6.0-test5-mm4. It works wonderful, but when I
> switch to X windows it's OK. But, when I tried to exit X, it completely  >
freezes the box. I tried this with open source nvidia (nv) driver and  >
proprietary nvidia (nvidia)driver. Results are always same. My hardware is:
> P-II 350, 384 RAM, BX board and Riva TNT gfx card. The same thing also  >
happened with vanilla linux-2.6.0-test5. I attached my .config and  >
version_linux outputs. Any idea ?

CONFIG_X86_UP_APIC=y
...
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set CONFIG_APM_DO_ENABLE=y #
CONFIG_APM_CPU_IDLE is not set CONFIG_APM_DISPLAY_BLANK=y

You may suffer from a broken graphics card BIOS that hangs
if a local APIC timer interrupt arrives. I've seen this
happen on G400 and Radeons, and an old S3 I think.

Another issue, but not the one you're having, is that configuring APM=m is
known to hang some BIOSen at the point when the APM module is unloaded,
again due to BIOS code not handling local APIC interrupts.

Fix: Disable CONFIG_APM_DISPLAY_BLANK. You don't need it.
Also set APM=y if you're going to have it at all.

(An alternative fix is to disable UP_APIC, but
only do that as a last resort.)

I also noticed you had enabled a lot of ACPI stuff.
This is almost certainly pointless on a BX board.

/Mikael
