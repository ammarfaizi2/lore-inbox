Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSKHQ3m>; Fri, 8 Nov 2002 11:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266732AbSKHQ3m>; Fri, 8 Nov 2002 11:29:42 -0500
Received: from rakis.net ([207.8.143.12]:55238 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S266763AbSKHQ3j>;
	Fri, 8 Nov 2002 11:29:39 -0500
Date: Fri, 8 Nov 2002 11:36:21 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: linux-kernel@vger.kernel.org
Subject: piix driver oops with 2.5.46
Message-ID: <Pine.LNX.4.42.0211081132420.1264-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I just tried using 2.5.46 with one of my machines, and recieved an oops
with the piix driver.  The machine is working without the driver
currently, but without DMA enabled (hard drives are SCSI, so this only
affects my cd-rom).

Here is the decoded oops, and an lspci from the machine.  Let me know if
there is any more info you'd like, or if I can test anything out.

00:00.0 Host bridge: Intel Corp. 82840 840 (Carmel) Chipset Host Bridge
(Hub A)
(rev 01)
00:01.0 PCI bridge: Intel Corp. 82840 840 (Carmel) Chipset AGP Bridge (rev
01)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
02:04.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)
02:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
02:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
02:09.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 (rev 01)
02:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
03:0a.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
03:0a.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)


ksymoops 2.4.7 on i686 2.5.46.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.46/ (default)
     -m /usr/src/linux-2.5.46/System.map (specified)

Warning (compare_maps): ksyms_base symbol page_states__per_cpu_R__ver_page_states__per_cpu not found in System.map.  Ignoring ksyms_base entry
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97 Audio codec, id: 0x8384:0x7609 (SigmaTel STAC9721/23)
    ide1: BM-DMA at 0xffa8-0xffaf<1>Unable to handle kernel NULL pointer dereference at virtual address 000006b4
c02630e4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c02630e4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c04d6624   ecx: c155f5c0   edx: e08aedec
esi: c04d6614   edi: 0000ffa8   ebp: 00000008   esp: d6a19dbc
ds: 0068   es: 0068   ss: 0068
Stack: 00000008 c04d6614 c04d6614 e08aedec c02631a6 c04d6614 0000ffa8 00000008
       0000ffa8 c155f400 e08ae021 c04d6614 0000ffa8 00000008 c02619e6 c04d6614
       0000ffa8 0005ee0d c04d6614 e08aee0d c15501f0 e08aedec c0261d6a c155f400
Call Trace:
 [<e08aedec>] piix_pci_info+0x150/0x330 [piix]
 [<c02631a6>] ide_setup_dma+0x16/0x2c0
 [<e08ae021>] init_dma_piix+0x11/0x20 [piix]
 [<c02619e6>] ide_hwif_setup_dma+0xc6/0x100
 [<e08aee0d>] piix_pci_info+0x171/0x330 [piix]
 [<e08aedec>] piix_pci_info+0x150/0x330 [piix]
 [<c0261d6a>] do_ide_setup_pci_device+0x24a/0x2b0
 [<e08aedec>] piix_pci_info+0x150/0x330 [piix]
 [<c0261de8>] ide_setup_pci_device+0x18/0x60
 [<e08aedec>] piix_pci_info+0x150/0x330 [piix]
 [<e08ae075>] piix_init_one+0x35/0x50 [piix]
 [<e08aedec>] piix_pci_info+0x150/0x330 [piix]
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<c01facbf>] pci_device_probe+0x3f/0x60
 [<e08af094>] piix_pci_tbl+0xc4/0x1f0 [piix]
 [<e08af1c0>] driver+0x0/0xa0 [piix]
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<c0226fc4>] bus_match+0x34/0x60
 [<c02270bf>] driver_attach+0x3f/0x80
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<c022736d>] bus_add_driver+0x5d/0x80
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<e08ae27c>] E __insmod_piix_S.text_L4176+0x121c/0x1480 [piix]
 [<e08af210>] driver+0x50/0xa0 [piix]
 [<c0227975>] driver_register+0x75/0x90
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<e08af1c0>] driver+0x0/0xa0 [piix]
 [<c01fadd6>] pci_register_driver+0x46/0x60
 [<e08af1e8>] driver+0x28/0xa0 [piix]
 [<c0261f09>] ide_pci_register_driver+0x19/0x60
 [<e08af1c0>] driver+0x0/0xa0 [piix]
 [<e08ad060>] piix_get_info+0x0/0x550 [piix]
 [<e08ae09a>] piix_ide_init+0xa/0x10 [piix]
 [<e08af1c0>] driver+0x0/0xa0 [piix]
 [<c011a275>] sys_init_module+0x535/0x620
 [<e08ad060>] piix_get_info+0x0/0x550 [piix]
 [<c010a70f>] syscall_call+0x7/0xb
Code: 8b 80 b4 06 00 00 eb 06 8d 74 26 00 89 f8 89 86 b0 06 00 00


>>EIP; c02630e4 <ide_iomio_dma+a4/110>   <=====

>>ebx; c04d6624 <ide_hwifs+7e4/4e48>
>>ecx; c155f5c0 <_end+107abcc/203c860c>
>>edx; e08aedec <[piix]piix_pci_info+150/330>
>>esi; c04d6614 <ide_hwifs+7d4/4e48>
>>esp; d6a19dbc <_end+165353c8/203c860c>

Trace; e08aedec <[piix]piix_pci_info+150/330>
Trace; c02631a6 <ide_setup_dma+16/2c0>
Trace; e08ae021 <[piix]init_dma_piix+11/20>
Trace; c02619e6 <ide_hwif_setup_dma+c6/100>
Trace; e08aee0d <[piix]piix_pci_info+171/330>
Trace; e08aedec <[piix]piix_pci_info+150/330>
Trace; c0261d6a <do_ide_setup_pci_device+24a/2b0>
Trace; e08aedec <[piix]piix_pci_info+150/330>
Trace; c0261de8 <ide_setup_pci_device+18/60>
Trace; e08aedec <[piix]piix_pci_info+150/330>
Trace; e08ae075 <[piix]piix_init_one+35/50>
Trace; e08aedec <[piix]piix_pci_info+150/330>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; c01facbf <pci_device_probe+3f/60>
Trace; e08af094 <[piix]piix_pci_tbl+c4/1f0>
Trace; e08af1c0 <[piix]driver+0/9f>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; c0226fc4 <bus_match+34/60>
Trace; c02270bf <driver_attach+3f/80>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; c022736d <bus_add_driver+5d/80>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; e08ae27c <[piix].text.end+1cd/431>
Trace; e08af210 <[piix]driver+50/9f>
Trace; c0227975 <driver_register+75/90>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; e08af1c0 <[piix]driver+0/9f>
Trace; c01fadd6 <pci_register_driver+46/60>
Trace; e08af1e8 <[piix]driver+28/9f>
Trace; c0261f09 <ide_pci_register_driver+19/60>
Trace; e08af1c0 <[piix]driver+0/9f>
Trace; e08ad060 <[piix]piix_get_info+0/20>
Trace; e08ae09a <[piix]piix_ide_init+a/10>
Trace; e08af1c0 <[piix]driver+0/9f>
Trace; c011a275 <sys_init_module+535/620>
Trace; e08ad060 <[piix]piix_get_info+0/20>
Trace; c010a70f <syscall_call+7/b>

Code;  c02630e4 <ide_iomio_dma+a4/110>
00000000 <_EIP>:
Code;  c02630e4 <ide_iomio_dma+a4/110>   <=====
   0:   8b 80 b4 06 00 00         mov    0x6b4(%eax),%eax   <=====
Code;  c02630ea <ide_iomio_dma+aa/110>
   6:   eb 06                     jmp    e <_EIP+0xe> c02630f2 <ide_iomio_dma+b2/110>
Code;  c02630ec <ide_iomio_dma+ac/110>
   8:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c02630f0 <ide_iomio_dma+b0/110>
   c:   89 f8                     mov    %edi,%eax
Code;  c02630f2 <ide_iomio_dma+b2/110>
   e:   89 86 b0 06 00 00         mov    %eax,0x6b0(%esi)


1 warning issued.  Results may not be reliable.


