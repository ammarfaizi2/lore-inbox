Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRKNSFJ>; Wed, 14 Nov 2001 13:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276665AbRKNSE7>; Wed, 14 Nov 2001 13:04:59 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:13694 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S273854AbRKNSEs>; Wed, 14 Nov 2001 13:04:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: TreeWater Society Berlin
To: sensors@stimpy.netroedge.com
Subject: [lm_sensors] hard lockup on modprobe w83781d with Tyan Dual K7/Thunder
Date: Wed, 14 Nov 2001 19:04:40 +0100
X-Mailer: KMail [version 1.3]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011114180440.A8934A99@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to get serveral lm_sensor versions up to CVS lm_sensors2 from 
yesterday to run on this mb. Now, I'm at linux-2.4.15-pre4, but also tried
some 2.4.12(-ac?) versions, to no avail.

sensors-detect says:
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:07.3: AMD-766 Athlon ACPI
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-amd756' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus AMD7X6 adapter at 80e0 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x08
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Success!
    (confidence 8, driver `w83781d'), other addresses: 0x48 0x49

[eeprom stuff removed]

Probed modules:
# I2C adapter drivers
modprobe i2c-amd756
# I2C chip drivers
modprobe w83781d           <---- FREEZE

kernel log during sensors-detect:
Nov 14 17:28:33 tyrex kernel: i2c-core.o: i2c core module
Nov 14 17:28:33 tyrex kernel: i2c-amd756.o version 2.6.1 (20010830)
Nov 14 17:28:33 tyrex kernel: i2c-core.o: adapter SMBus AMD7X6 adapter at 
80e0 registered 
as adapter 0.
Nov 14 17:28:33 tyrex kernel: i2c-amd756.o: AMD756/766 bus detected and 
initialized
Nov 14 17:28:38 tyrex kernel: i2c-dev.o: i2c /dev entries driver module
Nov 14 17:28:38 tyrex kernel: i2c-core.o: driver i2c-dev dummy driver 
registered.
Nov 14 17:28:38 tyrex kernel: i2c-dev.o: Registered 'SMBus AMD7X6 adapter at 
80e0' as minor 0
Nov 14 17:28:49 tyrex kernel: i2c-amd756.o: SMBus collision!
Nov 14 17:28:49 tyrex last message repeated 3 times

Any suggestions?

Hans-Peter
