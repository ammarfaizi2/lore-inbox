Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287468AbRLaJHn>; Mon, 31 Dec 2001 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287480AbRLaJHe>; Mon, 31 Dec 2001 04:07:34 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:13842 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id <S287477AbRLaJHR>;
	Mon, 31 Dec 2001 04:07:17 -0500
Date: Mon, 31 Dec 2001 10:07:09 +0100
From: Michal Kuratczyk <kura@cs.net.pl>
To: linux-kernel@vger.kernel.org
Subject: 2 * Oops on 2.4.17
Message-ID: <20011231090709.GA20577@cs.net.pl>
Reply-To: kura@cs.net.pl
Mail-Followup-To: Michal Kuratczyk <kura@cs.net.pl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Organization: CYBER Service (www.cs.net.pl)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While loading aic7xxx (a new one, with old everything is ok) my machine
crashed completly (no magic SysRq). I'm not sure is it 8139too bug or
aic7xxx (probably both). After restart with zero ethernet traffic aic7xxx
loaded successfully, but oopsed (not crashed) while rmmmod. My machine
is SMP (2*PIII):
Linux gruby 2.4.17 #1 SMP czw gru 27 14:26:28 CET 2001 i686 pld

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11l
mount                  2.11l
modutils               2.4.12
e2fsprogs              1.25
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      2.10.0
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.11
Modules Loaded         8139too eepro100

lspci -vvv shows this about my 8139:

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: OVISLINK Corp. LFE-8139ATX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at 2000 [size=256]
        Region 1: Memory at f4104000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: <available only to root>

aic7xxx shows this about my hardware while loading:

(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 393 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 393 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
  Vendor: TEAC      Model: CD-R56S4          Rev: 1.0F
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:0:5:1) Synchronous at 10.0 Mbyte/sec, offset 15.


The oops follows:

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k 20011228130929.ksyms (specified)
     -l 20011228130929.modules (specified)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Oops:   0000
CPU:    1
EIP:    0010:[<e88432d8>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: e2ac5080   ebx: 00000000     ecx: 00000000       edx: e885e000
esi: 00000282   edi: cd577fc4     ebp: 00000001       esp: cd577ee0
ds: 0018        es: 0018       ss: 0018
Process bb-combo.sh (pid 8981, stackpage=cd577ee0)
Stack: e2e1107c 00000282 cd577fc4 00000013 e885c000 0d477065 df0ca120 00000000
       00000001 08076938 c01126b4 e77338e0 df0ca120 08076938 00000001 00000000
       00000000 c0112561 bfffda8c c0143029 e8848347 e2e1107c 00000061 e2e1107c
Call trace: [<c01126b4>] [<c0112561>] [<c0143029>] [<e8848347>] [<e884839d>]
        [<c01083e4>] [<c01085d6>] [<c010a6a8>]
Code: 8a 53 14 84 d2 0f 84 e4 02 00 00 8b 43 0c f6 c4 0f 0f 85 d8

>>EIP; e88432d8 <[8139too].data.end+f03a/29d62>   <=====
Trace; c01126b4 <do_page_fault+17c/4b8>
Trace; c0112560 <do_page_fault+28/4b8>
Trace; c0143028 <dput+18/144>
Trace; e8848346 <[8139too].data.end+140a8/29d62>
Trace; e884839c <[8139too].data.end+140fe/29d62>
Trace; c01083e4 <handle_IRQ_event+50/7c>
Trace; c01085d6 <do_IRQ+a6/ec>
Trace; c010a6a8 <call_do_IRQ+6/e>
Code;  e88432d8 <[8139too].data.end+f03a/29d62>
00000000 <_EIP>:
Code;  e88432d8 <[8139too].data.end+f03a/29d62>   <=====
   0:   8a 53 14                  mov    0x14(%ebx),%dl   <=====
Code;  e88432da <[8139too].data.end+f03c/29d62>
   3:   84 d2                     test   %dl,%dl
Code;  e88432dc <[8139too].data.end+f03e/29d62>
   5:   0f 84 e4 02 00 00         je     2ef <_EIP+0x2ef> e88435c6 <[8139too].data.end+f328/29d62>
Code;  e88432e2 <[8139too].data.end+f044/29d62>
   b:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  e88432e6 <[8139too].data.end+f048/29d62>
   e:   f6 c4 0f                  test   $0xf,%ah
Code;  e88432e8 <[8139too].data.end+f04a/29d62>
  11:   0f 85 d8 00 00 00         jne    ef <_EIP+0xef> e88433c6 <[8139too].data.end+f128/29d62>

 <0> Kernel panic: Aiee, killing interrupt handler!

And now, the second one (while 'rmmod aic7xxx'):

ksymoops 2.4.3 on i686 2.4.17.  Options used
     -V (default)
     -k 20011228130929.ksyms (specified)
     -l 20011228130929.modules (specified)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

CPU:    0
EIP:    0010:[<c014be32>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: e0c83f74   ebx: 00000001   ecx: 00000001   edx: 000002e8
esi: e0c83f74   edi: e0c83f76   ebp: d3e22a40   esp: e0c83ef8
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 16409, stackpage=e0c83000)
Stack: d3e22970 e0c83f76 c014c72e 00000001 e0c83f74 000002e8 00000002 e0c83f74
        d3e229c0 e0c83f74 c01bc5ab e0c83f74 d3e22940 e0c83f74 c0242b86 00000002
        e885e000 00000000 e885e000 bfffebec 00000002 00000000 00000000 00000001
Call Trace: [<c014c72e>] [<c01bc5ab>] [<c01bc98e>] [<e8875960>] [<e8861a00>]
        [<e8875960>] [<c0117fa7>] [<c011727c>] [<c0106d7b>]
Code: 66 83 3a 00 74 18 0f b7 42 02 39 c8 75 10 8b 7a 04 fc a8 00 

>>EIP; c014be32 <proc_match+12/38>   <=====
Trace; c014c72e <remove_proc_entry+66/108>
Trace; c01bc5aa <scsi_unregister_host+31a/478>
Trace; c01bc98e <scsi_unregister_module+26/34>
Trace; e8875960 <[aic7xxx]driver_template+0/6c>
Trace; e8861a00 <[aic7xxx]exit_this_scsi_driver+c/1c>
Trace; e8875960 <[aic7xxx]driver_template+0/6c>
Trace; c0117fa6 <free_module+16/ac>
Trace; c011727c <sys_delete_module+128/238>
Trace; c0106d7a <system_call+32/38>
Code;  c014be32 <proc_match+12/38>
00000000 <_EIP>:
Code;  c014be32 <proc_match+12/38>   <=====
   0:   66 83 3a 00               cmpw   $0x0,(%edx)   <=====
Code;  c014be36 <proc_match+16/38>
   4:   74 18                     je     1e <_EIP+0x1e> c014be50 <proc_match+30/38>
Code;  c014be38 <proc_match+18/38>
   6:   0f b7 42 02               movzwl 0x2(%edx),%eax
Code;  c014be3c <proc_match+1c/38>
   a:   39 c8                     cmp    %ecx,%eax
Code;  c014be3e <proc_match+1e/38>
   c:   75 10                     jne    1e <_EIP+0x1e> c014be50 <proc_match+30/38>
Code;  c014be40 <proc_match+20/38>
   e:   8b 7a 04                  mov    0x4(%edx),%edi
Code;  c014be42 <proc_match+22/38>
  11:   fc                        cld    
Code;  c014be44 <proc_match+24/38>
  12:   a8 00                     test   $0x0,%al

-- 
Michal Kuratczyk <kura@cs.net.pl>
