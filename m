Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315803AbSEEBIn>; Sat, 4 May 2002 21:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315804AbSEEBIm>; Sat, 4 May 2002 21:08:42 -0400
Received: from jalon.able.es ([212.97.163.2]:33186 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315803AbSEEBIj>;
	Sat, 4 May 2002 21:08:39 -0400
Date: Sun, 5 May 2002 03:08:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andre Hedrick <andre@linux-ide.org>
Subject: ide-convert-[89] oops (decoded) on boot
Message-ID: <20020505010833.GA1723@werewolf.able.es>
In-Reply-To: <20020504022433.GA1803@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.04 J.A. Magallon wrote:
>Hi.
>
>Just patched pre8 with ide-convert-9, and system hangs on boot:
>
>PIIX4: IDE controller on PCI bus 00 dev 39
>PIIX4: chipset revision 1
>PIIX4: not 100% native mode: will probe irqs later
>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
>    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
>hda: Conner Peripherals 1080MB - CFS1081A, ATA DISK drive
>hdb: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
>hdc: YAMAHA CRW8424E, ATAPI CD/DVD-ROM drive
>hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
>
><=======0 OOPS here, just got hung...
> <usual output follows >
>hda: 2114180 sectors (1082 MB), CHS=524/64/63, DMA
>ide-cd: passing drive hdb to ide-scsi emulation.
>ide-cd: passing drive hdc to ide-scsi emulation.
>ide-floppy driver 0.99.newide

convert.8 also hangs. convert.6 worked in my latest 2.4.19-pre7-jam6.
Now I'm building -pre8-jam1, and the jump from convert.6 to convert.9
does not work. Bott is fine without the patch, with included ide.
Only option yet to be tested is convert.7...

Decoded oops:

ksymoops 2.4.5 on i686 2.4.19-pre7-jam9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre8-jam1/ (specified)
     -m /boot/System.map-2.4.19-pre8-jam1 (specified)

[ton of warnings about ksyms mismatchs...]

Unable to handle kernel NULL pointer derefernce at virtual address 00000040
c01cd2d7
*pde = 000000000
Oops: 0000
CPU: 1
EIP: 0010:[<c01cd2d7>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000000 ebx: c0376f40 ecx: c01d4010 edx: 00000020
esi: c0376f84 edi: 00000007 ebp: 0008e000 esp: c15b5f38
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, stackpage=c15b5000)
c0288031 c0165de1 dfe549a0 00000000 0000004c c02ad1f0 00000001 c01cd2b0
c0376f84 c02ad2a0 0008e000 c01cc19f 00000007 c0376f84 c0376f40 c0376f84
00000001 c0105000 c01d4064 c0376f84 c02ad2a0 00000001 00000000 c0376f40
[<c0165de1>]
[<c01cd2b0>]
[<c01cc19f>]
[<c0105000>]
[<c01d4064>]
[<c010508b>]
[<c0105000>]
[<c010758d>]
Code: 8b 40 40 89 44 24 18 8b ab 2c 03 00 0f b6 86 c4 00 00 00


>>EIP; c01cd2d7 <ide_dmaproc+27/370>   <=====

>>ebx; c0376f40 <ide_hwifs+0/2238>
>>ecx; c01d4010 <idedisk_init+0/130>
>>esi; c0376f84 <ide_hwifs+44/2238>
>>ebp; 0008e000 Before first symbol
>>esp; c15b5f38 <_end+12305e4/204a86ac>

Code;  c01cd2d7 <ide_dmaproc+27/370>
00000000 <_EIP>:
Code;  c01cd2d7 <ide_dmaproc+27/370>   <=====
   0:   8b 40 40                  mov    0x40(%eax),%eax   <=====
Code;  c01cd2da <ide_dmaproc+2a/370>
   3:   89 44 24 18               mov    %eax,0x18(%esp,1)
Code;  c01cd2de <ide_dmaproc+2e/370>
   7:   8b ab 2c 03 00 0f         mov    0xf00032c(%ebx),%ebp
Code;  c01cd2e4 <ide_dmaproc+34/370>
   d:   b6 86                     mov    $0x86,%dh
Code;  c01cd2e6 <ide_dmaproc+36/370>
   f:   c4 00                     les    (%eax),%eax

<0> Kernel panic: Attempted to kill init !

1211 warnings issued.  Results may not be reliable.

Hope this helps...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam1 #3 SMP dom may 5 02:28:08 CEST 2002 i686
