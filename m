Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274200AbRI3VTL>; Sun, 30 Sep 2001 17:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274206AbRI3VTD>; Sun, 30 Sep 2001 17:19:03 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:8969 "EHLO mail2.aracnet.com")
	by vger.kernel.org with ESMTP id <S274200AbRI3VSs>;
	Sun, 30 Sep 2001 17:18:48 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <rwhron@earthlink.net>, <linux-kernel@vger.kernel.org>
Subject: RE: [LTP] growfiles and other processes in "ps aux" STAT D
Date: Sun, 30 Sep 2001 14:19:13 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBMENPDNAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010930143610.A15607@earthlink.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where can I get a copy of "growfiles"??

--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.net  mailto:znmeb@aracnet.com

Q: How do you tell when a pineapple is ready to eat?
A: It picks up its knife and fork.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
> rwhron@earthlink.net
> Sent: Sunday, September 30, 2001 11:36 AM
> To: linux-kernel@vger.kernel.org
> Subject: [LTP] growfiles and other processes in "ps aux" STAT D
>
>
>
> Linux Test Project "growfiles" makes a lot of I/O processes hang in with
> "ps aux" STAT of D.  (sometimes requires reboot)
>
> This phenomenon occurs on late 2.4.9-ac1[0-8] kernels.
>
> 2.4.10 kernel on another box (laptop with ext3 filesystem, 192M
> ram) finished
> with LTP Killed with "errno=12 Cannot allocate memory".
> LTP has completed on laptop with 2.4.9-ac17.  laptop has only been tested
> 5 times in total with kernels >= 2.4.9-ac7.
>
> The rest of information below is from LTP on a thunderbird:
>
> Worst Case Symptoms (happened on at least 2 runs of 24 recent tests)
>
> growfiles "hangs" - top and "ps aux" show STAT of D
> Many new processes hang in D STAT, vi, ed, logout, su, sync.
> syslogd in D STAT.
> Other running processes, BitchX, links, vmstat, iostat continue
> working normally.
> Some commands work fine: ls, ps
> <ctrl \> and kill -9 won't kill processes in D STAT
> vmstat shows cpu 100% idle
> iostat shows 0 tps and 0 blks/s
> load average is around 4 for 1, 5, 15 minutes.
> sysreq <Sync reBoot Umount> doesn't work, but sysreq (showMem
> showTasks) does
> <ctrl alt del> doesn't reboot.
> clear with reset button if necessary.
>
> Last command executed before test had to be terminated.
> The mmap001 tests did not require reboot.
>
> 2.4.9-ac10
> mmap001
>
> 2.4.9-ac15+aging patch
> mmap001
> mmap001 -m 10000
>
> These required reboot:
>
> 2.4.9-ac17  4 completed, 1 incomplete on:
> growfiles -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 512-64000:1024
> -R 1-384000 -T 4 gf-inf-$$
>
> 2.4.9-ac18 1 incomplete run.
> growfiles -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -r 128-32768:128 -R
> 512-64000 -T 4 gfsmallio-$$
>
> I started tracking the kernel version/test results recently,
> because until Sep 23,
> the tests weren't producing alarming results.  (24 total tests
> since Aug 8 on this machine).
> The earlier LTP tests were released in April and June of 2001,
> and I didn't save those results,
> as there were no surprises.
>
>
> Distro: Linux From Scratch 3.0
> reiserfs on all filesystems.
>
>
> Hardware:
> AMD 1333mhz Thunderbird
> IWill KK266 motherboard
> 512 Mb RAM
> 40 Gb 7200 rpm 2mb cache IDE disk
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo
> Super] (rev 40)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE
> [Apollo] (rev 06)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super
> ACPI] (rev 40)
> 00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139 (rev 10)
> 00:0f.0 Multimedia audio controller: C-Media Electronics Inc
> CM8738 (rev 10)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400
> AGP (rev 04)
>
> hdparm -I /dev/hda
>
> /dev/hda:
>
>  Model=CI530L04VARE700-                        , FwRev=REO44AA1,
> SerialNo=        S 0XXSCL0734
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>  AdvancedPM=yes: disabled (255)
>  Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3
> ATA-4 ATA-5
>
>
> I removed bogus CONFIG_TOSHIBA and CONFIG*PCMCIA* settings during
> ac17 (when
> I started preparing this report.  Also removed framebuffer, drm,
> and power
> management support.
>
>
> grep ^CONFIG /usr/src/linux-2.4.9-ac18/.config
> CONFIG_X86=y
> CONFIG_ISA=y
> CONFIG_UID16=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_MODULES=y
> CONFIG_KMOD=y
> CONFIG_M586=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_X86_USE_STRING_486=y
> CONFIG_X86_ALIGNMENT_16=y
> CONFIG_NOHIGHMEM=y
> CONFIG_MTRR=y
> CONFIG_NET=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_NAMES=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_ELF=y
> CONFIG_PNP=y
> CONFIG_BLK_DEV_FD=y
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_SIZE=4096
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK=y
> CONFIG_RTNETLINK=y
> CONFIG_NETLINK_DEV=y
> CONFIG_NETFILTER=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_NF_CONNTRACK=m
> CONFIG_IP_NF_FTP=m
> CONFIG_IP_NF_QUEUE=m
> CONFIG_IP_NF_IPTABLES=m
> CONFIG_IP_NF_MATCH_LIMIT=m
> CONFIG_IP_NF_MATCH_MULTIPORT=m
> CONFIG_IP_NF_MATCH_STATE=m
> CONFIG_IP_NF_FILTER=m
> CONFIG_IP_NF_NAT=m
> CONFIG_IP_NF_NAT_NEEDED=y
> CONFIG_IP_NF_TARGET_MASQUERADE=m
> CONFIG_IP_NF_NAT_FTP=m
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_BLK_DEV_VIA82CXXX=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> CONFIG_NETDEVICES=y
> CONFIG_TUN=m
> CONFIG_ETHERTAP=m
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_PCI=y
> CONFIG_8139TOO=y
> CONFIG_PPP=y
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_UNIX98_PTY_COUNT=128
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> CONFIG_RTC=m
> CONFIG_REISERFS_FS=y
> CONFIG_FAT_FS=m
> CONFIG_MSDOS_FS=m
> CONFIG_VFAT_FS=m
> CONFIG_ISO9660_FS=m
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_EXT2_FS=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=m
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_SOUND=y
> CONFIG_SOUND_CMPCI=m
> CONFIG_SOUND_CMPCI_CM8738=y
> CONFIG_SOUND_CMPCI_SPEAKERS=2
> CONFIG_DEBUG_KERNEL=y
> CONFIG_MAGIC_SYSRQ=y
>
>
> There have been a few kernel Oops, but the most recent ones haven't
> been saveable because vi, ed, and cat >oops.txt<<!! go into D STAT.
> (The 2 oops in messages that I do have are for a kernel that isn't
> on my system anymore (2.4.9-ac15+aging)).
>
> Here they are the stack traces from /var/log/messages:
>
>
> journal-1577: handle trans id 371103 != current trans id 371104
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[reiserfs_panic+36/48]
> EFLAGS: 00010286
> eax: 00000043   ebx: c01fe940   ecx: da104000   edx: daea25a0
> esi: c18d4240   edi: 00000000   ebp: dfe57400   esp: da105b94
> ds: 0018   es: 0018   ss: 0018
> Process growfiles (pid: 445, stackpage=da105000)
> Stack: c01fc17a c0277720 c01fe940 da105bb4 da105e20 c0168292
> dfe57400 c01fe940
> 0005a99f 0005a9a0 dd157120 da105c50 da105c50 da105e7c 00000286 00000003
> e08182f0 c0159741 da105e20 dfe57400 c18d4240 dfe57400 c18d4240 00000001
> Call Trace: [journal_mark_dirty+82/760] [fix_nodes+105/1064]
> [do_journal_end+2838/2848] [reiserfs_paste_into_item+106/224]
> [reiserfs_get_block+1539/2088]
> [__block_prepare_write+167/644] [block_prepare_write+34/60]
> [reiserfs_get_block+0/2088] [reiserfs_prepare_write+92/100]
> [reiserfs_get_block+0/2088] [generic_file_write+922/1480]
> [sys_write+143/196] [system_call+51/64]
>
> Code: 0f 0b 68 20 77 27 c0 e8 a0 63 fb ff 57 56 53 8b 7c 24 10 bb
> <7>cmpci: dma timed out??
> journal-1409: journal_mark_dirty returning because j_wcount was 0
>
>
>
> journal-1577: handle trans id 420964 != current trans id 420965
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[reiserfs_panic+36/48]
> EFLAGS: 00010286
> eax: 00000043   ebx: c01fe940   ecx: db77c000   edx: dc127640
> esi: c18d4240   edi: 00000000   ebp: dfe57400   esp: db77db94
> 0018
> Process growfiles (pid: 439, stackpage=db77d000)
> Stack: c01fc17a c0277720 c01fe940 db77dbb4 db77de20 c0168292
> dfe57400 c01fe940
> 00066c64 00066c65 df3bff80 db77dc50 db77dc50 db77de7c 00000286 00000003
> e0818894 c0159741 db77de20 dfe57400 c18d4240 dfe57400 c18d4240 00000001
> Call Trace: [journal_mark_dirty+82/760] [fix_nodes+105/1064]
> [do_journal_end+2838/2848] [reiserfs_paste_into_item+106/224]
> [reiserfs_get_block+1539/2088]
> [__block_prepare_write+167/644] [block_prepare_write+34/60]
> [reiserfs_get_block+0/2088] [reiserfs_prepare_write+92/100]
> [reiserfs_get_block+0/2088] [generic_file_write+922/1480]
> [sys_write+143/196] [system_call+51/64]
>
> Code: 0f 0b 68 20 77 27 c0 e8 a0 63 fb ff 57 56 53 8b 7c 24 10 bb
>
>
> --
> Randy Hron
> = Linux - because it's all about freedom =
> Linux News at http://lwn.net/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

