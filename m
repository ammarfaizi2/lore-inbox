Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSGYQ6f>; Thu, 25 Jul 2002 12:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSGYQ6f>; Thu, 25 Jul 2002 12:58:35 -0400
Received: from bru-cse-369.cisco.com ([144.254.12.31]:17642 "EHLO
	bru-cse-369.cisco.com") by vger.kernel.org with ESMTP
	id <S315472AbSGYQ6d>; Thu, 25 Jul 2002 12:58:33 -0400
Date: Thu, 25 Jul 2002 19:01:31 +0200
From: Marc Duponcheel <mduponch@cisco.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19-rc2 -> 2.4.19-rc3 : no more eth (fwd)
Message-ID: <20020725170131.GA22527@cisco.com>
Reply-To: Marc Duponcheel <mduponch@cisco.com>
References: <Pine.LNX.4.44.0207232309370.30729-100000@freak.distro.conectiva> <3D3E1FB8.20CB0F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3E1FB8.20CB0F@zip.com.au>
User-Agent: Mutt/1.4i
Organization: Cisco Systems
X-uname: SunOS 5.8 sun4u
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 08:32:08PM -0700, Andrew Morton wrote:
> Marcelo Tosatti wrote:
...
> > Warning (compare_Version): Version mismatch.  3c59x says 2.4.18, System.map says 2.4.19.  Expect lots of address mismatches.
> 
> This is a worry.  Are we sure it was a clean build?
> Please do a `make mrproper' and retest?

 Recall,

This is about ethernet interfaces not initialising (and hence not working)
with 2.4.19-rc3 (they do initialise and work with 2.4.19-rc2).

As suggested, I have, for all certainty, repatched linux-2.4.18.tar.gz with patch-2.4.19-rc3.gz
and rebuilt from a 'mrproper' /usr/src/linux, but the issue remains.

This time I ran ksymoops on the 2.4.19-rc3 system so no more mismatches

When doing 'lsmod' one sees the modules eepro100 and 3c59x as 'initialising'
and one cannot 'rmmod' them because they are 'busy'.

PS: I am making vmlinux-es for many many years now on several platforms
and this issue, I must admit, is one of the most surprising ones, after
a fresh kernel reboot.

 In general I use latest software (modutils, gcc etc...)

Thanks for your valuable time

        here is the decoded oops

 apparently the oops is in pci_register_driver

==========================================================================================
ksymoops 2.4.4 on i686 2.4.19-rc3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc3/ (default)
     -m /boot/System.map-2.4.19-rc3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281e4
esi: d0cb5d00   edi: 00000000   ebp: d0cb1000   esp: cfaf7ef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 358, stackpage=cfaf7000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cb4302 d0cb5d00 00000000 
ffffffea c011d82b d0cb1060 08083ec0 00004cf0 00000000 0808868c 0000482c 
00000060 00000060 00000008 cfc7ce80 cf5a7000 cf5a8000 00000060 d0cae000 
Call Trace:    [<d0cb4302>] [<d0cb5d00>] [<c011d82b>] [<d0cb1060>] [<d0cb1060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cb4302 <[eepro100]eepro100_init_module+42/70>
Trace; d0cb5d00 <[eepro100]eepro100_driver+0/3f>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; d0cb1060 <[eepro100]eepro100_init_one+0/20>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

<1>Unable to handle kernel paging request at virtual address d0ca6640
c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010292
eax: d0ca6640   ebx: ffffffea   ecx: c102c01c   edx: c02281f0
esi: d0cbdc00   edi: 00000000   ebp: d0cb7000   esp: cf5bbef8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 383, stackpage=cf5bb000)
Stack: c02281d0 c102c01c ffffffea 00000000 00000000 d0cbb569 d0cbdc00 ffffffea 
00000000 c011d82b d0cb7060 08086c48 00006c08 00000000 0808cf48 00006360 
00000060 00000060 00000005 cfc7cec0 cf588000 cf589000 00000060 d0cb1000 
Call Trace:    [<d0cbb569>] [<d0cbdc00>] [<c011d82b>] [<d0cb7060>] [<d0cb7060>]
[<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0cbb569 <[3c59x]vortex_init+19/90>
Trace; d0cbdc00 <[3c59x]vortex_driver+0/3f>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0cb7060 <[3c59x]vortex_suspend+0/20>
Trace; d0cb7060 <[3c59x]vortex_suspend+0/20>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx

c01a21a7
Oops: 0002
CPU:    0
EIP:    0010:[<c01a21a7>]    Not tainted
EFLAGS: 00010296
eax: d0ca6640   ebx: 00000202   ecx: c102c01c   edx: c02281e4
esi: d0d705a0   edi: 00000000   ebp: d0d704a0   esp: cd51fe9c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1447, stackpage=cd51f000)
Stack: c02281d0 c0228350 00000202 00000000 d0d704a0 d0d58433 d0d705a0 00000202 
d0d53962 d0d704a0 00001000 00000202 00000000 00000001 d0d4571c d0d704a0 
c02281d0 c0228334 000001ff 00000202 00000000 c100001c c123c754 c02281d0 
Call Trace:    [<d0d704a0>] [<d0d58433>] [<d0d705a0>] [<d0d53962>] [<d0d704a0>]
[<d0d4571c>] [<d0d704a0>] [<d0d57191>] [<d0d704a0>] [<d0d704a0>] [<c011d82b>]
[<d0d53060>] [<d0d6ff08>] [<d0d53060>] [<c010902b>]
Code: 89 30 8b 1d e8 2b 23 c0 89 35 f4 2b 23 c0 89 46 04 81 fb e8 

>>EIP; c01a21a7 <pci_register_driver+17/60>   <=====
Trace; d0d704a0 <[aic7xxx]driver_template+0/6c>
Trace; d0d58433 <[aic7xxx]ahc_linux_pci_probe+13/40>
Trace; d0d705a0 <[aic7xxx]aic7xxx_pci_driver+0/40>
Trace; d0d53962 <[aic7xxx]ahc_linux_detect+42/b0>
Trace; d0d704a0 <[aic7xxx]driver_template+0/6c>
Trace; d0d4571c <[scsi_mod]scsi_register_host+5c/300>
Trace; d0d704a0 <[aic7xxx]driver_template+0/6c>
Trace; d0d57191 <[aic7xxx]init_this_scsi_driver+21/50>
Trace; d0d704a0 <[aic7xxx]driver_template+0/6c>
Trace; d0d704a0 <[aic7xxx]driver_template+0/6c>
Trace; c011d82b <sys_init_module+4db/630>
Trace; d0d53060 <[aic7xxx]ahc_print_path+0/0>
Trace; d0d6ff08 <[aic7xxx].rodata.end+4845/4bfd>
Trace; d0d53060 <[aic7xxx]ahc_print_path+0/0>
Trace; c010902b <system_call+33/38>
Code;  c01a21a7 <pci_register_driver+17/60>
00000000 <_EIP>:
Code;  c01a21a7 <pci_register_driver+17/60>   <=====
   0:   89 30                     mov    %esi,(%eax)   <=====
Code;  c01a21a9 <pci_register_driver+19/60>
   2:   8b 1d e8 2b 23 c0         mov    0xc0232be8,%ebx
Code;  c01a21af <pci_register_driver+1f/60>
   8:   89 35 f4 2b 23 c0         mov    %esi,0xc0232bf4
Code;  c01a21b5 <pci_register_driver+25/60>
   e:   89 46 04                  mov    %eax,0x4(%esi)
Code;  c01a21b8 <pci_register_driver+28/60>
  11:   81 fb e8 00 00 00         cmp    $0xe8,%ebx


1 warning issued.  Results may not be reliable.
==========================================================================================


--
 Greetings,

Marc Duponcheel     Multicast Development Engineer      Cisco Systems
email: mduponch@cisco.com tel: +32 2 704 52 40 cell: +32 478 68 10 91


























