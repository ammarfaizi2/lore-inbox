Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTIYJSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 05:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTIYJSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 05:18:25 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:5816 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261775AbTIYJSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 05:18:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16242.45779.564566.330169@gargle.gargle.HOWL>
Date: Thu, 25 Sep 2003 11:18:11 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Tarkan Erimer <TARKANE@solmaz.com.tr>
Cc: "lkml (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Hard lock up exiting X on linux-2.6.0-test5/test5-mm4
In-Reply-To: <EA16D384EF89C942B5948FEB8E5D2FF3061C59@mailserver>
References: <EA16D384EF89C942B5948FEB8E5D2FF3061C59@mailserver>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tarkan Erimer writes:
 > I compile and run linux-2.6.0-test5-mm4. It works wonderful, but when I
 > switch to X windows it's OK. But, when I tried to exit X, it completely
 > freezes the box. I tried this with open source nvidia (nv) driver and
 > proprietary nvidia (nvidia)driver. Results are always same. My hardware is:
 > P-II 350, 384 RAM, BX board and Riva TNT gfx card. The same thing also
 > happened with vanilla linux-2.6.0-test5. I attached my .config and
 > version_linux outputs. Any idea ?

CONFIG_X86_UP_APIC=y
...
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=y

You may suffer from a broken graphics card BIOS that hangs
if a local APIC timer interrupt arrives. I've seen this
happen on G400 and Radeons, and an old S3 I think.

Another issue, but not the one you're having, is that
configuring APM=m is known to hang some BIOSen at the
point when the APM module is unloaded, again due to
BIOS code not handling local APIC interrupts.

Fix: Disable CONFIG_APM_DISPLAY_BLANK. You don't need it.
Also set APM=y if you're going to have it at all.

(An alternative fix is to disable UP_APIC, but
only do that as a last resort.)

I also noticed you had enabled a lot of ACPI stuff.
This is almost certainly pointless on a BX board.

/Mikael
