Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVAFSQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVAFSQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbVAFSOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:14:02 -0500
Received: from pop.gmx.de ([213.165.64.20]:64470 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262988AbVAFSKi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:10:38 -0500
X-Authenticated: #1725425
Date: Thu, 6 Jan 2005 19:17:29 +0100
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: alex@zodiac.dnsalias.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-Id: <20050106191729.2a160244.Ballarin.Marc@gmx.de>
In-Reply-To: <20050106185529.43662ebc.diegocg@gmail.com>
References: <20050106002240.00ac4611.akpm@osdl.org>
	<200501061811.51659@zodiac.zodiac.dnsalias.org>
	<20050106185529.43662ebc.diegocg@gmail.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005 18:55:29 +0100
Diego Calleja <diegocg@gmail.com> wrote:

> El Thu, 6 Jan 2005 18:11:51 +0100 Alexander Gran <alex@zodiac.dnsalias.org> escribió:
> 
> 
> > Y stays black, I need sysrq to reboot. mm1 works fine.
> > 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 
> > 03)
> > 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf 
> > [Radeon Mobility 9000 M9] (rev 02)
> 
> 
> I was going to report that bug, too. Mine is a p3 with:
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
> 0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
> 0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
> 0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
> 0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
> 0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
> 
> and using x.org

You use via-agp. That's fine, since I get the same oops on nvidia-agp. So the common
piece seems to be radeon drm.

The oops can be avoided by reverting
agpgart-add-bridge-parameter-to-driver-functions.patch
agpgart-allow-multiple-backends-to-be-initialized.patch
drm-add-support-for-new-multiple-agp-bridge-agpgart-api.patch

Regards

(For some reason, ksymoops does't like my /proc/kallsyms)

ksymoops 2.4.9 on i686 2.6.10-mm2.  Options used
     -v /home/marc/source/kernel/tmp/linux-2.6.10-mm2/vmlinux (specified)
     -k /home/marc/KALLSYMS (specified)
     -l /home/marc/MODULES (specified)
     -o /lib/modules/2.6.10-mm2 (specified)
     -m /home/marc/source/kernel/tmp/linux-2.6.10-mm2/System.map (specified)

Warning (read_ksyms): no kernel symbols in ksyms, is /home/marc/KALLSYMS a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000004
f88e68a8
*pde = 34401067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<f88e68a8>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246   (2.6.10-mm2) 
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: f5c154a0   edi: 00000000   ebp: f58a2320   esp: f6e43f1c
ds: 007b   es: 007b   ss: 0068
Stack: bffff2c0 c01c3df4 00000000 f7c16800 f7591ea0 f8948eac f8948d2f 00800000 
       00000001 00000000 00000001 00000000 f7c16800 00000036 f8948e20 f8944c15 
       bffff2c0 00000003 f6e42000 c01549cb 000002d0 f7fea880 c0308ac0 40086436 
Call Trace:
 [<c01c3df4>] copy_from_user+0x34/0x80
 [<f8948eac>] drm_agp_bind+0x8c/0xe0 [drm]
 [<f8948d2f>] drm_agp_alloc+0x10f/0x160 [drm]
 [<f8948e20>] drm_agp_bind+0x0/0xe0 [drm]
 [<f8944c15>] drm_ioctl+0xe5/0x1ab [drm]
 [<c01549cb>] sys_fstat64+0x2b/0x30
 [<f8944b30>] drm_ioctl+0x0/0x1ab [drm]
 [<c015bad0>] do_ioctl+0x50/0x60
 [<c015bc8e>] sys_ioctl+0x6e/0x1e0
 [<c0102d99>] sysenter_past_esp+0x52/0x75
Code: 20 89 fa 8b 58 04 89 f0 ff 53 40 85 c0 75 09 c6 46 28 01 89 7e 1c 31 c0 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4 14 c3 8b 46 08 <8b> 40 04 ff 50 34 c6 46 29 01 eb c4 89 74 24 04 c7 04 24 5c 86 


>>EIP; f88e68a8 <pg0+3851b8a8/3fc33400>   <=====

>>esi; f5c154a0 <pg0+3584a4a0/3fc33400>
>>ebp; f58a2320 <pg0+354d7320/3fc33400>
>>esp; f6e43f1c <pg0+36a78f1c/3fc33400>

Trace; c01c3df4 <copy_from_user+34/80>
Trace; f8948eac <pg0+3857deac/3fc33400>
Trace; f8948d2f <pg0+3857dd2f/3fc33400>
Trace; f8948e20 <pg0+3857de20/3fc33400>
Trace; f8944c15 <pg0+38579c15/3fc33400>
Trace; c01549cb <sys_fstat64+2b/30>
Trace; f8944b30 <pg0+38579b30/3fc33400>
Trace; c015bad0 <do_ioctl+50/60>
Trace; c015bc8e <sys_ioctl+6e/1e0>
Trace; c0102d99 <sysenter_past_esp+52/75>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  f88e687d <pg0+3851b87d/3fc33400>
00000000 <_EIP>:
Code;  f88e687d <pg0+3851b87d/3fc33400>
   0:   20 89 fa 8b 58 04         and    %cl,0x4588bfa(%ecx)
Code;  f88e6883 <pg0+3851b883/3fc33400>
   6:   89 f0                     mov    %esi,%eax
Code;  f88e6885 <pg0+3851b885/3fc33400>
   8:   ff 53 40                  call   *0x40(%ebx)
Code;  f88e6888 <pg0+3851b888/3fc33400>
   b:   85 c0                     test   %eax,%eax
Code;  f88e688a <pg0+3851b88a/3fc33400>
   d:   75 09                     jne    18 <_EIP+0x18>
Code;  f88e688c <pg0+3851b88c/3fc33400>
   f:   c6 46 28 01               movb   $0x1,0x28(%esi)
Code;  f88e6890 <pg0+3851b890/3fc33400>
  13:   89 7e 1c                  mov    %edi,0x1c(%esi)
Code;  f88e6893 <pg0+3851b893/3fc33400>
  16:   31 c0                     xor    %eax,%eax
Code;  f88e6895 <pg0+3851b895/3fc33400>
  18:   8b 5c 24 08               mov    0x8(%esp),%ebx
Code;  f88e6899 <pg0+3851b899/3fc33400>
  1c:   8b 74 24 0c               mov    0xc(%esp),%esi
Code;  f88e689d <pg0+3851b89d/3fc33400>
  20:   8b 7c 24 10               mov    0x10(%esp),%edi
Code;  f88e68a1 <pg0+3851b8a1/3fc33400>
  24:   83 c4 14                  add    $0x14,%esp
Code;  f88e68a4 <pg0+3851b8a4/3fc33400>
  27:   c3                        ret    
Code;  f88e68a5 <pg0+3851b8a5/3fc33400>
  28:   8b 46 08                  mov    0x8(%esi),%eax

This decode from eip onwards should be reliable

Code;  f88e68a8 <pg0+3851b8a8/3fc33400>
00000000 <_EIP>:
Code;  f88e68a8 <pg0+3851b8a8/3fc33400>   <=====
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  f88e68ab <pg0+3851b8ab/3fc33400>
   3:   ff 50 34                  call   *0x34(%eax)
Code;  f88e68ae <pg0+3851b8ae/3fc33400>
   6:   c6 46 29 01               movb   $0x1,0x29(%esi)
Code;  f88e68b2 <pg0+3851b8b2/3fc33400>
   a:   eb c4                     jmp    ffffffd0 <_EIP+0xffffffd0>
Code;  f88e68b4 <pg0+3851b8b4/3fc33400>
   c:   89 74 24 04               mov    %esi,0x4(%esp)
Code;  f88e68b8 <pg0+3851b8b8/3fc33400>
  10:   c7                        .byte 0xc7
Code;  f88e68b9 <pg0+3851b8b9/3fc33400>
  11:   04 24                     add    $0x24,%al
Code;  f88e68bb <pg0+3851b8bb/3fc33400>
  13:   5c                        pop    %esp
Code;  f88e68bc <pg0+3851b8bc/3fc33400>
  14:   86                        .byte 0x86


1 warning issued.  Results may not be reliable.


0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:07.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
0000:01:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
0000:01:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
0000:01:0d.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
0000:02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE]
