Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbTBET2o>; Wed, 5 Feb 2003 14:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbTBET2o>; Wed, 5 Feb 2003 14:28:44 -0500
Received: from [200.75.8.52] ([200.75.8.52]:13253 "EHLO endor.componente.cl")
	by vger.kernel.org with ESMTP id <S263491AbTBET2l> convert rfc822-to-8bit;
	Wed, 5 Feb 2003 14:28:41 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Juan Francisco Guarda <francisco.guarda@sideral.cl>
Organization: Componente IT Solutions
To: linux-kernel@vger.kernel.org
Subject: NEC 5800/320La-R Kernel Panic with Qlogic QLA1216x
Date: Wed, 5 Feb 2003 16:53:06 -0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302051653.06861.francisco.guarda@sideral.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The server....NEC 5800/320La-R

- Fault Tolerant 
- Dual Processor Intel Pentium III 
- 2 GB RAM 
- HD SCSI de 36 GB x 5 
- SCSI Controller QLogic QLA1216x 
- Redundant Power Supply 
- Redundant Fast Ethernet Controller Intel EtherExpress Pro 100 
- Redundant Gigabit Ethernet Controller Intel EtherExpress Pro 1000 


The partition schema...

Filesystem           1k-blocks      Used Available Use% Mounted on 
/dev/sda6             27822252    252404  26156524   1% / 
/dev/sda1               126915     10899    109464  10% /boot 
/dev/sda5              5039600   1395936   3387668  30% /usr 
/dev/nb0              35007104     88088  33140744   1% /mirror 


The RAID 5 Schema...

raiddev /dev/md0 
        raid-level              5 
        nr-raid-disk            3 
        persistent-superblock   1 
        chunk-size              8 
 
        device                  /dev/sdc1 
        raid-disk               0 
        device                  /dev/sdd1 
        raid-disk               1 


The server was installed with Conectiva Linux 8.0, the lilo schema is...

boot=/dev/sda 
map=/boot/map 
install=/boot/boot.b 
prompt 
timeout=50 
message=/boot/message 
default=linux 
image=/boot/vmlinuz-2.4.18-2clsmp 
        label=linux 
        root=/dev/sda3 
        initrd=/boot/initrd-2.4.18-2clsmp.img 
        read-only 
image=/boot/vmlinuz-2.4.18-2cl 
        label=linux-up 
        root=/dev/sda3 
        initrd=/boot/initrd-2.4.18-2cl.img 
        read-only 
image=/boot/memtest86 
        label=memtest 


When the server boot with linux option (vmlinuz-2.4.18-2clsmp), the booting is 
stopped, without a message. 

I was intall a kernel-source-2.4.19-1U80_8cl.i386.rpm, and, i was configure 
with the option SMP, and BIGMEM (4GB), the compiling process was normal, but 
when i'm reboot the server, the machine does oops...

Unable to handle kernel paging request at virtual address 245c8b57 
  printing eip: 
c0123565 
*pde = 00000000 
Oops : 0002 
CPU : 1 
EIP : 0010:[<c0123565>]  Not tainted 
EFLAGS: 00010083 
eax: f783f600  ebx: c0350704  ecx: c01bb6f8  edx: c0350744 
esi: 245c8b53  edi: c0350520  ebp: 00000000  esp: c7fe7ed0 
ds: 0018    es: 0018    ss: 0018 
Process Swapper (pid: 0, stackpage=c7fe7000) 
Stack: 00000000 00000020 00000000 c034f6a0 0011bc00 00000000 0011bc00 00000004 
       00000001 c7fe7ef4 c7fe7ef4 c011fb5e c034faa0 c011fa33 00000000 c03285e0 
       00000001 fffffffe 00000020 c011f7bf c03285e0 c034f6a0 c0324800 00000000 
Call Trace: [<c011fb5e>] [<c011fa33>] [<c011f7bf>] [<c010a2cb>] [<c010c808>] 
  [<c019d463>] [<c019d354>] [<c0106d50>] [<c0106d50>] [<c0106de2>] 
[<c011b4db>] 
[<c011b3ed>] 
 
Code: 89 46 04 89 30 8b 41 08 89 c2 2b 54 24 18 85 ed 74 09 89 e8 
 <0> Kernel panic: Aiee. killing interrupt handler! 
In interrupt handler - not syncing 

I was run ksymoops -v vmlinux -m System.map -K -L -O < panic.txt, and i was 
obtain....
ksymoops 2.4.3 on i686 2.4.18-2cl.  Options used 
     -v /boot/componente (specified) 
     -K (specified) 
     -L (specified) 
     -O (specified) 
     -m /boot/System.map.componente (specified) 
 
Error (pclose_local): read_nm_symbols pclose failed 0x100 
Warning (read_vmlinux): no kernel symbols in vmlinux, is /boot/componente a 
valid vmlinux file? 
Unable to handle kernel paging request at virtual address 245c8b57 
c0123565 
*pde = 00000000 
EFLAGS: 00010083 
eax: f783f600  ebx: c0350704  ecx: c01bb6f8  edx: c0350744 
esi: 245c8b53  edi: c0350520  ebp: 00000000  esp: c7fe7ed0 
ds: 0018    es: 0018    ss: 0018 
Process Swapper (pid: 0, stackpage=c7fe7000) 
Stack: 00000000 00000020 00000000 c034f6a0 0011bc00 00000000 0011bc00 00000004 
       00000001 c7fe7ef4 c7fe7ef4 c011fb5e c034faa0 c011fa33 00000000 c03285e0 
       00000001 fffffffe 00000020 c011f7bf c03285e0 c034f6a0 c0324800 00000000 
Call Trace: [<c011fb5e>] [<c011fa33>] [<c011f7bf>] [<c010a2cb>] [<c010c808>] 
  [<c019d463>] [<c019d354>] [<c0106d50>] [<c0106d50>] [<c0106de2>] 
[<c011b4db>] 
[<c011b3ed>] 
Code: 89 46 04 89 30 8b 41 08 89 c2 2b 54 24 18 85 ed 74 09 89 e8 
Using defaults from ksymoops -t elf32-i386 -a i386 
 
Trace; c011fb5e <bh_action+4a/80> 
Trace; c011fa32 <tasklet_hi_action+66/a0> 
Trace; c011f7be <do_softirq+6e/cc> 
Trace; c010a2ca <do_IRQ+da/ec> 
Trace; c010c808 <call_do_IRQ+6/e> 
Trace; c019d462 <pr_power_idle+10e/274> 
Trace; c019d354 <pr_power_idle+0/274> 
Trace; c0106d50 <default_idle+0/34> 
Trace; c0106d50 <default_idle+0/34> 
Trace; c0106de2 <cpu_idle+3e/54> 
Trace; c011b4da <release_console_sem+8e/98> 
Trace; c011b3ec <printk+124/140> 
Code;  00000000 Before first symbol 
00000000 <_EIP>: 
Code;  00000000 Before first symbol 
   0:   89 46 04                  mov    %eax,0x4(%esi) 
Code;  00000002 Before first symbol 
   3:   89 30                     mov    %esi,(%eax) 
Code;  00000004 Before first symbol 
   5:   8b 41 08                  mov    0x8(%ecx),%eax 
Code;  00000008 Before first symbol 
   8:   89 c2                     mov    %eax,%edx 
Code;  0000000a Before first symbol 
   a:   2b 54 24 18               sub    0x18(%esp,1),%edx 
Code;  0000000e Before first symbol 
   e:   85 ed                     test   %ebp,%ebp 
Code;  00000010 Before first symbol 
  10:   74 09                     je     1b <_EIP+0x1b> 0000001a Before first 
symbol 
Code;  00000012 Before first symbol 
  12:   89 e8                     mov    %ebp,%eax 
 
 <0> Kernel panic: Aiee. killing interrupt handler! 
 
1 warning and 1 error issued.  Results may not be reliable. 


The freak is what i was boot the server with the "linux-up" option 
(vmlinuz-2.4.18-2cl), without support SMP and without support Bigmem. The 
server boot normally, but only with 900M of RAM and one processor support.

#free 
             total       used       free     shared    buffers     cached 
Mem:        900644     343388     557256          0      57820     130280 
-/+ buffers/cache:     155288     745356 
Swap:      2047992          0    2047992 

processor       : 0 
vendor_id       : GenuineIntel 
cpu family      : 6 
model           : 8 
model name      : Pentium III (Coppermine) 
stepping        : 6 
cpu MHz         : 800.071 
cache size      : 256 KB 
fdiv_bug        : no 
hlt_bug         : no 
f00f_bug        : no 
coma_bug        : no 
fpu             : yes 
fpu_exception   : yes 
cpuid level     : 2 
wp              : yes 
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse 
bogomips        : 1595.80 

... and, when i was run a lspci command, obtain...
#lspci 
 
00:00.0 Host bridge: Relience Computer CNB20HE (rev 06) 
00:00.1 Host bridge: Relience Computer CNB20HE (rev 06) 
00:05.0 PCI bridge: Stratus Computer Systems: Unknown device 1000 
00:06.0 PCI bridge: Stratus Computer Systems: Unknown device 1000 
00:07.0 ISA bridge: NEC Corporation: Unknown device 00de (rev f4) 
01:00.0 VGA compatible controller: Chips and Technologies F69000 HiQVideo (rev 
64) 
01:02.0 Ethernet controller: Intel Corporation: Unknown device 1004 (rev 02) 
01:05.0 SCSI storage controller: Q Logic: Unknown device 1216 (rev 06) 
01:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 
08) 
01:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 4f) 
01:0f.1 IDE interface: Relience Computer: Unknown device 0211 
01:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04) 

The SCSI controller and Gigabit Ethernet controler is Unknown, but does works.

I'm in a big trouble :((((, i need configure the server for work with smp and 
bigmem, but obtain a kernel panic.

Can anybody help me????

-- 
===========================================================
Juan Francisco Guarda Ramírez | Avda. 11 de Septiembre 1881
Gerente de Operaciones        | Oficina 813
Componente IT Solutions Ltda. | Providencia
jfguarda@componente.cl        | http://www.componente.cl
===========================================================

