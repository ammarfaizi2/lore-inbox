Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbTFJSWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTFJSWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:22:35 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:60336 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261280AbTFJSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:21:07 -0400
From: "Andreas Achtzehn" <linux-kernel@achtzehn.homelinux.org>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: pppoe.o module + socket filtering
Date: Tue, 10 Jun 2003 20:34:45 +0200
Message-ID: <EMEAKOPCBDOCHKHEEBCGIEKGCCAA.linux-kernel@achtzehn.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.10; AVE: 6.20.0.0; VDF: 6.20.0.5; host: achtzehn.homelinux.org)
X-Seen: false
X-ID: ZBj5DTZHreUlb9RJ-54pov9KMA+jmRiE0zqgqb7tlyorXwB3YMwr4g@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

	When compiling pppoe as module and enable socket filtering, pppoe module
has unresolved symbols. Problem not solved by inserting ppp filter into
	kernel.

[2.] Full description of the problem/report:
	I tried to compile kernel 2.4.20 with pppoe as module(CONFIG_PPPOE) and
socket filtering(CONFIG_FILTER) enabled.
	When inserting the module I get
	/lib/modules/2.4.20/kernel/drivers/net/pppoe.o: unresolved symbol
unregister_pppox_proto_Rsmp_e0ff7a18
	/lib/modules/2.4.20/kernel/drivers/net/pppoe.o: unresolved symbol
sk_run_filter
	/lib/modules/2.4.20/kernel/drivers/net/pppoe.o: unresolved symbol
register_pppox_proto_Rsmp_b3f02568
	/lib/modules/2.4.20/kernel/drivers/net/pppoe.o: unresolved symbol
pppox_unbind_sock_Rsmp_ae0e4dd5
	Using /lib/modules/2.4.20/kernel/drivers/net/pppoe.o

	When compiling PPP filtering into the kernel, I get (when trying to load
ppp_generic)

	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
sk_run_filter
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
slhc_uncompress_Rsmp_3bc1319e
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
slhc_remember_Rsmp_0bc55868
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
sk_chk_filter
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
slhc_free_Rsmp_2894cfb0
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
slhc_init_Rsmp_2e0e927f
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
slhc_compress_Rsmp_76135e6c
	/lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o: unresolved symbol
slhc_toss_Rsmp_f89e3455
	Using /lib/modules/2.4.20/kernel/drivers/net/ppp_generic.o

[3.] Keywords (i.e., modules, networking, kernel):
	networking, modules, unresolved symbols
[4.] Kernel version (from /proc/version):
	Linux version 2.4.20 (root@enkil) (gcc version 3.2.1) #5 Wed May 14
15:19:28 CEST 2003
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
	none.
[6.] A small shell script or example program which triggers the
     problem (if possible)
	insmod pppoe
	insmod ppp-generic

[7.] Environment
	i386 Server Pentium compiled, Linux from Scratch 4.1
[7.1.] Software (add the output of the ver_linux script here)
enkil:/usr/src/linux/scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux enkil 2.4.20 #8 Die Jun 10 17:09:14 CEST 2003 i586 unknown

Gnu C                  3.2.1
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.1
Procps                 3.1.5
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         3c509 8139too
[7.2.] Processor information (from /proc/cpuinfo):
enkil:/usr/src/linux/scripts # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 5
model           : 4
model name      : Pentium MMX
stepping        : 3
cpu MHz         : 166.194
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : yes
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx
bogomips        : 331.77
[7.3.] Module information (from /proc/modules):
enkil:/usr/src/linux/scripts # cat /proc/modules
3c509                  10804   1 (autoclean)
8139too                14664   1 (autoclean)
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
enkil:/usr/src/linux/scripts # cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0300-030f : 3c509
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
f8f0-f8ff : Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
  f8f0-f8f7 : ide0
  f8f8-f8ff : ide1
fc00-fcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  fc00-fcff : 8139too

enkil:/usr/src/linux/scripts # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-002739fc : Kernel code
  002739fd-002fa37f : Kernel data
f8000000-fbffffff : S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX]
fedffc00-fedffcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  fedffc00-fedffcff : 8139too
fffe0000-ffffffff : reserved
[7.5.] PCI information ('lspci -vvv' as root)
see above
[7.6.] SCSI information (from /proc/scsi/scsi)
none
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
This configuration is necessary if you want to run a machine that serves as
DHCP server and PPP router. This might be important.

[X.] Other notes, patches, fixes, workarounds:

System.map has sk_run_filter references. Strange...
enkil:/ # cat /boot/System.map-2.4.20 |grep "sk_run"
c0227240 T sk_run_filter
c02b8400 R __kstrtab_sk_run_filter
c02bdf10 R __ksymtab_sk_run_filter



Regards,

Andreas

