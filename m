Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266316AbTAJWBP>; Fri, 10 Jan 2003 17:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbTAJWBP>; Fri, 10 Jan 2003 17:01:15 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:13983 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S266316AbTAJWBA>;
	Fri, 10 Jan 2003 17:01:00 -0500
Date: Fri, 10 Jan 2003 23:09:19 +0100
From: Magnus =?iso-8859-1?Q?M=E5nsson?= <ganja@0x63.nu>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: 2.4.21-pre3-ac2 oops
Message-ID: <20030110220919.GT7259@gagarin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
X-Scanner: exiscan *18X7L5-0005xP-00*e07sgFp68tI* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a problem while accessing one of my partitions. It started with
oopses when I was rsyncing to the partition. After that I thought that I
should run fsck and that also made my system oops.

I have the same problem with 2.4.21-pre3-ac3, but it started in -ac2.

My system is a Dell inspiron 8200 and here is my config and oops ran
through ksymoops:

---[start oops]---

ksymoops 2.4.8 on i686 2.4.21-pre3-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac3/ (default)
     -m /boot/System.map-2.4.21-pre3-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

ac97_codec: AC97 Audio codec, id: CRY91 (Unknown)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x280-0x287 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01374ed
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01374ed>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c147a510   ecx: d7c94000   edx: d7c9405c
esi: 00000000   edi: 00000000   ebp: c02b72b0   esp: d7c95dec
ds: 0018   es: 0018   ss: 0018
Process fsck.ext3 (pid: 1961, stackpage=d7c95000)
Stack: 00000001 00000286 da168580 da168580 da168580 c147a510 c0141aee da168580 
       df839428 c147a510 00004346 c02b72b0 c013667f c147a510 000001d2 d7c94000 
       00000200 000001d2 00000020 00000020 000001d2 00000020 00000006 c01368c3 
Call Trace:    [<c0141aee>] [<c013667f>] [<c01368c3>] [<c0136936>] [<c01377d7>]
  [<c0137a63>] [<c012cf1c>] [<c012d207>] [<c0118158>] [<c010d3ee>] [<c0118020>]
  [<c0107438>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bf 0f 


>>EIP; c01374ed <__free_pages_ok+27d/2a0>   <=====

>>ebx; c147a510 <_end+112f4e8/2050b038>
>>ecx; d7c94000 <_end+17948fd8/2050b038>
>>edx; d7c9405c <_end+17949034/2050b038>
>>ebp; c02b72b0 <contig_page_data+b0/340>
>>esp; d7c95dec <_end+1794adc4/2050b038>

Trace; c0141aee <try_to_free_buffers+8e/100>
Trace; c013667f <shrink_cache+21f/310>
Trace; c01368c3 <shrink_caches+63/a0>
Trace; c0136936 <try_to_free_pages_zone+36/50>
Trace; c01377d7 <balance_classzone+57/1f0>
Trace; c0137a63 <__alloc_pages+f3/190>
Trace; c012cf1c <do_anonymous_page+6c/120>
Trace; c012d207 <handle_mm_fault+77/110>
Trace; c0118158 <do_page_fault+138/4cf>
Trace; c010d3ee <old_mmap+de/120>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c0107438 <error_code+34/3c>

Code;  c01374ed <__free_pages_ok+27d/2a0>
00000000 <_EIP>:
Code;  c01374ed <__free_pages_ok+27d/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c01374f0 <__free_pages_ok+280/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c01374f2 <__free_pages_ok+282/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c01374f5 <__free_pages_ok+285/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c01374f8 <__free_pages_ok+288/2a0>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c01374fb <__free_pages_ok+28b/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c01374fe <__free_pages_ok+28e/2a0>
  11:   eb bf                     jmp    ffffffd2 <_EIP+0xffffffd2>
Code;  c0137500 <__free_pages_ok+290/2a0>
  13:   0f 00 00                  sldtl  (%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01374ed
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01374ed>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c14165c4   ecx: d7c94000   edx: d7c9405c
esi: 00000000   edi: 00000000   ebp: 00000000   esp: d7c95c10
ds: 0018   es: 0018   ss: 0018
Process fsck.ext3 (pid: 1961, stackpage=d7c95000)
Stack: 00000001 c01c1fe9 00000006 c011c53f c02bc820 c159d380 00000292 00000292 
       00000000 d8015190 00001000 00000001 c012d797 c14165c4 00000000 00000046 
       c012574b c14165c4 08400000 df1d7084 08065000 00000000 c012bfeb d8690880 
Call Trace:    [<c01c1fe9>] [<c011c53f>] [<c012d797>] [<c012574b>] [<c012bfeb>]
  [<c012eed9>] [<c011a9a7>] [<c011f88f>] [<c01079df>] [<c01182c4>] [<c01eb4a8>]
  [<c01eb686>] [<c01eb30e>] [<c01eaf30>] [<c01e6eed>] [<c0118020>] [<c0107438>]
  [<c01374ed>] [<c0141aee>] [<c013667f>] [<c01368c3>] [<c0136936>] [<c01377d7>]
  [<c0137a63>] [<c012cf1c>] [<c012d207>] [<c0118158>] [<c010d3ee>] [<c0118020>]
  [<c0107438>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bf 0f 


>>EIP; c01374ed <__free_pages_ok+27d/2a0>   <=====

>>ebx; c14165c4 <_end+10cb59c/2050b038>
>>ecx; d7c94000 <_end+17948fd8/2050b038>
>>edx; d7c9405c <_end+17949034/2050b038>
>>esp; d7c95c10 <_end+1794abe8/2050b038>

Trace; c01c1fe9 <vt_console_print+59/310>
Trace; c011c53f <__call_console_drivers+5f/70>
Trace; c012d797 <zap_pte_range+f7/120>
Trace; c012574b <run_timer_list+10b/170>
Trace; c012bfeb <zap_page_range+8b/f0>
Trace; c012eed9 <exit_mmap+b9/160>
Trace; c011a9a7 <mmput+47/a0>
Trace; c011f88f <do_exit+8f/240>
Trace; c01079df <die+7f/c0>
Trace; c01182c4 <do_page_fault+2a4/4cf>
Trace; c01eb4a8 <__ide_dma_begin+38/50>
Trace; c01eb686 <__ide_dma_count+16/20>
Trace; c01eb30e <__ide_dma_read+13e/150>
Trace; c01eaf30 <dma_timer_expiry+0/e0>
Trace; c01e6eed <do_rw_disk+1ed/6d0>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c0107438 <error_code+34/3c>
Trace; c01374ed <__free_pages_ok+27d/2a0>
Trace; c0141aee <try_to_free_buffers+8e/100>
Trace; c013667f <shrink_cache+21f/310>
Trace; c01368c3 <shrink_caches+63/a0>
Trace; c0136936 <try_to_free_pages_zone+36/50>
Trace; c01377d7 <balance_classzone+57/1f0>
Trace; c0137a63 <__alloc_pages+f3/190>
Trace; c012cf1c <do_anonymous_page+6c/120>
Trace; c012d207 <handle_mm_fault+77/110>
Trace; c0118158 <do_page_fault+138/4cf>
Trace; c010d3ee <old_mmap+de/120>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c0107438 <error_code+34/3c>

Code;  c01374ed <__free_pages_ok+27d/2a0>
00000000 <_EIP>:
Code;  c01374ed <__free_pages_ok+27d/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c01374f0 <__free_pages_ok+280/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c01374f2 <__free_pages_ok+282/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c01374f5 <__free_pages_ok+285/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c01374f8 <__free_pages_ok+288/2a0>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c01374fb <__free_pages_ok+28b/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c01374fe <__free_pages_ok+28e/2a0>
  11:   eb bf                     jmp    ffffffd2 <_EIP+0xffffffd2>
Code;  c0137500 <__free_pages_ok+290/2a0>
  13:   0f 00 00                  sldtl  (%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01374ed
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01374ed>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c147f764   ecx: d7c94000   edx: d7c9405c
esi: 00000000   edi: 00000000   ebp: 00000000   esp: d7c95a30
ds: 0018   es: 0018   ss: 0018
Process fsck.ext3 (pid: 1961, stackpage=d7c95000)
Stack: 00000001 00000286 da2ef200 da2ef200 da2ef200 c147f764 c0141aee da2ef200 
       c147f764 c14801e0 df839428 00000000 c012f2b5 c147f764 dfe46740 dfe4675c 
       df839380 c01433fb df839380 00000001 dfe46740 dfe46740 c01442fd dfe46740 
Call Trace:    [<c0141aee>] [<c012f2b5>] [<c01433fb>] [<c01442fd>] [<c013e4c2>]
  [<c013caed>] [<c011f1cc>] [<c011f8ae>] [<c0118020>] [<c01079df>] [<c01182c4>]
  [<c01379bb>] [<c0118020>] [<c0107438>] [<c01374ed>] [<c01c1fe9>] [<c011c53f>]
  [<c012d797>] [<c012574b>] [<c012bfeb>] [<c012eed9>] [<c011a9a7>] [<c011f88f>]
  [<c01079df>] [<c01182c4>] [<c01eb4a8>] [<c01eb686>] [<c01eb30e>] [<c01eaf30>]
  [<c01e6eed>] [<c0118020>] [<c0107438>] [<c01374ed>] [<c0141aee>] [<c013667f>]
  [<c01368c3>] [<c0136936>] [<c01377d7>] [<c0137a63>] [<c012cf1c>] [<c012d207>]
  [<c0118158>] [<c010d3ee>] [<c0118020>] [<c0107438>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bf 0f 


>>EIP; c01374ed <__free_pages_ok+27d/2a0>   <=====

>>ebx; c147f764 <_end+113473c/2050b038>
>>ecx; d7c94000 <_end+17948fd8/2050b038>
>>edx; d7c9405c <_end+17949034/2050b038>
>>esp; d7c95a30 <_end+1794aa08/2050b038>

Trace; c0141aee <try_to_free_buffers+8e/100>
Trace; c012f2b5 <invalidate_inode_pages+75/90>
Trace; c01433fb <kill_bdev+1b/50>
Trace; c01442fd <blkdev_put+ad/d0>
Trace; c013e4c2 <fput+102/130>
Trace; c013caed <filp_close+4d/80>
Trace; c011f1cc <put_files_struct+6c/e0>
Trace; c011f8ae <do_exit+ae/240>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c01079df <die+7f/c0>
Trace; c01182c4 <do_page_fault+2a4/4cf>
Trace; c01379bb <__alloc_pages+4b/190>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c0107438 <error_code+34/3c>
Trace; c01374ed <__free_pages_ok+27d/2a0>
Trace; c01c1fe9 <vt_console_print+59/310>
Trace; c011c53f <__call_console_drivers+5f/70>
Trace; c012d797 <zap_pte_range+f7/120>
Trace; c012574b <run_timer_list+10b/170>
Trace; c012bfeb <zap_page_range+8b/f0>
Trace; c012eed9 <exit_mmap+b9/160>
Trace; c011a9a7 <mmput+47/a0>
Trace; c011f88f <do_exit+8f/240>
Trace; c01079df <die+7f/c0>
Trace; c01182c4 <do_page_fault+2a4/4cf>
Trace; c01eb4a8 <__ide_dma_begin+38/50>
Trace; c01eb686 <__ide_dma_count+16/20>
Trace; c01eb30e <__ide_dma_read+13e/150>
Trace; c01eaf30 <dma_timer_expiry+0/e0>
Trace; c01e6eed <do_rw_disk+1ed/6d0>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c0107438 <error_code+34/3c>
Trace; c01374ed <__free_pages_ok+27d/2a0>
Trace; c0141aee <try_to_free_buffers+8e/100>
Trace; c013667f <shrink_cache+21f/310>
Trace; c01368c3 <shrink_caches+63/a0>
Trace; c0136936 <try_to_free_pages_zone+36/50>
Trace; c01377d7 <balance_classzone+57/1f0>
Trace; c0137a63 <__alloc_pages+f3/190>
Trace; c012cf1c <do_anonymous_page+6c/120>
Trace; c012d207 <handle_mm_fault+77/110>
Trace; c0118158 <do_page_fault+138/4cf>
Trace; c010d3ee <old_mmap+de/120>
Trace; c0118020 <do_page_fault+0/4cf>
Trace; c0107438 <error_code+34/3c>

Code;  c01374ed <__free_pages_ok+27d/2a0>
00000000 <_EIP>:
Code;  c01374ed <__free_pages_ok+27d/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c01374f0 <__free_pages_ok+280/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c01374f2 <__free_pages_ok+282/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c01374f5 <__free_pages_ok+285/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c01374f8 <__free_pages_ok+288/2a0>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c01374fb <__free_pages_ok+28b/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c01374fe <__free_pages_ok+28e/2a0>
  11:   eb bf                     jmp    ffffffd2 <_EIP+0xffffffd2>
Code;  c0137500 <__free_pages_ok+290/2a0>
  13:   0f 00 00                  sldtl  (%eax)


1 warning issued.  Results may not be reliable.

---[end oops]---

---[start config]---

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MPENTIUM4=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_CPU_FREQ=y
CONFIG_X86_SPEEDSTEP=m
CONFIG_I8K=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_PCMCIA=y
CONFIG_CARDBUS=y
CONFIG_I82092=y
CONFIG_I82365=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_IKCONFIG=y
CONFIG_PM=y
CONFIG_APM=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PNP=y
CONFIG_PNPBIOS=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_STATS=y
CONFIG_CRYPTO=y
CONFIG_CIPHERS=y
CONFIG_CIPHER_BLOWFISH=m
CONFIG_DIGESTS=y
CONFIG_DIGEST_MD5=y
CONFIG_DIGEST_SHA1=y
CONFIG_DIGEST_RIPEMD160=y
CONFIG_DIGEST_SHA256=y
CONFIG_DIGEST_SHA384=y
CONFIG_DIGEST_SHA512=y
CONFIG_CRYPTODEV=y
CONFIG_CRYPTOLOOP=m
CONFIG_CRYPTOLOOP_IV_HACK=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_UNIX=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_PIIX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_ETHERTAP=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_NET_RADIO=y
CONFIG_HERMES=m
CONFIG_PCMCIA_HERMES=m
CONFIG_NET_WIRELESS=y
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_IRDA=m
CONFIG_IRCOMM=m
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_EVDEV=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_BUSMOUSE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_INPUT_SERIO=y
CONFIG_INTEL_RNG=m
CONFIG_NVRAM=m
CONFIG_RTC=y
CONFIG_DTLK=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m
CONFIG_PCMCIA_SERIAL_CS=y
CONFIG_PCMCIA_CHRDEV=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_PROC_INFO=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_JFS_FS=y
CONFIG_JFS_STATISTICS=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=m
CONFIG_FB_VIRTUAL=m
CONFIG_FBCON_MFB=m
CONFIG_FBCON_CFB2=m
CONFIG_FBCON_CFB4=m
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
CONFIG_FBCON_MAC=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=y
CONFIG_SOUND_ICH=y
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_AUDIO=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_BLUEZ=y
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_RFCOMM=m
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=m
CONFIG_BLUEZ_HCIUSB=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_PANIC_MORSE=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--[end config]---

-- 
Magnus Månsson
