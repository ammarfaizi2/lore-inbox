Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUAHCA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUAHCA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:00:58 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:35534 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S263486AbUAHCAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:00:53 -0500
Subject: i2c_adapter i2c-0: Bus collision!
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org
Cc: sensors@stimpy.netroedge.com
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1073527236.624.7.camel@buick>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 03:00:36 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get plenty of this in my logs:

i2c_adapter i2c-0: Bus collision! SMBus may be locked until next hard
reset. (sorry!)

Kernel 2.6.0 with lm-sensors 2.8.2.

I get very weird results, especially on the fan, but others as well.
Here are three runs of sensors:


buick:~# sensors
w83627hf-i2c-0-2d
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
VCore 1:   +1.79 V  (min =  +1.66 V, max =  +0.72 V)
VCore 2:   +1.50 V  (min =  +1.66 V, max =  +0.72 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.95 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)
CPU0:     12980 RPM  (min = 3750 RPM, div = 8)
CPU1:        0 RPM  (min =  750 RPM, div = 8)
CPU0:      +29.0°C  (high =   +60°C, hyst =   +50°C)   sensor =
PII/Celeron diode
CPU1:      +29.5°C  (high =   +50°C, hyst =   +50°C)   sensor =
PII/Celeron diode
vid:      +0.000 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled


buick:~# sensors
w83627hf-i2c-0-2d
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
VCore 1:   +1.81 V  (min =  +1.66 V, max =  +0.72 V)
VCore 2:   +4.08 V  (min =  +1.66 V, max =  +4.08 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +4.95 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.55 V  (min = +10.82 V, max = +13.19 V)
CPU0:     450000 RPM  (min = 30000 RPM, div = 1)
CPU1:        0 RPM  (min = 6000 RPM, div = 1)
CPU0:      +29.0°C  (high =   +60°C, hyst =   +50°C)   sensor =
PII/Celeron diode
CPU1:      +29.5°C  (high =   +50°C, hyst =   +50°C)   sensor =
PII/Celeron diode
vid:      +3.300 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled


buick:~# sensors
w83627hf-i2c-0-2d
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Unavailable from sysfs
VCore 1:   +1.79 V  (min =  +3.14 V, max =  +3.46 V)
VCore 2:   +1.50 V  (min =  +3.14 V, max =  +3.46 V)
+3.3V:     +3.34 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.03 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.49 V  (min = +10.82 V, max = +15.50 V)
CPU0:     337500 RPM  (min = 7500 RPM, div = 4)
CPU1:     3125 RPM  (min = 1500 RPM, div = 4)
CPU0:      +29.0°C  (high =   +60°C, hyst =   +50°C)   sensor =
PII/Celeron diode
CPU1:      +29.0°C  (high =   +50°C, hyst =   +50°C)   sensor =
PII/Celeron diode
vid:      +3.300 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled


It works fine with MBM in Windows. Well, MBM is having some troubles
with the temperature (it gets lower and lower as time pass, and ends on
about 8-9 degrees celsius. But fan and temperatures are read just fine,
never any glitch. On thing thing though, the Vcore2 is 1,70. The Bios
reports it correctly, but both MBM and LM-sensors says 1,50. Have no
idea why. The 1,50 is static, never changes, while VCore1 (which ideally
should be 1,75) varies from 1,75 to 1,79. In the BIOS both seem sane,
and varies with 3-4 degrees.

I guess all these problems are because of the bus collision, which I
have read usually happens because of bad boards. Which I admit that I do
have, but it works in Windows :(

What are the most common reasons for the bus collisions, and is there
anything to do?

Best regards,
Stian

