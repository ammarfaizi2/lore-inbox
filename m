Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289277AbSAIJEb>; Wed, 9 Jan 2002 04:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289278AbSAIJEW>; Wed, 9 Jan 2002 04:04:22 -0500
Received: from p5082CDEC.dip.t-dialin.net ([80.130.205.236]:9975 "EHLO
	twinspark.cobolt.net") by vger.kernel.org with ESMTP
	id <S289277AbSAIJEK>; Wed, 9 Jan 2002 04:04:10 -0500
Date: Wed, 9 Jan 2002 10:08:55 +0100
From: Dennis Schoen <dennis@cobolt.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG]: RT8139 Too much work at interrupt, IntrStatus=....
Message-ID: <20020109090855.GA338@cobolt.net>
Reply-To: Dennis Schoen <dennis@cobolt.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

yesterday I upgraded a firewall/router of a *busy* customer site
from version 2.4.7 -> 2.4.17. Only 1-2 seconds after the reboot the
network card to the DMZ stopped working. I noticed this messages in
/var/log/messages:

Jan  8 17:07:45 liquice kernel: 8139too: rx stop wait too long
Jan  8 17:07:46 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0050.
Jan  8 17:07:46 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0010.
Jan  8 17:07:49 liquice kernel: 8139too: rx stop wait too long
Jan  8 17:07:49 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0001.
Jan  8 17:07:51 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0001.
Jan  8 17:07:57 liquice kernel: eth1: Too much work at interrupt, IntrStatus=0x0050.
Jan  8 17:07:57 liquice kernel: eth1: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
Jan  8 17:08:09 liquice kernel: NETDEV WATCHDOG: eth1: transmit timed out
Jan  8 17:08:09 liquice kernel: eth1: Setting 100mbps half-duplex based on auto-negotiated partner ability ffff.

after a reboot the same problem occured.

Switching back to v2.4.7 solved the problem so I don't think that
it's a hardware issue.

So has anybody an idea whats happening here? Hardware info below. Let me know if you need any additional info.

Thanks
    Dennis


liquice:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 65)

liquice:~# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1210.814
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2411.72
