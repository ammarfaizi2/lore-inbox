Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbTJXXZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 19:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTJXXZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 19:25:44 -0400
Received: from vsmtp3.tin.it ([212.216.176.223]:57048 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S261984AbTJXXZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 19:25:41 -0400
Message-ID: <016301c39a86$2ddf2600$02faa8c0@yakuzad6e0kj9b>
From: "-" <kernel@extracon.it>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at slab.c:1443 help me to 
Date: Sat, 25 Oct 2003 01:25:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

into /var/log/messages after server crash i have find this:

Oct 24 07:21:49 serv1 kernel: kernel BUG at slab.c:1443!
Oct 24 07:21:49 serv1 kernel: invalid operand: 0000
Oct 24 07:21:49 serv1 kernel: CPU:    0
Oct 24 07:21:49 serv1 kernel: EIP:    0010:[kmem_cache_free+342/624]    Not
tainted
Oct 24 07:21:49 serv1 kernel: EFLAGS: 00010083
Oct 24 07:21:49 serv1 kernel: eax: 170fc225   ebx: 0006b550   ecx: 00000038
edx: c23c78f0
Oct 24 07:21:49 serv1 kernel: esi: c23c7000   edi: c23c78ec   ebp: c23c78b8
esp: f6687e0c
Oct 24 07:21:49 serv1 kernel: ds: 0018   es: 0018   ss: 0018
Oct 24 07:21:49 serv1 kernel: Process kjournald (pid: 136,
stackpage=f6687000)
Oct 24 07:21:49 serv1 kernel: Stack: e49d0704 00000246 e49d06a4 c23c78bc
c23c78ec d1fb5e6c c016d0f9 c1c0fbd4
Oct 24 07:21:49 serv1 kernel:        c23c78bc e49d06a4 c23c73ec c0168573
c23c78bc c23c78bc 00000000 00000000
Oct 24 07:21:49 serv1 kernel:        00000000 00000016 dc6d5dc4 de9026c4
000016ec c0215cbb 00000009 0000fc00
Oct 24 07:21:49 serv1 kernel: Call Trace:
[journal_free_journal_head+41/48] [journal_commit_transaction+851/4836]
[__ide_dma_begin+43/64] [__ide_dma_count$
Oct 24 07:21:49 serv1 kernel:   [ide_dma_intr+0/176]
[dma_timer_expiry+0/128] [__ide_do_rw_disk+796/1456] [kjournald+387/720]
[commit_timeout+0/16] [arch_ker$
Oct 24 07:21:49 serv1 kernel:   [kjournald+0/720]
Oct 24 07:21:49 serv1 kernel:
Oct 24 07:21:49 serv1 kernel: Code: 0f 0b a3 05 f8 f5 2c c0 8b 54 24 1c 8b
42 1c eb 07 8b 4c 24


[root@serv1 root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.00GHz
stepping        : 4
cpu MHz         : 1992.653
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3971.48

[root@serv1 root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc800-000cdfff : Extension ROM
000ce000-000d1fff : reserved
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002bf3d1 : Kernel code
  002bf3d2-00348257 : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
cda00000-ddafffff : PCI Bus #01
  d0000000-d7ffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
ddd00000-dfdfffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV11 [GeForce2 MX/MX 400]
dfeff000-dfefffff : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  dfeff000-dfefffff : eepro100
e0000000-e3ffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fff00000-ffffffff : reserved


[root@serv1 root]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0c00-0c0f : Intel Corp. 82801BA/BAM SMBus
0cf8-0cff : PCI conf1
ac00-ac3f : Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller
  ac00-ac3f : eepro100
d000-d01f : Intel Corp. 82801BA/BAM USB (Hub #1)
  d000-d01f : usb-uhci
d400-d41f : Intel Corp. 82801BA/BAM USB (Hub #2)
  d400-d41f : usb-uhci
d800-d83f : Intel Corp. 82801BA/BAM AC'97 Audio
dc00-dcff : Intel Corp. 82801BA/BAM AC'97 Audio
fc00-fc0f : Intel Corp. 82801BA IDE U100
  fc00-fc07 : ide0
  fc08-fc0f : ide1

[root@serv1 root]# cat /proc/modules
ipv6                  171648  -1

i need help ..
i have run ram check and it's ok



Juri Tkachenok


