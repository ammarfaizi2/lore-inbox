Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSIICZq>; Sun, 8 Sep 2002 22:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSIICZq>; Sun, 8 Sep 2002 22:25:46 -0400
Received: from leela.mcs.anl.gov ([140.221.8.226]:34724 "EHLO
	leela.mcs.anl.gov") by vger.kernel.org with ESMTP
	id <S316289AbSIICZo>; Sun, 8 Sep 2002 22:25:44 -0400
Date: Sun, 8 Sep 2002 21:30:20 -0500
From: Robert Latham <robl@mcs.anl.gov>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.19-rc1-ac2 ide BUG: maybe related to promise 20268 ?
Message-ID: <20020909023020.GK3688@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I captured and decoded this backtrace on a 2.4.19-rc1-ac2 kernel.  The
relevant hardware: 
. Tyan 2466 dual athlon motherboard ( one processor) 
. promise Ultra tx-2 ide controller ( promise 20268 ) 
	running in a 66 MHz pci slot

AMD7441: IDE controller on PCI bus 00 dev 39
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD400EB-00CPF0, ATA DISK drive
hdc: CDU5211, ATAPI CD/DVD-ROM drive

PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x1010-0x1017, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1018-0x101f, BIOS settings: hdg:pio, hdh:pio
hde: WDC WD1200JB-00CRA1, ATA DISK drive
hdf: WDC WD1200JB-00CRA1, ATA DISK drive
hdg: WDC WD1200JB-00CRA1, ATA DISK drive
hdh: WDC WD1200JB-00CRA1, ATA DISK drive


I've got 3 other machines with this hardare that run reliably.  (I
know 2.4.19-rc1-ac2 is a bit old, but since the other 3 run fine with
it, i haven't tried newer kernels.)  This one machine, however, will
lock up (usually w/o a BUG report ) every day or every 2nd day.

I've swapped the Ultra tx-2 once, and am about to do it again ( maybe
i'm 'lucky' and have two bum cards): 

does the following backtrace look like a bad card, or might the
problem lie elsewhere?

thank for the help.  Please copy me on replies, though i will keep an
eye on this thread in the archives. 

Reading Oops report from the terminal
kernel BUG at ide.c:647!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01bac03>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: c16dc380   ebx: 00003908   ecx: c01b7ff0   edx: c16dc380
esi: 00003908   edi: c02fd42c   ebp: c02fd2a0   esp: c0297e20
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0297000)
Stack: c16dc380 00000282 00000080 c1754cc0 c02fd42c 00000000 c01bac4b c02fd42c 
       00000000 c01c7bb6 c02fd42c 000000d0 c02d4900 c0297e7c 00000000 c02d4900 
       c027dd88 c0109d4c 00000282 003fdafb c02fd42c 00000040 c010bd68 00000282 
Call Trace: [<c01bac4b>] [<c01c7bb6>] [<c0109d4c>] [<c010bd68>] [<c01b7c83>] 
   [<c01bb951>] [<c01bfb66>] [<c01bbd04>] [<c01bbf4b>] [<c01bbda0>] [<c011dab9> 
   [<c011dc0d>] [<c011a30b>] [<c011a213>] [<c011a03b>] [<c0109d4c>] [<c0106c50> 
   [<c0105000>] [<c010bd68>] [<c0106c50>] [<c0106c50>] [<c0105000>] [<c0106c73> 
   [<c0106cc4>] 
Code: 0f 0b 87 02 83 fc 25 c0 6a 00 6a 05 68 40 a8 1b c0 57 e8 36 

>>EIP; c01bac03 <do_reset1+173/1b0>   <=====
Trace; c01bac4b <ide_do_reset+b/10>
Trace; c01c7bb6 <idedisk_error+176/1b0>
Trace; c0109d4c <do_IRQ+9c/b0>
Trace; c010bd68 <call_do_IRQ+5/d>
Trace; c01b7c83 <ide_wait_stat+103/120>
Trace; c01bb951 <start_request+151/220>
Trace; c01bfb66 <ide_dma_timeout_recovery+f6/100>
Trace; c01bbd04 <ide_do_request+294/2e0>
Trace; c01bbf4b <ide_timer_expiry+1ab/1c0>
Trace; c01bbda0 <ide_timer_expiry+0/1c0>
Trace; c011dab9 <timer_bh+259/370>
Trace; c011dc0d <do_timer+3d/70>
Trace; c011a30b <bh_action+1b/50>
Trace; c011a213 <tasklet_hi_action+43/70>
Trace; c011a03b <do_softirq+4b/90>
Trace; c0109d4c <do_IRQ+9c/b0>
Trace; c0106c50 <default_idle+0/30>
Trace; c0105000 <_stext+0/0>
Trace; c010bd68 <call_do_IRQ+5/d>
Trace; c0106c50 <default_idle+0/30>
Trace; c0106c50 <default_idle+0/30>
Trace; c0105000 <_stext+0/0>
Trace; c0106c73 <default_idle+23/30>
Trace; c0106cc4 <cpu_idle+24/30>
Code;  c01bac03 <do_reset1+173/1b0>
00000000 <_EIP>:
Code;  c01bac03 <do_reset1+173/1b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01bac05 <do_reset1+175/1b0>
   2:   87 02                     xchg   %eax,(%edx)
Code;  c01bac07 <do_reset1+177/1b0>
   4:   83 fc 25                  cmp    $0x25,%esp
Code;  c01bac0a <do_reset1+17a/1b0>
   7:   c0 6a 00 6a               shrb   $0x6a,0x0(%edx)
Code;  c01bac0e <do_reset1+17e/1b0>
   b:   05 68 40 a8 1b            add    $0x1ba84068,%eax
Code;  c01bac13 <do_reset1+183/1b0>
  10:   c0 57 e8 36               rclb   $0x36,0xffffffe8(%edi)

 <0>Kernel panic: Aiee, killing interrupt handler!

-- 
Rob Latham
Mathematics and Computer Science Division    A215 0178 EA2D B059 8CDF
Argonne National Labs, IL USA                B29D F333 664A 4280 315B
