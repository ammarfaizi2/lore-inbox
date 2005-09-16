Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbVIPXD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVIPXD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVIPXD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:03:57 -0400
Received: from iotaanl.aps.anl.gov ([164.54.56.3]:53458 "EHLO zeta.aps.anl.gov")
	by vger.kernel.org with ESMTP id S1750760AbVIPXD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:03:56 -0400
Message-ID: <432B4F56.6070404@aps.anl.gov>
Date: Fri, 16 Sep 2005 18:03:50 -0500
From: Shifu Xu <xusf@aps.anl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050719 Red Hat/1.7.10-1.1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: patch-2.6.13-rt12 problem on Powerpc board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried the patch-2.6.13-rt12 on mvme2100 board, I made the following 
changes to get it pass compiling:
(no CONFIG_HIGH_RES_TIMER)

1) mv include/asm-ppc/hrtime.h include/asm-ppc/hrtimer.h
2) in arch/ppc/syslib/todc_time.c,  add :
     unsigned long cpu_khz;
3)in  include/linux/time.h, add :
+#ifndef div_long_long_rem
+#define div_long_long_rem(dividend,divisor,remainder) \
+({                                                      \
+        u64 result = dividend;                          \
+        *remainder = do_div(result,divisor);            \
+        result;                                         \
+})
+#endif
+

When booting, it stoped after displaying:
...
openpic :enter

I remove two printk statement after the output "openpic :enter" in 
arch/ppc/syslib/open_pic.c.
and then boot and display the following:
....
....
Linux version 2.6.13-rt12 () (gcc version 3.4.2) #2 Thu Sep 15 16:34:48 
CDT 2005
Platform: Motorola MVME2100
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: console=ttyS0,9600 ip=dhcp
WARNING: experimental RCU implementation.
PID hash table entries: 256 (order: 8, 4096 bytes)
Registered KTimer base Monotonic
Registered KTimer base Realtime
time_init: decrementer frequency = 16.666734 MHz
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 30316k available (1412k kernel code, 392k data, 328k init, 0k 
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
                                                                                                                  

PCI: Probing PCI hardware
lpptest: irq 7 in use. Unload parport module!
Generic RTC Driver v1.07
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at MMIO 0x0 (irq = 29) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Linux Tulip driver version 1.1.13 (May 11, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
tulip0:  MII transceiver #8 config 1000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at febfef80, 00:01:AF:09:0D:EA, IRQ 17.
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 2048 (order: 4, 81920 bytes)
TCP bind hash table entries: 2048 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Sending DHCP requests .<6>eth0: Setting half-duplex based on MII#8 link 
partner capability of 0021.
..... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests .<6>eth0: Setting half-duplex based on MII#8 link 
partner capability of 0021.
..... timed out!
IP-Config: Retrying forever (NFS root)...
Sending DHCP requests .<6>eth0: Setting half-duplex based on MII#8 link 
partner capability of 0021.
...

What else have to be changed to make it booting? By the way, Linux2.6.13 
can boot when not applying the
patch-2.6.13-rt12.

please cc any answer/comments to my email.
thanks in advance for any help.

Shifu


