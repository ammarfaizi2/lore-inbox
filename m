Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbTC1Fte>; Fri, 28 Mar 2003 00:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbTC1Fte>; Fri, 28 Mar 2003 00:49:34 -0500
Received: from tiaan.netsys.co.za ([192.96.51.30]:40883 "EHLO
	tiaan.netsys.co.za") by vger.kernel.org with ESMTP
	id <S262213AbTC1Ftd>; Fri, 28 Mar 2003 00:49:33 -0500
Message-Id: <200303280600.h2S60YC02395@tiaan.netsys.co.za>
Content-Type: text/plain; charset=US-ASCII
From: Tiaan Wessels <tiaan@netsys.co.za>
To: linux-kernel@vger.kernel.org
Subject: x.25 bug
Date: Fri, 28 Mar 2003 06:00:34 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
x.25 stack fails on receiving class D facility

[2.] Full description of the problem/report:
when making a call to linux x.25 stack which includes class D facility such 
as CALL REDIRECT, driver contains fatal bug

[3.] Keywords (i.e., modules, networking, kernel):
networking wan x25 classd facilities

[4.] Kernel version (from /proc/version):
Linux version 2.4.7-10 (bhcompile@stripples.devel.redhat.com) (gcc version 
2.96
20000731 (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 17:27:27 EDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
none

[6.] A small shell script or example program which triggers the
     problem (if possible)
make a call to linux x25 with class D facilities in protocol

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              tune2fs
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ide-cd cdrom cmpci soundcore agpgart NVdriver 
binfmt_misc dgrp iscsi scsi_mod autofs 3c59x appletalk ipx ipchains usb-ohci 
usbcore ext3 jbd

[7.2.] Processor information (from /proc/cpuinfo):
not relevant

[7.3.] Module information (from /proc/modules):
not relevant

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
not relevant

[7.5.] PCI information ('lspci -vvv' as root)
not relevant

[7.6.] SCSI information (from /proc/scsi/scsi)
not relevant

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
none

[X.] Other notes, patches, fixes, workarounds:
in net/x25/x25_facilities.c function x25_parse_facilities
there is switch with case X25_FAC_CLASS_D which has code

p   += p[1] + 2;
len -= p[1] + 2;

the problem is in decrementing len, p is used after it was modified
in previous statement. i suspect cut-and-paste here. to fix one
would put p[1] in temp variable of unsigned char first and then use
this instead of p[1] in these statements. if this is not done and
a call arrives with class D facilities, we see a faint blinking of
the eye before lights goes out.

can someone more familiar with the kernel patch process please update
the latest sources.

regards
tiaan
