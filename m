Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbUEOJK4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUEOJK4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 05:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUEOJKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 05:10:55 -0400
Received: from lucidpixels.com ([66.45.37.187]:8329 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261416AbUEOJKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 05:10:44 -0400
Date: Sat, 15 May 2004 05:10:42 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.6 CPU Issue - Uses 50-55% of CPU when doing nothing.
Message-ID: <Pine.LNX.4.58.0405150504310.14958@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Top reports my CPU is 52% in use but top does not show any process using up
a lot of CPU, and the temperature confirms it is running at 50%.

top - 05:10:09 up  1:08, 41 users,  load average: 1.03, 1.15, 1.63
Tasks: 240 total,   3 running, 236 sleeping,   0 stopped,   1 zombie
 Cpu0 : 61.1% us, 10.5% sy,  0.1% ni, 21.7% id,  1.4% wa,  0.3% hi,  4.8%
si
 Cpu1 : 59.4% us, 11.1% sy,  0.1% ni, 27.4% id,  2.1% wa,  0.0% hi,  0.0%
si
Mem:   2076188k total,  1260044k used,   816144k free,    36720k buffers
Swap:  4194272k total,        0k used,  4194272k free,   744056k cached

This only began happening when I compiled the kernel w/SMP support for my
P4 w/HT to take advantage of HT.

Does anyone know what to do in this case?

I was trying out a few apps xrn (python news reader before it started
doing this), I noticed it was having a lot of issues so I control-c'd it
and then the kernel is in some kind of CPU-hogging loop, anyhow, if I do
not get an e-mail back soon I will probably reboot, constantly 50% cpu
sucks, is there anything I can do to find out what the kernel is doing and
report back?

Is it a regular occurrence with Linux+SMP?  If so is there any way to fix
it?


top - 05:06:33 up  1:05, 40 users,  load average: 1.34, 1.31, 1.81
Tasks: 239 total,   2 running, 236 sleeping,   0 stopped,   1 zombie
 Cpu0 : 46.9% us,  8.3% sy,  0.0% ni, 41.3% id,  0.0% wa,  0.3% hi,  3.3%
si
 Cpu1 : 44.4% us,  7.9% sy,  0.0% ni, 47.7% id,  0.0% wa,  0.0% hi,  0.0%
si
Mem:   2076188k total,  1252868k used,   823320k free,    36684k buffers
Swap:  4194272k total,        0k used,  4194272k free,   738312k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
   93 root      15   0  364m 104m 273m S  7.0  5.2   5:39.86 X
20245 war       16   0 15108 8632  12m S  2.0  0.4   0:07.75 gkrellm
   73 root      16   0  1428  592 1384 S  0.7  0.0   0:15.39 inetd
  327 war       16   0  7688 3632 6260 S  0.7  0.2   0:07.91 sawfish
  616 war       15   0 11836 5720  10m S  0.7  0.3   0:04.77 panel
 1060 war       15   0 10712 4640 9904 S  0.7  0.2   0:05.27
deskguide_apple
16028 war       16   0  2032 1132 1784 R  0.7  0.1   0:03.47 top
27095 war       17   0  2032 1132 1784 S  0.7  0.1   0:00.75 top
30169 root      18   0  5680 2924 4580 R  0.7  0.1   0:00.02 nmbd
  765 root      15   0  7356 3748 5648 S  0.3  0.2   0:01.18 xterm
  923 root      16   0 10300 2480 5648 S  0.3  0.1   0:00.13 xterm
 2304 war       15   0 22196  12m  15m S  0.3  0.6   0:05.09 xchato
 2690 root      16   0  7336 2436 5648 S  0.3  0.1   0:00.10 xterm
 2830 war       15   0 21792  12m  15m S  0.3  0.6   0:04.94 xchats
    1 root      16   0   488  240  464 S  0.0  0.0   0:06.72 init
    2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0


war@war:~$ sensors
eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0500
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.50 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +2.50 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +3.20 V  (min =  +2.82 V, max =  +3.79 V)
+5V:       +4.92 V  (min =  +0.00 V, max =  +0.00 V)
+12V:     +11.86 V  (min =  +0.00 V, max =  +0.00 V)
-12V:      -8.50 V  (min = -14.91 V, max = -14.91 V)
-5V:       -2.89 V  (min =  -7.26 V, max =  -7.71 V)
V5SB:      +5.56 V  (min =  +0.00 V, max =  +0.00 V)
VBat:      +3.33 V  (min =  +0.06 V, max =  +0.00 V)
fan1:     3013 RPM  (min =  166 RPM, div = 32)
fan2:     5273 RPM  (min =  166 RPM, div = 32)
fan3:     1622 RPM  (min =  332 RPM, div = 16)
temp1:       +34C  (high =    +0C, hyst =    +2C)   sensor = thermistor
temp2:     +61.5C  (high =   +85C, hyst =   +80C)   sensor = PII/Celeron
diode
temp3:     +50.0C  (high =   +85C, hyst =   +80C)   sensor = thermistor
vid:      +0.000 V
alarms:
beep_enable:
          Sound alarm disabled



