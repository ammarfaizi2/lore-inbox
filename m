Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTFLWFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbTFLWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:05:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:17637 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265006AbTFLWFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:05:07 -0400
Message-ID: <3EE8FC4C.7080404@gmx.de>
Date: Fri, 13 Jun 2003 00:18:52 +0200
From: Frederik Reiss <frederikreiss@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030610
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: When CDPATH enviroment variable is set the "asm" symlink is placed
 in the wrong directory
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the CDPATH enviroment variable is set in the bash (
http://www.caliban.org/bash/index.shtml#bashtips )
the "asm" symlink is placed in /usr/src/linux/ and not in
/usr/src/linux/include/ where it should be.

Steps to reproduce:
1. export CDPATH="/mnt"
2. extract a fresh kernel source or delete the include/asm symlink
3. cd /usr/src/linux-2.4.20/
4. make xconfig
5. quit "make xconfig"

Actual result:
Now there is a symlink with the name "asm" in /usr/src/linux-2.4.20/
which points to asm-i386 what is wrong.
Because of the "asm" symlink is in the wrong directory the kernel
compilation fails.

Expected result:
The symlink should be in /usr/src/linux/include/

Other infos:
I have tried this with the kernel 2.4.20 and 2.4.21-rc8
I am curently running Debian woody 3.0 with the 2.4.21-rc2 kernel.

<drd@bigbad>:~$ bash --version
GNU bash, version 2.05a.0(1)-release (i386-pc-linux-gnu)
Copyright 2001 Free Software Foundation, Inc.

<drd@bigbad>:~$ uname -a
Linux bigbad 2.4.21-rc2-bigb #1 Die Mai 20 22:08:10 CEST 2003 i686 unknown


<drd@bigbad>:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 503.526
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 sep mtrr pge mca cmov
pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1002.70


<drd@bigbad>:~$ lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate]
System Controller (rev 25)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP
Bridge (rev 01)
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 1b)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 0e)
00:04.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)
00:0e.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)
00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
00:0f.1 Input device controller: Creative Labs SB Live! (rev 08)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
00:11.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:11.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
01:05.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX
DDR) (rev b2)

-- 
(German philosopher) Georg Wilhelm Hegel, on his deathbed, complained,
"Only one man ever understood me."  He fell silent for a while and then 
added,
"And he didn't understand me."

