Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbRFNQkN>; Thu, 14 Jun 2001 12:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263365AbRFNQkD>; Thu, 14 Jun 2001 12:40:03 -0400
Received: from cnxtsmtp2.conexant.com ([198.62.9.253]:58616 "EHLO
	cnxtsmtp2.conexant.com") by vger.kernel.org with ESMTP
	id <S263359AbRFNQjx>; Thu, 14 Jun 2001 12:39:53 -0400
From: dan.davidson@conexant.com
Subject: Lockup in 2.4.2 kernel ADSL PCI card ATM driver module
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OF498D9381.A68AAD65-ON86256A6B.005A1479@conexant.com>
Date: Thu, 14 Jun 2001 11:37:50 -0500
X-MIMETrack: Serialize by Router on NPBSMTP1/Server/Conexant(Release 5.0.7 |March 21, 2001) at
 06/14/2001 09:39:34 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel community,

Sorry for intrusion, but I could use some guidance and/or direction in
tracking
down the source of a problem.  None of the messages I have seen in the
archives quite seem to match this problem (if there is one please let me
know).  I am looking for where or how to dig (deeper) to find the source of
the problem (described below).
Please CC me with any responses at
dan.davidson@conexant.com

Thanks much (in advance of any help),
Dan Davidson
dan.davidson@conexant.com
Conexant Systems, Inc.


SUBJECT:
Lockup in 2.4.2 kernel ADSL PCI card ATM driver module


DRIVER RESULTS:
Works fine in 2.4.0 kernel.
Locks up system (no messages/oops/etc.) in 2.4.2-2 kernel (rh 7.1).
Locks up system (no messages/oops/etc.) in 2.4.2 kernel (w/ or w/o kgdb).
Locks up system with "int 3" ??????? message in 2.4.2-ac28 kernel.


PROBLEM:
We are developing reference design Linux drivers for our PCI ADSL
reference design hardware.  We have had drivers working (not crashing
and able to transfer data) for kernel version 2.4.0.
Yet the same source code for the driver, compiled with each kernel
version, (and working fine for 2.4.0 kernel) causes system lockup
on 2.4.2 kernel versions.
The driver is a kernel module ATM driver for a Conexant PCI ADSL card.


SYSTEM:
Dell Dimension XPS 300
 Pentium II 300 MHz
 128MB RAM
 Maxtor 31024H2 (ATA) HD
 CDROM (ATAPI)
 Iomega Zip100 (ATAPI)
 1.44 FD
 3COM PCI ethernet
 Conexant PCI ADSL


FILES:
Several of the patch files, ".config" files, partial "System.map",
and output of dmesg can be found at "http://home.hiwaay.net/~rss1/linux"
and within the "2.4.0" and "2.4.2" subdirectories and the subdirectories
of "2.4.2" ("2", "ac28", and "kgdb").


2.4.0 KERNEL:
Start with Red Hat Linux 6.2 release.
Upgrade to kernel 2.4.0 (lilo for both 2.2.14-5 and 2.4.0)
applying patches "br2684-001212-against2.4.0.dif" and "atm-hdlc-patch"
and using "config.gz" as ".config".
Build kernel.
Install rpm "modutils-2.4.0-1.i386.rpm".
Install rpm "atm-0.78-1.i386.rpm".
Install Conexant ADSL driver.


2.4.2-2 (rh) KERNEL:
Start with Red Hat Linux 7.1 release.
Apply patches "br2684-001212-against2.4.2.dif" and "atm-hdlc-patch".
Configure kernel for:
 code maturity - experimental
 loadable module support - enable loadable and kernel module support
 networking options - enable ATM and classical IP over ATM
    and set to module enable LAN Emulation, multi-protocol over ATM,
    and RFC1483/2684 bridged protocols
 network device support - module enable PPP and PPPoATM
Build kernel.
Install rpm "atm-0.78-1.i386.rpm".
Install Conexant ADSL driver.


2.4.2-kgdb KERNEL:
Start with Red Hat Linux 7.1 release.
Add kernel 2.4.2 (lilo for both 2.4.2-2 and 2.4.2-kgdb)
Apply patch "linux-2.4.2-kgdb.patch".
Apply patches "br2684-001212-against2.4.2.dif" and "atm-hdlc-patch".
Configure kernel for:
 code maturity - experimental
 loadable module support - enable loadable and kernel module support
 networking options - enable ATM and classical IP over ATM
    and set to module enable LAN Emulation, multi-protocol over ATM,
    and RFC1483/2684 bridged protocols
 network device support - module enable PPP and PPPoATM
Build kernel.
Previously installed rpm "atm-0.78-1.i386.rpm".
Install Conexant ADSL driver.


2.4.2-ac28 KERNEL:
Start with Red Hat Linux 7.1 release.
Add kernel 2.4.2 (lilo for both 2.4.2-2, 2.4.2-kgdb, and 2.4.2-ac28)
Apply patch "patch-2.4.2-ac28".
Apply patches "br2684-001212-against2.4.2.dif" and "atm-hdlc-patch".
Configure kernel for:
 code maturity - experimental
 loadable module support - enable loadable and kernel module support
 networking options - enable ATM and classical IP over ATM
    and set to module enable LAN Emulation, multi-protocol over ATM,
    and RFC1483/2684 bridged protocols
 network device support - module enable PPP and PPPoATM
Build kernel.
Previously installed rpm "atm-0.78-1.i386.rpm".
Install Conexant ADSL driver.


MESSAGE GENERATED IN 2.4.2-ac28:
int 3: 0000
CPU:     0
EIP:     0010:[<c885478b>]
EFLAGS:  00000282
eax: c8854780   ebx: 00000000   ecx: c02873e8   edx: c100df74
esi: 00000000   edi: 00000000   ebp: c14e5f28   esp: c14e5f20
Process insmod (pid: 1401, stackpage-c14e5000)
Stack: c884d000 00000000 00000060 c0114c35 00000000 c0349000 000860a0
c034a000
       00000060 ffffffea 00000007 c6979fdc 00000060 c8845000 c884d060
000ae220
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
Call Trace: [<c884d000>] [<c0114c35>] [<c8845000>] [<c884d060>]
[<c0106ffb>] [<c
010002b>]

Code: 83 ec 0c 68 d0 17 8b c8 e8 e8 f6 8b f7 c7 04 24 00 18 8b c8
 make[1]: *** [start] Segmentation fault


