Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266341AbUJVTHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266341AbUJVTHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUJVTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:06:49 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2827 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265697AbUJVTAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:00:21 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: cannot up iface in 2.6.9, was working in 2.6.9-rc3
Date: Fri, 22 Oct 2004 21:59:26 +0300
User-Agent: KMail/1.5.4
Cc: netdev@oss.sgi.com, Jeff Garzik <jgarzik@pobox.com>,
       Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Message-Id: <200410222159.26369.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an onboard VIA eth:

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:0a.0 Network controller: Texas Instruments ACX 111 54Mbps Wireless Interface
00:0c.0 Network controller: Harris Semiconductor D-Links DWL-g650 A1 (rev 01)
00:10.0 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1)

It cannot be upped:

# ip l set dev if up
SIOCSIFFLAGS: Function not implemented
# ifconfig if up
SIOCSIFFLAGS: Function not implemented
# busybox ip l set dev if up
SIOCSIFFLAGS: Function not implemented

Strace (busybox one is smallest):

execve("/usr/bin/busybox", ["busybox", "ip", "l", "set", "dev", "if", "up"], [/* 28 vars */]) = 0
fcntl64(0, F_GETFD)                     = 0
fcntl64(1, F_GETFD)                     = 0
fcntl64(2, F_GETFD)                     = 0
uname({sys="Linux", node="shadow", ...}) = 0
geteuid32()                             = 0
getuid32()                              = 0
getegid32()                             = 0
getgid32()                              = 0
brk(0)                                  = 0x81ab000
brk(0x81ac000)                          = 0x81ac000
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
ioctl(4, 0x8913, 0xbffff9e0)            = 0
ioctl(4, 0x8914, 0xbffff9e0)            = -1 ENOSYS (Function not implemented)
dup(2)                                  = 5
fcntl64(5, F_GETFL)                     = 0x2 (flags O_RDWR)
fstat64(5, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 2), ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40000000
_llseek(5, 0, 0xbffff830, SEEK_CUR)     = -1 ESPIPE (Illegal seek)
write(5, "SIOCSIFFLAGS: Function not imple"..., 39) = 39
close(5)                                = 0
munmap(0x40000000, 4096)                = 0
close(4)                                = 0
write(2, "BusyBox v1.00-pre8 (2004.03.31-2"..., 295) = 295
_exit(1)

It was working in 2.6.9-rc3.

drivers/net/via-rhine.c did not change between rc3 and "official" 2.6.9
--
vda

