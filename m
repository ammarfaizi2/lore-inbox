Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUHRCtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUHRCtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 22:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268583AbUHRCtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 22:49:42 -0400
Received: from web81604.mail.yahoo.com ([206.190.37.121]:48056 "HELO
	web81604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267185AbUHRCti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 22:49:38 -0400
Message-ID: <20040818024937.92152.qmail@web81604.mail.yahoo.com>
X-RocketYMMF: mhcptg@sbcglobal.net
Date: Tue, 17 Aug 2004 19:49:37 -0700 (PDT)
From: Matt R Hall <mhall@mhcomputing.net>
Reply-To: mhall@mhcomputing.net
Subject: PROBLEM: IPv6 Dependencies Incorrect (2.6.8-rc4)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: IPv6 Dependencies Incorrect

[2.] Full description of the problem/report: When compiling 2.6.8-rc4
on a sparc32 system to avoid some errors in 2.6.7 assembly code
routines, I found that hard-compiling CONFIG_IPV6 into the kernel while
leaving CONFIG_IPV6_TUNNEL as a module caused the kernel to fail to
link.

[3.] Keywords (i.e., modules, networking, kernel): networking, ipv6
[4.] Kernel version (from /proc/version): 2.6.8-rc4

[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt): N/A

[6.] A small shell script or example program which triggers the problem
(if possible): Compile with CONFIG_IPV6 as hard-link with
CONFIG_IPV6_TUNNEL as a module. Witness linking failure.

[7.] Environment: Sun SparcStation 5 (110mHz)

[7.1.] Software (add the output of the ver_linux script here):
sparcy:/usr/src/linux# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux sparcy 2.4.26-sparc32 #1 Sun Jun 20 02:18:47 PDT 2004 sparc
GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15
util-linux             2.12
mount                  2.12
module-init-tools      2.4.26
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.2
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         sr_mod cdrom
sparcy:/usr/src/linux#

[7.2.] Processor information (from /proc/cpuinfo):
sparcy:/usr/src/linux# cat /proc/cpuinfo
cpu             : Fujitsu  MB86904
fpu             : Lsi Logic/Meiko L64804 or compatible
promlib         : Version 3 Revision 2
prom            : 2.24
type            : sun4m
ncpus probed    : 1
ncpus active    : 1
BogoMips        : 109.77
MMU type        : Fujitsu Swift
contexts        : 256
nocache total   : 2097152
nocache used    : 215808
sparcy:/usr/src/linux#

[7.3.] Module information (from /proc/modules): N/A, from old kernel
used to compile 2.6.8-rc4.
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem): N/A, from old kernel used to compile 2.6.8-rc4.
[7.5.] PCI information ('lspci -vvv' as root): N/A, uses SBus, not PCI.
[7.6.] SCSI information (from /proc/scsi/scsi):
sparcy:/usr/src/linux# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: DDRS34560SUN4.2G Rev: S98E
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: TOSHIBA  Model: XM-4101TASUNSLCD Rev: 1084
  Type:   CD-ROM                           ANSI SCSI revision: 02
sparcy:/usr/src/linux#
[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant): N/A
[X.] Other notes, patches, fixes, workarounds: Compile with CONFIG_IPV6
and CONFIG_IPV6_TUNNEL both as modules, or not as modules. Fix
menuconfig to do this automatically when one is changed. Rearrange IPV6
support so core support does not depend on tunneling.
