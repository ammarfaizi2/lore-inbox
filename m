Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVALQIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVALQIO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 11:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVALQIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 11:08:14 -0500
Received: from cgk88.neoplus.adsl.tpnet.pl ([83.30.238.88]:36738 "EHLO
	wenus.kolkowski.no-ip.org") by vger.kernel.org with ESMTP
	id S261243AbVALQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 11:07:48 -0500
Date: Wed, 12 Jan 2005 17:07:49 +0100
From: Damian Kolkowski <damian@kolkowski.no-ip.org>
To: linux-kernel@vger.kernel.org
Cc: acpi-bugzilla@lists.sourceforge.net
Subject: [TEMPERATURE] - AMD Sempron, no CPU temperature (throttling control = no).
Message-ID: <20050112160749.GENTOO-LINUX-ROX.C9707@kolkowski.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GPG-Key: 0xB2C5DE03 (http://kolkowski.no-ip.org/damian.asc x-hkp://wwwkeys.eu.pgp.net)
X-Girl: 1 will be enough!
X-Age: 24 (1980.09.27 - libra)
X-IM: JID:deimos@chrome.pl ICQ:59367544 GG:88988
X-Operating-System: Gentoo Linux, kernel 2.6.10-gentoo-r4, up 24 min
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a new MSI FSR Delta (VIA_KT880) and AMD Sempron 2600+, and now after
loading _processor_ module I do not have CPU temperature in /proc/,
and _thermal_ module is not working.

Question:
1. Is this an ACPI fault that my CPU is not compatible with kernel?

Result from /proc/:
./proc/acpi/processor/CPU1. # v   
razem 0
dr-xr-xr-x  2 root root 0 sty 11 21:54 .
dr-xr-xr-x  3 root root 0 sty 11 21:54 ..
-r--r--r--  1 root root 0 sty 11 21:54 info
-rw-r--r--  1 root root 0 sty 11 21:54 limit
-r--r--r--  1 root root 0 sty 11 21:54 power
-rw-r--r--  1 root root 0 sty 11 21:54 throttling
./proc/acpi/processor/CPU1. # cat *
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no
<not supported>
active state:            C1
default state:           C1
max_cstate:              C3
bus master activity:     00000000
states:
   *C1:                  promotion[--] demotion[--] latency[000] usage[00000000]
    C2:                  <not supported>
    C3:                  <not supported>
<not supported>
./proc/acpi/processor/CPU1. # uname -a
Linux uran 2.6.10-gentoo-r3 #2 Sat Jan 8 20:12:30 CET 2005 i686 AMD Sempron(tm) 2600+ AuthenticAMD GNU/Linux
./proc/acpi/processor/CPU1. # lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0269
0000:00:00.1 Host bridge: VIA Technologies, Inc.: Unknown device 1269
0000:00:00.2 Host bridge: VIA Technologies, Inc.: Unknown device 2269
0000:00:00.3 Host bridge: VIA Technologies, Inc.: Unknown device 3269
0000:00:00.4 Host bridge: VIA Technologies, Inc.: Unknown device 4269
0000:00:00.7 Host bridge: VIA Technologies, Inc.: Unknown device 7269
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:0b.0 Ethernet controller: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 11)
0000:00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV250 If [Radeon 9000] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc Radeon RV250 [Radeon 9000] (Secondary) (rev 01)
./proc/acpi/processor/CPU1. # 

Now I have "throttling control" with issue "no", so ACPI is an author of that
mistake?

Take care.


P.S. I am using setpci to cool my CPU. Like this:
.~. $ cat /etc/conf.d/local.start | grep -v ^# | grep setpci
setpci -H1 -s 0:0.0 82=$(printf %x $((0x$(setpci -H1 -s 0:0.0 82) | 0x80)))
setpci -H1 -s 0:0.0 85=$(printf %x $((0x$(setpci -H1 -s 0:0.0 85) | 0x02)))
.~. $ 

PP.S. thermal:
./proc/acpi/thermal_zone. $ v
razem 0
dr-xr-xr-x  2 root root 0 sty 12 17:05 .
dr-xr-xr-x  4 root root 0 sty 12 15:57 ..
./proc/acpi/thermal_zone. $

-- 
### Damian Ko³kowski (dEiMoS) ## http://kolkowski.no-ip.org/ ###
# echo teb.cv-ba.vxfjbxybx.anvznq | rot13 | rev | sed s/\\./@/ #
