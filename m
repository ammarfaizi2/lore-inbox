Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313769AbSDZKE6>; Fri, 26 Apr 2002 06:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSDZKE5>; Fri, 26 Apr 2002 06:04:57 -0400
Received: from CPE0050dab695fb.cpe.net.cable.rogers.com ([24.157.44.122]:50694
	"EHLO merlin.maincube.net") by vger.kernel.org with ESMTP
	id <S313769AbSDZKE4>; Fri, 26 Apr 2002 06:04:56 -0400
Date: Fri, 26 Apr 2002 06:04:56 -0400
From: David Priban <david@maincube.net>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.18 panic with faulty tape cartridge
Message-ID: <20020426060456.A18023@merlin.maincube.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
I have a machine with ATAPI tape drive Seagate STT8000A, firmware 5.51. Everything works
fine with ide-scsi and st modules until I load a tape cartridge which is (most likely)
faulty. After numerous retries drive goes off-line and machine dies with kernel panic.
Snippet of syslog:
scsi : aborting command due to timeout : pid 13981, scsi0, channel 0, id 0, lun 0 0x0a 01 00 00 20 0
0
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status timeout: status=0xc0 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete

And then comes this:

Unable to handle kernel paging request at virtual address 1b1a1930
c88594c9
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c88594c9>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000051   ebx: c12a0000   ecx: c0288930   edx: 00000177
esi: c7f857c0   edi: 1b1a1918   ebp: c0288970   esp: c0231f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0231000)
Stack: c0288970 c7faa160 00000296 c0288930 00000002 c0288951 c017bb87 c0288970
       c1205960 04000001 0000000f c0231fa8 c8859458 c0107d0f 0000000f c7faa160
       c0231fa8 000001e0 c0262ae0 0000000f c0231fa0 c0107e76 0000000f c0231fa8
Call Trace: [<c017bb87>] [<c8859458>] [<c0107d0f>] [<c0107e76>] [<c0105150>]
   [<c0105150>] [<c0109d58>] [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d9>]
   [<c0105000>] [<c0105027>]
Code: ff 47 18 8b 85 c8 00 00 00 8b 40 04 50 6a 01 e8 3b fd ff ff

>>EIP; c88594c8 <[ide-scsi]idescsi_pc_intr+70/230>   <=====
Trace; c017bb86 <ide_intr+fa/150>
Trace; c8859458 <[ide-scsi]idescsi_pc_intr+0/230>
Trace; c0107d0e <handle_IRQ_event+2e/58>
Trace; c0107e76 <do_IRQ+6a/a8>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0109d58 <call_do_IRQ+6/e>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  c88594c8 <[ide-scsi]idescsi_pc_intr+70/230>
00000000 <_EIP>:
Code;  c88594c8 <[ide-scsi]idescsi_pc_intr+70/230>   <=====
   0:   ff 47 18                  incl   0x18(%edi)   <=====
Code;  c88594ca <[ide-scsi]idescsi_pc_intr+72/230>
   3:   8b 85 c8 00 00 00         mov    0xc8(%ebp),%eax
Code;  c88594d0 <[ide-scsi]idescsi_pc_intr+78/230>
   9:   8b 40 04                  mov    0x4(%eax),%eax
Code;  c88594d4 <[ide-scsi]idescsi_pc_intr+7c/230>
   c:   50                        push   %eax
Code;  c88594d4 <[ide-scsi]idescsi_pc_intr+7c/230>
   d:   6a 01                     push   $0x1
Code;  c88594d6 <[ide-scsi]idescsi_pc_intr+7e/230>
   f:   e8 3b fd ff ff            call   fffffd4f <_EIP+0xfffffd4f> c8859216 <[ide-scsi]hexdump+4a/4
c>

 <0>Kernel panic: Aiee, killing interrupt handler!


Machine is PIII-450. I'm not sure about MB make but will find out if needed.
Kernel is plain 2.4.18. SCSI support is compiled in the kernel, ide-scsi and st
are modules. From syslog:

Apr 26 02:52:49 ad-server kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
Apr 26 02:52:49 ad-server kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
Apr 26 02:52:49 ad-server kernel: PIIX4: IDE controller on PCI bus 00 dev 39
Apr 26 02:52:49 ad-server kernel: PIIX4: chipset revision 1
Apr 26 02:52:49 ad-server kernel: PIIX4: not 100%% native mode: will probe irqs later
Apr 26 02:52:49 ad-server kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Apr 26 02:52:49 ad-server kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Apr 26 02:52:49 ad-server kernel: hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
Apr 26 02:52:49 ad-server kernel: hdb: WDC AC14300R, ATA DISK drive
Apr 26 02:52:49 ad-server kernel: hdc: Seagate STT8000A, ATAPI TAPE drive
Apr 26 02:52:49 ad-server kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 26 02:52:49 ad-server kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr 26 02:52:49 ad-server kernel: hda: 40132503 sectors (20548 MB) w/1902KiB Cache, CHS=2498/255/63,
 UDMA(25)
Apr 26 02:52:49 ad-server kernel: hdb: 8421840 sectors (4312 MB) w/512KiB Cache, CHS=524/255/63, UDM
A(25)
Apr 26 02:52:49 ad-server kernel: Partition check:
Apr 26 02:52:49 ad-server kernel:  hda: hda1
Apr 26 02:52:49 ad-server kernel:  hdb: hdb1 hdb2 hdb3

If anybody knows fix for this problem, please let me know.
Thanks

David Priban
