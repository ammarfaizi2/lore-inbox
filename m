Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbTCSWUb>; Wed, 19 Mar 2003 17:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbTCSWUb>; Wed, 19 Mar 2003 17:20:31 -0500
Received: from web41012.mail.yahoo.com ([66.218.93.11]:58637 "HELO
	web41012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263207AbTCSWSz>; Wed, 19 Mar 2003 17:18:55 -0500
Message-ID: <20030319222949.21257.qmail@web41012.mail.yahoo.com>
Date: Wed, 19 Mar 2003 14:29:49 -0800 (PST)
From: Sander vd Burg <svdb99@yahoo.com>
Subject: PROBLEM: Mysterious crash, Unable to handle kernel paging request at virtual address 32428b24
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a pretty old toshiba 230cx laptop and
installed slackware 8.0 (kernel 2.2.19) on it.
I upgraded to kernel 2.4.20 (manually) and in a lot of
situations the system hangs and reports (something
like this):

Unable to handle kernel paging request at virtual
address 32428b24
 printing eip:
c0123318
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0123318>]    Not tainted
EFLAGS: 00010086
eax: 32428b24    ebx: c002e0a8    ecx: 00000020   
edx: 00000020
esi: 32428b20    edi: c027c0f4    ebp: 00000001   
esp: c0dd7ee4
ds: 0018    es: 0018    ss: 0018
Process fsck.ext2 (pid: 27, stackpage=c0dd7000)
Stack: c0483b00 00000002 c002e0a8 c0130f37 c0483b00
c0033620 00000008 00000001
       c01b6575 c0483b00 00000001 c0033620 00000096
c0035060 00000008 c01beaa6
       c0033620 00000001 c02f5b2c 00000018 00000400
c0033620 011ca018 c01ca865
Call trace:    [<c0130f37>] [<c01b6575>] [<c01beaa6>]
[<c01ca865>] [<c01c0659>]
  [<c01ca770>] [<c0107f5d>] [<c01080ce>] [<c010a288>]

Code: 39 46 04 74 0e 31 c9 ba 03 00 00 00 89 f0 e8 55
e6 fe ff 5b
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Most of the crashes are related to virtual page
address: 32428b24, but I have absolutely no idea what
kind of hardware or modules are resposible for this.

This crash occurs when:

- I run fsck.ext2
- I start X (startx script)
- I send a file to my desktop computer with a PLIP
connection)
- I try to play music
- And many other situations

I don't know where this crash is related to. I tried
to enable/disable various options in the kernel, but
it all failed.

My kernel information:

'lspci -vvv' output:

00:00.0 Host bridge: Toshiba America Info Systems 601
(rev a7)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set, cache line size 08

00:02.0 CardBus bridge: Toshiba America Info Systems
ToPIC95 (rev 07)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 10000000 (32-bit,
non-prefetchable) [disabled]
	Bus: primary=00, secondary=14, subordinate=14,
sec-latency=0
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset-
16bInt- PostWrite-

00:02.1 CardBus bridge: Toshiba America Info Systems
ToPIC95 (rev 07)
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 10001000 (32-bit,
non-prefetchable) [disabled]
	Bus: primary=00, secondary=15, subordinate=15,
sec-latency=0
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset-
16bInt- PostWrite-

00:04.0 VGA compatible controller: Chips and
Technologies 65554 (rev c2)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at fe000000 (32-bit,
non-prefetchable)

00:0b.0 USB Controller: NEC Corporation USB (rev 01)
(prog-if 10)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 1 min, 21 max, 64 set
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fdfff000 (32-bit,
non-prefetchable)


/proc/ioports:

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1

/proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 4
model name	: Pentium MMX
stepping	: 3
cpu MHz		: 132.633
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 264.60

/proc/iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000f0000-000fffff : System ROM
00100000-0101ffff : System RAM
  00100000-002369e9 : Kernel code
  002369ea-002b5abf : Kernel data
10000000-10000fff : Toshiba America Info Systems
ToPIC95
10001000-10001fff : Toshiba America Info Systems
ToPIC95 (#2)
fdfff000-fdffffff : NEC Corporation USB
fe000000-feffffff : Chips and Technologies F65554
fffe0000-ffffffff : reserved

btw. this crash doesn't occur with kernel 2.2.19

If you need more information about my hardware (or
other things) to fix this, please tell me.

Greetings,

Sander van der Burg

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
