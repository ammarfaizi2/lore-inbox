Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbSKFXg2>; Wed, 6 Nov 2002 18:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266223AbSKFXg2>; Wed, 6 Nov 2002 18:36:28 -0500
Received: from ifup.net ([217.160.130.191]:12174 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id <S266221AbSKFXgT>;
	Wed, 6 Nov 2002 18:36:19 -0500
Date: Thu, 7 Nov 2002 00:43:13 +0100
From: Karsten Desler <soohrt@soohrt.org>
To: mingo@redhat.com, neilb@cse.unsw.edu.au
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: OOPS: 2.4.19 md raid5
Message-ID: <20021106234313.GA17826@soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A few minutes ago I got a Kernel OOPS on my fileserver while it
was serving 'Return of the Jedi' from a 8x80gb raid5 via samba to a
Windows 2000 client.

It's a vanilla 2.4.19 kernel.

I reported a slightly different OOPS 2 month ago, but it wasn't fixed
(at least I didn't notice). After changing one IDE Controller and the
RAM it ran ok until today.

ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (specified)
     -m /boot/System.old (specified)

Nov  6 22:56:25 pikelot kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000003
Nov  6 22:56:25 pikelot kernel: c0195cf1
Nov  6 22:56:25 pikelot kernel: *pde = 00000000
Nov  6 22:56:25 pikelot kernel: Oops: 0002
Nov  6 22:56:25 pikelot kernel: CPU:    0
Nov  6 22:56:25 pikelot kernel: EIP:    0010:[<c0195cf1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  6 22:56:25 pikelot kernel: EFLAGS: 00010086
Nov  6 22:56:25 pikelot kernel: eax: ffffffff   ebx: c15b5c00   ecx: df9f6000   edx: dfe693b8
Nov  6 22:56:25 pikelot kernel: esi: df9f6000   edi: 00000000   ebp: db5204c0   esp: d2abfdd8
Nov  6 22:56:25 pikelot kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 22:56:25 pikelot kernel: Process smbd (pid: 13473, stackpage=d2abf000)
Nov  6 22:56:25 pikelot kernel: Stack: c0195d40 df9f6000 c15b5c00 00000000 c0196199 c15b5c00 c15b5c00 00000000
Nov  6 22:56:25 pikelot kernel:        00000000 db5204c0 c15b5c00 00000000 d2abe000 00001000 00000048 00000080
Nov  6 22:56:25 pikelot kernel:        c0198062 14c1aa48 c0198074 c15b5c00 02f71848 00001000 00000000 db5204c0
Nov  6 22:56:25 pikelot kernel: Call Trace:    [<c0195d40>] [<c0196199>] [<c0198062>] [<c0198074>] [<c019b2f8>]
Nov  6 22:56:25 pikelot kernel:   [<c017f19c>] [<c017f1fe>] [<c0133dc0>] [<c012cae0>] [<c0125c4c>] [<c0152ddf>]
Nov  6 22:56:25 pikelot kernel:   [<c01522b0>] [<c0125cf5>] [<c0126315>] [<c0126522>] [<c0126a75>] [<c0126960>]
Nov  6 22:56:25 pikelot kernel:   [<c01315c6>] [<c01086db>]
Nov  6 22:56:25 pikelot kernel: Code: 89 50 04 8b 51 04 8b 01 89 02 c7 41 04 00 00 00 00 c3 8d b6

>>EIP; c0195cf1 <remove_hash+11/30>   <=====

>>ebx; c15b5c00 <_end+132b80c/20582c6c>
>>ecx; df9f6000 <_end+1f76bc0c/20582c6c>
>>edx; dfe693b8 <_end+1fbdefc4/20582c6c>
>>esi; df9f6000 <_end+1f76bc0c/20582c6c>
>>ebp; db5204c0 <_end+1b2960cc/20582c6c>
>>esp; d2abfdd8 <_end+128359e4/20582c6c>

Trace; c0195d40 <get_free_stripe+30/50>
Trace; c0196199 <get_active_stripe+259/500>
Trace; c0198062 <raid5_make_request+42/100>
Trace; c0198074 <raid5_make_request+54/100>
Trace; c019b2f8 <md_make_request+38/70>
Trace; c017f19c <generic_make_request+11c/130>
Trace; c017f1fe <submit_bh+4e/70>
Trace; c0133dc0 <block_read_full_page+200/220>
Trace; c012cae0 <__alloc_pages+40/170>
Trace; c0125c4c <add_to_page_cache_unique+6c/80>
Trace; c0152ddf <ext3_readpage+f/20>
Trace; c01522b0 <ext3_get_block+0/70>
Trace; c0125cf5 <page_cache_read+95/c0>
Trace; c0126315 <generic_file_readahead+105/140>
Trace; c0126522 <do_generic_file_read+1a2/400>
Trace; c0126a75 <generic_file_read+85/140>
Trace; c0126960 <file_read_actor+0/90>
Trace; c01315c6 <sys_read+96/f0>
Trace; c01086db <system_call+33/38>

Code;  c0195cf1 <remove_hash+11/30>
00000000 <_EIP>:
Code;  c0195cf1 <remove_hash+11/30>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0195cf4 <remove_hash+14/30>
   3:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c0195cf7 <remove_hash+17/30>
   6:   8b 01                     mov    (%ecx),%eax
Code;  c0195cf9 <remove_hash+19/30>
   8:   89 02                     mov    %eax,(%edx)
Code;  c0195cfb <remove_hash+1b/30>
   a:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c0195d02 <remove_hash+22/30>
  11:   c3                        ret
Code;  c0195d03 <remove_hash+23/30>
  12:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

Nov  6 23:06:49 pikelot kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 0000022f
Nov  6 23:06:49 pikelot kernel: c0195f20
Nov  6 23:06:49 pikelot kernel: *pde = 00000000
Nov  6 23:06:49 pikelot kernel: Oops: 0000
Nov  6 23:06:49 pikelot kernel: CPU:    0
Nov  6 23:06:49 pikelot kernel: EIP:    0010:[<c0195f20>]    Not tainted
Nov  6 23:06:49 pikelot kernel: EFLAGS: 00010086
Nov  6 23:06:49 pikelot kernel: eax: ffffffff   ebx: 00000008   ecx: 02fee770   edx: 00000000
Nov  6 23:06:49 pikelot kernel: esi: c15b5c00   edi: 000000ee   ebp: d2cdcc40   esp: dafcfdd8
Nov  6 23:06:49 pikelot kernel: ds: 0018   es: 0018   ss: 0018
Nov  6 23:06:49 pikelot kernel: Process smbd (pid: 4406, stackpage=dafcf000)
Nov  6 23:06:49 pikelot kernel: Stack: c15b5c00 00000000 00000000 c0196179 c15b5c00 02fee770 c15b5c00 00000000
Nov  6 23:06:49 pikelot kernel:        00000000 d2cdcc40 c15b5c00 00000000 dafce000 00001000 00000070 00000080
Nov  6 23:06:49 pikelot kernel:        c0198062 14f85370 c0198074 c15b5c00 02fee770 00001000 00000000 d2cdcc40
Nov  6 23:06:49 pikelot kernel: Call Trace:    [<c0196179>] [<c0198062>] [<c0198074>] [<c019b2f8>] [<c017f19c>]
Nov  6 23:06:49 pikelot kernel:   [<c017f1fe>] [<c0133dc0>] [<c012cae0>] [<c0125c4c>] [<c0152ddf>] [<c01522b0>]
Nov  6 23:06:49 pikelot kernel:   [<c0125cf5>] [<c0126315>] [<c0126522>] [<c0126a75>] [<c0126960>] [<c01315c6>]
Nov  6 23:06:49 pikelot kernel:   [<c01086db>]
Nov  6 23:06:49 pikelot kernel: Code: 39 88 30 02 00 00 74 08 8b 00 85 c0 75 f2 31 c0 5b 5e 5f c3


>>EIP; c0195f20 <__find_stripe+30/50>   <=====

>>esi; c15b5c00 <_end+132b80c/20582c6c>
>>ebp; d2cdcc40 <_end+12a5284c/20582c6c>
>>esp; dafcfdd8 <_end+1ad459e4/20582c6c>

Trace; c0196179 <get_active_stripe+239/500>
Trace; c0198062 <raid5_make_request+42/100>
Trace; c0198074 <raid5_make_request+54/100>
Trace; c019b2f8 <md_make_request+38/70>
Trace; c017f19c <generic_make_request+11c/130>
Trace; c017f1fe <submit_bh+4e/70>
Trace; c0133dc0 <block_read_full_page+200/220>
Trace; c012cae0 <__alloc_pages+40/170>
Trace; c0125c4c <add_to_page_cache_unique+6c/80>
Trace; c0152ddf <ext3_readpage+f/20>
Trace; c01522b0 <ext3_get_block+0/70>
Trace; c0125cf5 <page_cache_read+95/c0>
Trace; c0126315 <generic_file_readahead+105/140>
Trace; c0126522 <do_generic_file_read+1a2/400>
Trace; c0126a75 <generic_file_read+85/140>
Trace; c0126960 <file_read_actor+0/90>
Trace; c01315c6 <sys_read+96/f0>
Trace; c01086db <system_call+33/38>

Code;  c0195f20 <__find_stripe+30/50>
00000000 <_EIP>:
Code;  c0195f20 <__find_stripe+30/50>   <=====
   0:   39 88 30 02 00 00         cmp    %ecx,0x230(%eax)   <=====
Code;  c0195f26 <__find_stripe+36/50>
   6:   74 08                     je     10 <_EIP+0x10> c0195f30 <__find_stripe+40/50>
Code;  c0195f28 <__find_stripe+38/50>
   8:   8b 00                     mov    (%eax),%eax
Code;  c0195f2a <__find_stripe+3a/50>
   a:   85 c0                     test   %eax,%eax
Code;  c0195f2c <__find_stripe+3c/50>
   c:   75 f2                     jne    0 <_EIP>
Code;  c0195f2e <__find_stripe+3e/50>
   e:   31 c0                     xor    %eax,%eax
Code;  c0195f30 <__find_stripe+40/50>
  10:   5b                        pop    %ebx
Code;  c0195f31 <__find_stripe+41/50>
  11:   5e                        pop    %esi
Code;  c0195f32 <__find_stripe+42/50>
  12:   5f                        pop    %edi
Code;  c0195f33 <__find_stripe+43/50>
  13:   c3                        ret

-------------------------------------
/proc/version:
Linux version 2.4.19 (root@pikelot) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Fri Sep 20 23:42:34 CEST 2002

-------------------------------------
ver_linux:
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.30-WIP
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    60:
Sh-utils               4.5.2
Modules Loaded         tun 3c59x


-------------------------------------
dmesg (shortened):
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
HPT370: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide4: BM-DMA at 0xc400-0xc407, BIOS settings: hdi:DMA, hdj:DMA
    ide5: BM-DMA at 0xc408-0xc40f, BIOS settings: hdk:DMA, hdl:DMA
hda: IBM-DPTA-372050, ATA DISK drive
hdc: MAXTOR 4K080H4, ATA DISK drive
hdd: WDC WD800AB-00CBA0, ATA DISK drive
hde: MAXTOR 4K080H4, ATA DISK drive
hdf: MAXTOR 4K080H4, ATA DISK drive
hdi: MAXTOR 4K080H4, ATA DISK drive
hdj: WDC WD800AB-00CBA0, ATA DISK drive
hdk: MAXTOR 4K080H4, ATA DISK drive
hdl: WDC WD800AB-00CBA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa000-0xa007,0xa402 on irq 10
ide4 at 0xb400-0xb407,0xb802 on irq 11
ide5 at 0xbc00-0xbc07,0xc002 on irq 11
hda: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=2495/255/63, UDMA(33)
hdc: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hde: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
hdf: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
hdi: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
hdj: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
hdk: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63, UDMA(100)
hdl: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdc: hdc1
 hdd: hdd1
 hde: hde1
 hdf: hdf1
 hdi: hdi1
 hdj: hdj1
 hdk: hdk1
 hdl: hdl1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1298.800 MB/sec
   32regs    :  1144.400 MB/sec
   pII_mmx   :  1985.600 MB/sec
   p5_mmx    :  2543.200 MB/sec
raid5: using function: p5_mmx (2543.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
 [events: 00000020]
md: autorun ...
md: considering hdl1 ...
md:  adding hdl1 ...
md:  adding hdk1 ...
md:  adding hdj1 ...
md:  adding hdi1 ...
md:  adding hdf1 ...
md:  adding hde1 ...
md:  adding hdd1 ...
md:  adding hdc1 ...
md: created md0
md: bind<hdc1,1>
md: bind<hdd1,2>
md: bind<hde1,3>
md: bind<hdf1,4>
md: bind<hdi1,5>
md: bind<hdj1,6>
md: bind<hdk1,7>
md: bind<hdl1,8>
md: running: <hdl1><hdk1><hdj1><hdi1><hdf1><hde1><hdd1><hdc1>
md: hdl1's event counter: 00000020
md: hdk1's event counter: 00000020
md: hdj1's event counter: 00000020
md: hdi1's event counter: 00000020
md: hdf1's event counter: 00000020
md: hde1's event counter: 00000020
md: hdd1's event counter: 00000020
md: hdc1's event counter: 00000020
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 1792k
md0: 7 data-disks, max readahead per data-disk: 256k
raid5: device hdl1 operational as raid disk 7
raid5: device hdk1 operational as raid disk 6
raid5: device hdj1 operational as raid disk 5
raid5: device hdi1 operational as raid disk 4
raid5: device hdf1 operational as raid disk 3
raid5: device hde1 operational as raid disk 2
raid5: device hdd1 operational as raid disk 1
raid5: device hdc1 operational as raid disk 0
raid5: allocated 8531kB for md0
raid5: raid level 5 set md0 active with 8 out of 8 devices, algorithm 2
raid5: raid set md0 not clean; reconstructing parity
RAID5 conf printout:
 --- rd:8 wd:8 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdc1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdd1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hde1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdf1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdi1
 disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdj1
 disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdk1
 disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hdl1
RAID5 conf printout:
 --- rd:8 wd:8 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hdc1
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdd1
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:hde1
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:hdf1
 disk 4, s:0, o:1, n:4 rd:4 us:1 dev:hdi1
 disk 5, s:0, o:1, n:5 rd:5 us:1 dev:hdj1
 disk 6, s:0, o:1, n:6 rd:6 us:1 dev:hdk1
 disk 7, s:0, o:1, n:7 rd:7 us:1 dev:hdl1
md: updating md0 RAID superblock on device
md: hdl1 [events: 00000021]<6>(write) hdl1's sb offset: 78150592
md: syncing RAID array md0
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec/disc.
md: using maximum available idle IO bandwith (but not more than 100000
KB/sec) for reconstruction.
md: using 124k window, over a total of 78150592 blocks.
md: hdk1 [events: 00000021]<6>(write) hdk1's sb offset: 78150592
spurious 8259A interrupt: IRQ7.
md: hdj1 [events: 00000021]<6>(write) hdj1's sb offset: 78150592
md: hdi1 [events: 00000021]<6>(write) hdi1's sb offset: 78150592
md: hdf1 [events: 00000021]<6>(write) hdf1's sb offset: 78150592
md: hde1 [events: 00000021]<6>(write) hde1's sb offset: 78150592
md: hdd1 [events: 00000021]<6>(write) hdd1's sb offset: 78150592
md: hdc1 [events: 00000021]<6>(write) hdc1's sb offset: 78150592
md: ... autorun DONE.
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096

-------------------------------------
The full output of dmesg, lspci, /proc/(cpuinfo,modules,ioports,iomem,
mdstat), .config.
can be found here: http://www.soohrt.org/stuff/linux/panic2/index.html

Thanks in advance,
 Karsten
