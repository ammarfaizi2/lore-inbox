Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288112AbSACBdo>; Wed, 2 Jan 2002 20:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288109AbSACBdf>; Wed, 2 Jan 2002 20:33:35 -0500
Received: from [203.97.82.178] ([203.97.82.178]:11710 "EHLO loki.treshna.com")
	by vger.kernel.org with ESMTP id <S288108AbSACBd1>;
	Wed, 2 Jan 2002 20:33:27 -0500
Subject: Kernel Panics Problem
From: Andru Hill <andru@treshna.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Jan 2002 14:33:24 +1300
Message-Id: <1010021604.24724.78.camel@nikita>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. I am running 2.4.17 on half a dozen computers but i've found one
of the servers has a very weird problem and reguarlly kernel panics.
NFS, samba, NIS, and exim are the main services i run on this server.
Every day or so the system kernel panics and only leaves me with a dump
screen.  Sorry I dont have much more than this to work on, and i can't
nail it down to a specific module.  



Kernel Panic Log:


Dec 29 18:32:26 ymcaserver kernel: eth0: Setting half-duplex based on
auto-negotiated partner ability 0000.
Dec 29 18:35:15 ymcaserver kernel: reiserfs: checking transaction log
(device 16:03) ...
Dec 29 18:35:19 ymcaserver kernel: spurious 8259A interrupt: IRQ7.
Dec 29 18:35:19 ymcaserver kernel: Using r5 hash to sort names
Dec 29 18:35:19 ymcaserver kernel: ReiserFS version 3.6.25
Dec 29 18:38:37 ymcaserver kernel: Unable to handle kernel paging
request at virtual address 40dc3a29
Dec 29 18:38:37 ymcaserver kernel:  printing eip:
Dec 29 18:38:37 ymcaserver kernel: c01b6309
Dec 29 18:38:37 ymcaserver kernel: *pde = 00000000
Dec 29 18:38:37 ymcaserver kernel: Oops: 0002
Dec 29 18:38:37 ymcaserver kernel: CPU:    0
Dec 29 18:38:37 ymcaserver kernel: EIP:    0010:[<c01b6309>]    Not
tainted
Dec 29 18:38:37 ymcaserver kernel: EFLAGS: 00010046
Dec 29 18:38:37 ymcaserver kernel: eax: 40dc39fd   ebx: 00000301   ecx:
00000008   edx: c02d6858
Dec 29 18:38:37 ymcaserver kernel: esi: c02d6840   edi: dc3b0540   ebp:
00000008   esp: de511e1c
Dec 29 18:38:37 ymcaserver kernel: ds: 0018   es: 0018   ss: 0018
Dec 29 18:38:37 ymcaserver kernel: Process mv (pid: 317,
stackpage=de511000)
Dec 29 18:38:37 ymcaserver kernel: Stack: c02d6840 c18270c0 00000008
00000301 dc3b0540 02204850 05a56c49 c02d6858 
Dec 29 18:38:37 ymcaserver kernel:        00002000 c02d6860 c18270c0
c02d6858 000000ff 00000000 00000000 02204850 
Dec 29 18:38:37 ymcaserver kernel:        c18270c0 c01b688c c02d6840
00000000 dc3b0540 00000008 00000000 dc3b0540 
Dec 29 18:38:37 ymcaserver kernel: Call Trace: [<c01b688c>] [<c01b68df>]
[<c0132840>] [<c012ad13>] [<c01244ac>] 
Dec 29 18:38:37 ymcaserver kernel:    [<c0183aef>] [<c01812e0>]
[<c0124555>] [<c0124ae5>] [<c0124cf2>] [<c01251f5>] 
Dec 29 18:38:37 ymcaserver kernel:    [<c0125110>] [<c0130216>]
[<c0106c4b>] 
Dec 29 18:38:37 ymcaserver kernel: 
Dec 29 18:38:37 ymcaserver kernel: Code: 89 78 2c 8b 44 24 40 89 78 48
8b 54 24 40 89 e8 83 c4 0c 03 

I also receive this in the kernel log at a later date, though the time
did not correlate to a kernel panic.  there was a number of MB's chewed
up by this log message.

Jan  2 12:23:14 ymcaserver kernel: eth0: Setting half-duplex based on
auto-negotiated partner ability 0000.
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (flags&MSG_PEEK)
failed at tcp.c(1463):tcp_recvmsg
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (skb==NULL ||
before(tp->copied_seq, TCP_SKB_CB(skb)->end_seq)) failed at
tcp.c(1286):cleanup_rbuf
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (flags&MSG_PEEK)
failed at tcp.c(1463):tcp_recvmsg
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (skb==NULL ||
before(tp->copied_seq, TCP_SKB_CB(skb)->end_seq)) failed at
tcp.c(1286):cleanup_rbuf
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (flags&MSG_PEEK)
failed at tcp.c(1463):tcp_recvmsg
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (skb==NULL ||
before(tp->copied_seq, TCP_SKB_CB(skb)->end_seq)) failed at
tcp.c(1286):cleanup_rbuf
Jan  2 16:56:33 ymcaserver kernel: KERNEL: assertion (flags&MSG_PEEK)
failed at tcp.c(1463):tcp_recvmsg


The hardware from this computers is similar to many of the other
computers with the major difference been that it has 100GB WD IDE Hard
Drive.  I thought this may have something to do with and that it uses
the reiserfs.

Just some addtional system info, if thats any help:

ymcaserver:/proc# cat cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1600+
stepping	: 2
cpu MHz		: 1400.101
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2791.83

ymcaserver:/proc# cat modules 
nls_cp437               4384   0 (unused)
eepro100               17232   1

ymcaserver:/proc# cat ioports 
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-907f : PCI device 1039:0300 (Silicon Integrated Systems [SiS])
a000-a003 : Advanced Micro Devices [AMD] AMD-760 [Irongate] System
Controller
a400-a40f : VIA Technologies, Inc. Bus Master IDE
  a400-a407 : ide0
  a408-a40f : ide1
a800-a81f : VIA Technologies, Inc. UHCI USB
ac00-ac1f : VIA Technologies, Inc. UHCI USB (#2)
b000-b0ff : VIA Technologies, Inc. AC97 Audio Controller
b400-b403 : VIA Technologies, Inc. AC97 Audio Controller
b800-b803 : VIA Technologies, Inc. AC97 Audio Controller
bc00-bcff : Realtek Semiconductor Co., Ltd. RTL-8139
  bc00-bcff : 8139too
c000-c01f : Intel Corp. 82557 [Ethernet Pro 100]
  c000-c01f : eepro100



If anyone can give me any help, it would be much appreciated.  If you
think this could be a hardware related problem let me know so i can
replace that hardware.

Andru Hill




