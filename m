Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUEPSFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUEPSFT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264716AbUEPSFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:05:19 -0400
Received: from lac-1-82-66-8-145.fbx.proxad.net ([82.66.8.145]:32130 "EHLO
	vignemale.local.eukrea.com") by vger.kernel.org with ESMTP
	id S264704AbUEPSE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:04:59 -0400
From: Eric BENARD / Free <ebenard@free.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6.6 : bad PCI device ID for SiS ISA bridge => SiS900 eth0: Can not find ISA bridge
Date: Sun, 16 May 2004 20:04:56 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405162004.57041.ebenard@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1- bad PCI device ID for SiS ISA bridge

2- In 2.6.3-rc2 (and 2.4.x), the PCI device ID of the ISA bridge of the 
SiS630e is 0x0008. This ID is used by sis900.c in order to get the MAC 
adress. 
In 2.6.6, the PCI device ID of the ISA bridge of the SiS630E is 0x0018. The 
SiS900 driver fail to read MAC adress and exit with the following message : 
eth0: Can not find ISA bridge

3- SIS630E, ISA bridge, PCI Device ID, SIS900

4- aneto:~# cat /proc/version
Linux version 2.6.6 (ebenard@vignemale) (version gcc 3.3.3 (Debian 20040429)) 
#2 Sun May 16 19:34:22 CEST 2004

5- No oops

6- 
2.6.3-rc2 :
aneto:~# cat /sys/bus/pci/devices/0000\:00\:01.0/device
0x0008
aneto:~# cat /proc/bus/pci/devices
.../...
0008    10390008        0       00000000        00000000        00000000        
00000000        00000000        00000000 00000000        00000000        
00000000        00000000        00000000        00000000        
0000000000000000
0009    10390900        c       0000da01        f3ffd000        00000000        
00000000        00000000        00000000 f3fc0000        00000100        
00001000        00000000        00000000        00000000        
0000000000020000 sis900
.../...
aneto:~# lspci
.../...
0000:00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
Bridge)
0000:00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI 
Fast Ethernet (rev 81)
.../...

2.6.6 :
aneto:~# cat /sys/bus/pci/devices/0000\:00\:01.0/device
0x0018
aneto:~# cat /proc/bus/pci/devices
.../...
0008    10390018        0       00000000        00000000        00000000        
00000000        00000000        00000000 00000000        00000000        
00000000        00000000        00000000        00000000        
0000000000000000
0009    10390900        c       0000da01        f3ffd000        00000000        
00000000        00000000        00000000 f3fc0000        00000100        
00001000        00000000        00000000        00000000        
0000000000020000 sis900
.../...
aneto:~# lspci
.../...
0000:00:01.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
Bridge)
0000:00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI 
Fast Ethernet (rev 81)
.../...


7- Linux aneto 2.6.6 #2 Sun May 16 19:34:22 CEST 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
pcmcia-cs              3.2.5
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         hostap_crypt_wep hostap_cs ipt_TOS ipt_MASQUER                 
ADE ipt_REJECT ipt_pkttype ipt_LOG ipt_TCPMSS ipt_state ip_nat_irc ip                 
_nat_tftp ip_nat_ftp ip_conntrack_irc ip_conntrack_tftp ip_conntrack_                 
ftp ipt_multiport ipt_conntrack iptable_filter iptable_mangle iptable                 
_nat ip_conntrack ip_tables lp bridge hostap eagle_usb


8- A quick fix to get sis900.c running (which doesn't explain why the PCI 
Device ID changed from 2.6.3-rc2 to 2.6.6) :
change line 263 from
	if ((isa_bridge = pci_find_device(0x1039, 0x0008, isa_bridge)) == NULL
to
	if ((isa_bridge = pci_find_device(0x1039, 0x0018, isa_bridge)) == NULL

Eric
