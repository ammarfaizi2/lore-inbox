Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSHRVGf>; Sun, 18 Aug 2002 17:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSHRVGf>; Sun, 18 Aug 2002 17:06:35 -0400
Received: from fep01-svc.mail.telepac.pt ([194.65.5.200]:12245 "EHLO
	fep01-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id <S316161AbSHRVGe>; Sun, 18 Aug 2002 17:06:34 -0400
Date: Sun, 18 Aug 2002 22:10:53 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Complete system freeze with "linux-2.4.19-ac4"
Message-ID: <20020818211053.GA758@hobbes.itsari.int>
References: <20020818160126.GA1696@steffen-moser.de> <1029688481.1837.14.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1029688481.1837.14.camel@phantasy>; from rml@tech9.net on Sun, Aug 18, 2002 at 17:34:40 +0100
X-Mailer: Balsa 1.3.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.02 17:34 Robert Love wrote:
> 
> Alan might be able to say better (e.g. this is a known problem) but I
> would suggest trying to reproduce this on the latest 2.4-ac, which at
> the moment is 2.4.20-pre2-ac3... much IDE work is ongoing.
> 


Hi,

I was able to reproduce the problem described by Steffen Moser with
2.4.20-pre2-ac3+rmap14.

The decoded Oops is below (it was hand written onto paper, as magic
sysrq wouldnt work -- i mean, it _would_ work, but any key combination
apart from alt-sysrq-b would generate _another_ oops)

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio

[...]

hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12

The kernel was built with gcc 3.2 (mandrake-cooker packages).

ksymoops 2.4.5 on i686 2.4.20-pre2-ac3.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20-pre2-ac3/ (default)
      -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not 
found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 
00000024
c01a0f70
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01a0f70>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000  ebx: c142be5c  ecx: c1425200  edx: 00000170
esi: c01a33e0  edi: c02a33c0  ebp: c0245f38  esp: c0245f28
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 0, stackpage=c0245000)
Stack: c02a33e0 00000001 c0244000 c11d5160 c0245f5c c01a49ff c02a33e0 
c010a0ea0
        c02a3330 00000296 c10ef800 04000001 c0245fac c0245f7c c01085f7 
00000000f
        c11d5160 c0245fac c0244000 c027eae0 0000000f c0245fa4 c010882f 
00000000f
Call Trace:    [<c01a49ff>] [<c01a0ea0>] [<c01085f7>] [<c010882f>] 
[<c0105000>]
   [<c010afa3>] [<c0105390>] [<c0105000>] [<c01053b4>] [<c0105403>]
Code: ff 50 24 5a 31 d2 59 85 c0 0f 84 78 ff ff ff eb b4 8b 43 24


>> EIP; c01a0f70 <task_in_intr+d0/100>   <=====

>> ebx; c142be5c <_end+117f348/46034ec>
>> ecx; c1425200 <_end+11786ec/46034ec>
>> esi; c01a33e0 <ide_end_drive_cmd+180/370>
>> edi; c02a33c0 <ide_hwifs+500/2c60>
>> ebp; c0245f38 <init_task_union+1f38/2000>
>> esp; c0245f28 <init_task_union+1f28/2000>

Trace; c01a49ff <ide_intr+ff/1c0>
Trace; c01a0ea0 <task_in_intr+0/100>
Trace; c01085f7 <handle_IRQ_event+37/70>
Trace; c010882f <do_IRQ+9f/110>
Trace; c0105000 <_stext+0/0>
Trace; c010afa3 <IRQ0x00_interrupt+3/10>
Trace; c0105390 <default_idle+0/30>
Trace; c0105000 <_stext+0/0>
Trace; c01053b4 <default_idle+24/30>
Trace; c0105403 <cpu_idle+23/40>

Code;  c01a0f70 <task_in_intr+d0/100>
00000000 <_EIP>:
Code;  c01a0f70 <task_in_intr+d0/100>   <=====
    0:   ff 50 24                  call   *0x24(%eax)   <=====
Code;  c01a0f73 <task_in_intr+d3/100>
    3:   5a                        pop    %edx
Code;  c01a0f74 <task_in_intr+d4/100>
    4:   31 d2                     xor    %edx,%edx
Code;  c01a0f76 <task_in_intr+d6/100>
    6:   59                        pop    %ecx
Code;  c01a0f77 <task_in_intr+d7/100>
    7:   85 c0                     test   %eax,%eax
Code;  c01a0f79 <task_in_intr+d9/100>
    9:   0f 84 78 ff ff ff         je     ffffff87 <_EIP+0xffffff87> 
c01a0ef7 <task_in_intr+57/100>
Code;  c01a0f7f <task_in_intr+df/100>
    f:   eb b4                     jmp    ffffffc5 <_EIP+0xffffffc5> 
c01a0f35 <task_in_intr+95/100>
Code;  c01a0f81 <task_in_intr+e1/100>
   11:   8b 43 24                  mov    0x24(%ebx),%eax

  <0> Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.



Also, this was printed to console right before the oops:

hdc: bad special flag: 0x03



Regards,

   // nuno
