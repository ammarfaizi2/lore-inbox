Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290732AbSARQWV>; Fri, 18 Jan 2002 11:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290733AbSARQWN>; Fri, 18 Jan 2002 11:22:13 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:48558 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S290732AbSARQWE>; Fri, 18 Jan 2002 11:22:04 -0500
Date: Fri, 18 Jan 2002 16:22:03 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: probably very irrelevant oops
In-Reply-To: <3C4739D3.DCFFA025@zip.com.au>
Message-ID: <Pine.LNX.4.44.0201181559540.2851-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The bug probably is in the module which immediately preceded
>es1371 in your /proc/modules output.  Could you please load
>them all up again, send me your /proc/modules output?

Further exploration revealed an oops on loading the modules. Here's a clip
from find /lib/modules/2.4.17-expt/kernel -type f

/lib/modules/2.4.17-expt/kernel/drivers/net/plip.o
/lib/modules/2.4.17-expt/kernel/drivers/net/8139cp.o
/lib/modules/2.4.17-expt/kernel/drivers/net/slhc.o
/lib/modules/2.4.17-expt/kernel/drivers/net/slip.o
/lib/modules/2.4.17-expt/kernel/drivers/net/wireless/hermes.o
/lib/modules/2.4.17-expt/kernel/drivers/net/wireless/orinoco.o
/lib/modules/2.4.17-expt/kernel/drivers/net/wireless/airo.o
/lib/modules/2.4.17-expt/kernel/drivers/net/wireless/orinoco_plx.o
/lib/modules/2.4.17-expt/kernel/drivers/net/arlan.o
/lib/modules/2.4.17-expt/kernel/drivers/net/8390.o
/lib/modules/2.4.17-expt/kernel/drivers/net/3c509.o
/lib/modules/2.4.17-expt/kernel/drivers/net/3c59x.o
/lib/modules/2.4.17-expt/kernel/drivers/net/shaper.o
/lib/modules/2.4.17-expt/kernel/drivers/net/pppoe.o
/lib/modules/2.4.17-expt/kernel/drivers/net/pppox.o
/lib/modules/2.4.17-expt/kernel/drivers/net/de4x5.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/maps/physmap.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/maps/elan-104nc.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/maps/pnc2000.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/maps/netsc520.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/maps/sbc_gxx.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/maps/sc520cdp.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/nand/nand.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/nand/nand_ecc.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/mtdram.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/slram.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/blkmtd.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/doc1000.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/doc2000.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/doc2001.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/docprobe.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/pmc551.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/devices/docecc.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/gen_probe.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/map_absent.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/jedec_probe.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/chipreg.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/cfi_probe.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/map_ram.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/map_rom.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/cfi_cmdset_0001.o
/lib/modules/2.4.17-expt/kernel/drivers/mtd/chips/cfi_cmdset_0002.o

..and the corresponding oops as logged by sysklogd..
(NB my find -exec insmod "{}" \; was run more than once)

8139cp 10/100 PCI Ethernet driver v0.0.5 (Oct 19, 2001)
arlan: no devices found
physmap flash device: 4000000 at 8000000
Failed to ioremap
ELAN-104NC flash: IO:0x22-0x23 MEM:0xb0000-0xb7fff
CFI: Found no ELAN-104NC flash device at location zero
Trying to free nonexistent resource <00000022-00000023>
Photron PNC-2000 flash mapping: 400000 at bf000000
Unable to handle kernel paging request at virtual address bf000000
 printing eip:
d12c4108
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[reiserfs:__insmod_reiserfs_S.bss_L6624+11033736/350043552]    Not tainted
EIP:    0010:[<d12c4108>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: d12c4300   ecx: 00000004   edx: 00f000f0
esi: 00f000f0   edi: 00000004   ebp: ca609e94   esp: ca609ca4
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 3228, stackpage=ca609000)
Stack: d1004105 d12c4300 00f000f0 00000000 00000978 c014a19a 0805e688 0805e688
       0805ed60 00000000 ca608000 c9aba914 0805dcc8 00000000 00000000 ca609e94
       d12c4300 d1005030 d1005030 d1000377 d12c4300 00000000 00000000 ca609e94
Call Trace: [reiserfs:__insmod_reiserfs_S.bss_L6624+8150149/352927139] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [load_elf_binary+2362/2688] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+8154032/352923256]
Call Trace: [<d1004105>] [<d12c4300>] [<c014a19a>] [<d12c4300>] [<d1005030>]
   [reiserfs:__insmod_reiserfs_S.bss_L6624+8154032/352923256] [reiserfs:__insmod_reiserfs_S.bss_L6624+8134391/352942897] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+8133748/352943540] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048]
   [<d1005030>] [<d1000377>] [<d12c4300>] [<d12c4300>] [<d10000f4>] [<d12c4300>]
   [reiserfs:__insmod_reiserfs_S.bss_L6624+8154032/352923256] [e100:__insmod_e100_S.text_L35088+11122/35424] [e100:__insmod_e100_S.rodata_L96+8216/9184] [e100:__insmod_e100_S.text_L35088+9210/35424] [getblk+24/64] [e100:__insmod_e100_O/lib/modules/2.4.17-expt/kernel/drivers/net/+-1949807/96]
   [<d1005030>] [<d0a0cbd2>] [<d0a14ad8>] [<d0a0c45a>] [<c0132e08>] [<d082df91>]
   [e100:__insmod_e100_O/lib/modules/2.4.17-expt/kernel/drivers/net/+-1947579/96] [e100:__insmod_e100_O/lib/modules/2.4.17-expt/kernel/drivers/net/+-1930449/96] [e100:__insmod_e100_O/lib/modules/2.4.17-expt/kernel/drivers/net/+-1885122/96] [e100:__insmod_e100_O/lib/modules/2.4.17-expt/kernel/drivers/net/+-1950321/96] [fast_clear_page+10/96] [do_no_page+49/272]
   [<d082e845>] [<d0832b2f>] [<d083dc3e>] [<d082dd8f>] [<c01baaca>] [<c0121d11>]
   [reiserfs:__insmod_reiserfs_S.bss_L6624+8154040/352923248] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+8133616/352943672] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+8154032/352923256] [reiserfs:__insmod_reiserfs_S.bss_L6624+8154040/352923248]
   [<d1005038>] [<d12c4300>] [<d1000070>] [<d12c4300>] [<d1005030>] [<d1005038>]
   [reiserfs:__insmod_reiserfs_S.bss_L6624+11034212/350043076] [reiserfs:__insmod_reiserfs_S.bss_L6624+8153534/352923754] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+8154032/352923256] [reiserfs:__insmod_reiserfs_S.bss_L6624+8142022/352935266] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048]
   [<d12c42e4>] [<d1004e3e>] [<d12c4300>] [<d1005030>] [<d1002146>] [<d12c4300>]
   [reiserfs:__insmod_reiserfs_S.bss_L6624+11033859/350043429] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034212/350043076] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034240/350043048] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034080/350043208] [sys_init_module+1317/1504] [reiserfs:__insmod_reiserfs_S.bss_L6624+11034676/350042612]
   [<d12c4183>] [<d12c42e4>] [<d12c4300>] [<d12c4260>] [<c0115945>] [<d12c44b4>]
   [reiserfs:__insmod_reiserfs_S.bss_L6624+11033568/350043720] [system_call+51/56]
   [<d12c4060>] [<c0106ebb>]

Code: 89 90 00 00 00 bf c3 90 57 56 83 ec 10 8b 44 24 28 8b 7c 24
 <5>NetSc520 flash device: 100000 at 200000
Failed to ioremap_nocache
SBC-GXx flash: IO:0x258-0x259 MEM:0xdc000-0xdffff
CFI: Found no SBC-GXx flash device at location zero
Could not find PAR responsible for SC520CDP Flash Bank #0
Trying default address 0x8400000
Could not find PAR responsible for SC520CDP Flash Bank #1
Trying default address 0x8c00000
Could not find PAR responsible for SC520CDP DIL Flash
Trying default address 0x9400000
SC520 CDP flash device: 800000 at 8400000
Failed to ioremap_nocache
mtd: Giving out device 0 to mtdram test device



I don't think that reiserfs (which btw is my root fs) is the culprit,
rather that it's been trampled on by the "Photron PNC-2000 flash mapping".

Ought I to take the next step, I guess to write a program along the lines
of:

for (<all modules>) {
	syslog(<module name>);
	fsync();
	modprobe(<module name>);
	fsync();
}

..?

