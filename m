Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275805AbRI1Ctg>; Thu, 27 Sep 2001 22:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275806AbRI1Ct1>; Thu, 27 Sep 2001 22:49:27 -0400
Received: from marla.i2net.com ([208.179.142.252]:31761 "HELO marla.i2net.com")
	by vger.kernel.org with SMTP id <S275805AbRI1CtM>;
	Thu, 27 Sep 2001 22:49:12 -0400
Message-ID: <3BB3E542.3040006@i2net.com>
Date: Thu, 27 Sep 2001 19:49:38 -0700
From: J <jack@i2net.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cat /proc/dri/[01]/vm makes oops with tdfx
Content-Type: multipart/mixed;
 boundary="------------050203020305060106090704"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050203020305060106090704
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
	I can generate this oops when ever I cat /proc/dri/[01]/vm, running
X or not, running as root or not. The computer is a ABIT VP6 with two
Pentium 3 procs, Highmem kernel (2 Gig ram), One voodoo 3500 AGP card,
and One voodoo 3000 PCI card. Kernel 2.4.10 with XFS patch and JFS 1.0.5
Patch. I built it with gcc 2.95.4, and a recent copy of binutils. Perhaps
I should try gcc-2.95.3. Anyway, on to the oops. By the way, DRI works great
on the first head (v3500), but dosen't work very well on the other. Will
tdfx.o ever work with two heads, or is it an X thing? If anyone needs more
info email me @ jack at i2net.com. Thanks for your time.

included here:
	1) ksymoops(2.4.3) output of oops message.
	2) lsmod output
	3) Some of lspci -vvvvvvvvvvvvv 




--------------050203020305060106090704
Content-Type: text/plain;
 name="ksymoops-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops-2"

ksymoops 2.4.3 on i686 2.4.10-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-xfs/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
**** Dont Worry, they are... ****
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<4>f89b6594
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<f89b6594>]
Using defaults from ksymoops -t elf32-i386 -a i386
<4>EFLAGS: 00010287
<4>eax: 00000000   ebx: 00000032   ecx: f6c29000   edx: f6c3a634
<4>esi: f6c45f98   edi: f6c29000   ebp: f6c29000   esp: f6c45f0c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process cat (pid: 141, stackpage=f6c45000)
<4>Stack: f6c3a634 f6c45f98 f6c29000 f6c3a654 00000000 f6c3a634 f89b93b4 f89b93b7 
<4>       f89b93bb f89b93bf f89b66e6 f6c29000 f6c45f98 00000000 00000c00 f6c45f94 
<4>       f6c3a634 f6d79320 00000c00 f6c29000 00001000 c015444a f6c29000 f6c45f98 
<4>Call Trace: [<f89b93b4>] [<f89b93b7>] [<f89b93bb>] [<f89b93bf>] [<f89b66e6>] 

*** Something like this i guess ....***
<4>   [proc_file_read+242/404] [sys_read+143/196] [system_call+51/56]
***                                 ***

<4>Code: 8b 38 8b 07 0f 18 00 8b 44 24 14 8b 90 4c 01 00 00 39 d7 0f 

>>EIP; f89b6594 <[tdfx]tdfx__vm_info+98/1b4>   <=====
Trace; f89b93b4 <[tdfx].rodata.start+1394/197e>
Trace; f89b93b6 <[tdfx].rodata.start+1396/197e>
Trace; f89b93ba <[tdfx].rodata.start+139a/197e>
Trace; f89b93be <[tdfx].rodata.start+139e/197e>
Trace; f89b66e6 <[tdfx]tdfx_vm_info+36/4c>
Code;  f89b6594 <[tdfx]tdfx__vm_info+98/1b4>
00000000 <_EIP>:
Code;  f89b6594 <[tdfx]tdfx__vm_info+98/1b4>   <=====
   0:   8b 38                     mov    (%eax),%edi   <=====
Code;  f89b6596 <[tdfx]tdfx__vm_info+9a/1b4>
   2:   8b 07                     mov    (%edi),%eax
Code;  f89b6598 <[tdfx]tdfx__vm_info+9c/1b4>
   4:   0f 18 00                  prefetchnta (%eax)
Code;  f89b659a <[tdfx]tdfx__vm_info+9e/1b4>
   7:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  f89b659e <[tdfx]tdfx__vm_info+a2/1b4>
   b:   8b 90 4c 01 00 00         mov    0x14c(%eax),%edx
Code;  f89b65a4 <[tdfx]tdfx__vm_info+a8/1b4>
  11:   39 d7                     cmp    %edx,%edi
Code;  f89b65a6 <[tdfx]tdfx__vm_info+aa/1b4>
  13:   0f 00 00                  sldt   (%eax)

<4> <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
<4>f89b6594
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<f89b6594>]
<4>EFLAGS: 00010287
<4>eax: 00000000   ebx: 00000032   ecx: f6c1e000   edx: f6c3a000
<4>esi: f6c45f98   edi: f6c1e000   ebp: f6c1e000   esp: f6c45f0c
<4>ds: 0018   es: 0018   ss: 0018
<4>Process cat (pid: 143, stackpage=f6c45000)
<4>Stack: f6c3a000 f6c45f98 f6c1e000 f6c3a020 00000000 f6c3a000 f89b93b4 f89b93b7 
<4>       f89b93bb f89b93bf f89b66e6 f6c1e000 f6c45f98 00000000 00000c00 f6c45f94 
<4>       f6c3a000 f6d79420 00000c00 f6c1e000 00001000 c015444a f6c1e000 f6c45f98 
<4>Call Trace: [<f89b93b4>] [<f89b93b7>] [<f89b93bb>] [<f89b93bf>] [<f89b66e6>] 
<4>Code: 8b 38 8b 07 0f 18 00 8b 44 24 14 8b 90 4c 01 00 00 39 d7 0f 

>>EIP; f89b6594 <[tdfx]tdfx__vm_info+98/1b4>   <=====
Trace; f89b93b4 <[tdfx].rodata.start+1394/197e>
Trace; f89b93b6 <[tdfx].rodata.start+1396/197e>
Trace; f89b93ba <[tdfx].rodata.start+139a/197e>
Trace; f89b93be <[tdfx].rodata.start+139e/197e>
Trace; f89b66e6 <[tdfx]tdfx_vm_info+36/4c>
Code;  f89b6594 <[tdfx]tdfx__vm_info+98/1b4>
00000000 <_EIP>:
Code;  f89b6594 <[tdfx]tdfx__vm_info+98/1b4>   <=====
   0:   8b 38                     mov    (%eax),%edi   <=====
Code;  f89b6596 <[tdfx]tdfx__vm_info+9a/1b4>
   2:   8b 07                     mov    (%edi),%eax
Code;  f89b6598 <[tdfx]tdfx__vm_info+9c/1b4>
   4:   0f 18 00                  prefetchnta (%eax)
Code;  f89b659a <[tdfx]tdfx__vm_info+9e/1b4>
   7:   8b 44 24 14               mov    0x14(%esp,1),%eax
Code;  f89b659e <[tdfx]tdfx__vm_info+a2/1b4>
   b:   8b 90 4c 01 00 00         mov    0x14c(%eax),%edx
Code;  f89b65a4 <[tdfx]tdfx__vm_info+a8/1b4>
  11:   39 d7                     cmp    %edx,%edi
Code;  f89b65a6 <[tdfx]tdfx__vm_info+aa/1b4>
  13:   0f 00 00                  sldt   (%eax)


1 warning issued.  Results may not be reliable.


--------------050203020305060106090704
Content-Type: text/plain;
 name="lsmod-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsmod-2"

Modules Loaded:
Module                  Size  Used by
tdfx                   35840   1
es1371                 30864   1
ac97_codec              9408   0 [es1371]


--------------050203020305060106090704
Content-Type: text/plain;
 name="lspci-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-2"

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0000000-d3ffffff
	Prefetchable memory behind bridge: d4000000-d5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 4

00:09.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc.: Unknown device 0057
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at c400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 3500 TV (NTSC)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at 9000 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]


--------------050203020305060106090704--

