Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263047AbTEGKOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTEGKOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:14:42 -0400
Received: from vicar.dcs.qmul.ac.uk ([138.37.88.163]:26823 "EHLO
	mail.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP id S263047AbTEGKOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:14:38 -0400
Date: Wed, 7 May 2003 11:27:02 +0100 (BST)
From: Matt Bernstein <mb/lkml@dcs.qmul.ac.uk>
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@digeo.com>, elenstev@mesatop.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
In-Reply-To: <20030506143533.GA22907@averell>
Message-ID: <Pine.LNX.4.55.0305071121220.6697@r2-pc.dcs.qmul.ac.uk>
References: <1051905879.2166.34.camel@spc9.esa.lanl.gov>
 <20030502133405.57207c48.akpm@digeo.com> <1051908541.2166.40.camel@spc9.esa.lanl.gov>
 <20030502140508.02d13449.akpm@digeo.com> <1051910420.2166.55.camel@spc9.esa.lanl.gov>
 <Pine.LNX.4.55.0305030014130.1304@jester.mews> <20030502164159.4434e5f1.akpm@digeo.com>
 <20030503025307.GB1541@averell> <Pine.LNX.4.55.0305030800140.1304@jester.mews>
 <Pine.LNX.4.55.0305061511020.3237@r2-pc.dcs.qmul.ac.uk> <20030506143533.GA22907@averell>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (19DM8f-0003Nl-AB)
X-Auth-User: jonquil.thebachchoir.org.uk
X-uvscan-result: clean (19DM8i-0006zR-Ps)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 6 Andi Kleen wrote:

>On Tue, May 06, 2003 at 04:15:55PM +0200, Matt Bernstein wrote:
>> Is this helpful?
>
>What I really need is an probably decoded with ksymoops oops, not jpegs.

ksymoops 2.4.9 on i686 2.4.20-8.  Options used
     -v /opt/linux-2.5.69-mm1/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.69-mm1 (specified)
     -m /boot/System.map-2.5.69-mm1 (specified)

No modules in ksyms, skipping objects
ACPI: LAPIC_NMI (acpi_id[0xff] polarity[0x0] trigger[0x0] lint[0x1])
Machine check exception polling timer started.
Unable to handle kernel paging request at virtual address c03b6e83
c010e93f
*pde = 00102027
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c010e93f>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: e094c580   ebx: 00000001   ecx: 00000000   edx: c0345740
esi: c03b6e83   edi: e0944f1d   ebp: 00000001   esp: dcfb5ed8
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 dcfb5ee8 00000001 c0345740 00000003 e094c580 e093c448 c030321c 
       e093c19f c030320b c01149fe e094c568 e094c5f7 e093c0f2 e092f000 e093c1f0 
       00000460 00000460 c012f7e1 e092f000 e093c1f0 e09505c0 00000016 e09505c0 
Call Trace:
 [<c01149fe>] module_finalize+0x8e/0xa0
 [<c012f7e1>] load_module+0x6d1/0x920
 [<c012faa8>] sys_init_module+0x78/0x1d0
 [<c01091e5>] sysenter_past_esp+0x52/0x71
Code: 8b 54 24 0c 0f 4c dd 8b 7c 24 10 03 38 81 fb ff 01 00 00 8b 34 9a 77 39 89 d9 c1 e9 02 f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 <a4> 29 dd 01 5c 24 10 85 ed 7f be 83 44 24 14 0c 8b 5c 24 30 39 


>>EIP; c010e93f <apply_alternatives+ff/180>   <=====

>>eax; e094c580 <_end+20555520/3fc06fa0>
>>edx; c0345740 <k7_nops+0/24>
>>esi; c03b6e83 <k7nops+0/2d>
>>edi; e0944f1d <_end+2054debd/3fc06fa0>
>>esp; dcfb5ed8 <_end+1cbbee78/3fc06fa0>

Trace; c01149fe <module_finalize+8e/a0>
Trace; c012f7e1 <load_module+6d1/920>
Trace; c012faa8 <sys_init_module+78/1d0>
Trace; c01091e5 <sysenter_past_esp+52/71>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c010e914 <apply_alternatives+d4/180>
00000000 <_EIP>:
Code;  c010e914 <apply_alternatives+d4/180>
   0:   8b 54 24 0c               mov    0xc(%esp,1),%edx
Code;  c010e918 <apply_alternatives+d8/180>
   4:   0f 4c dd                  cmovl  %ebp,%ebx
Code;  c010e91b <apply_alternatives+db/180>
   7:   8b 7c 24 10               mov    0x10(%esp,1),%edi
Code;  c010e91f <apply_alternatives+df/180>
   b:   03 38                     add    (%eax),%edi
Code;  c010e921 <apply_alternatives+e1/180>
   d:   81 fb ff 01 00 00         cmp    $0x1ff,%ebx
Code;  c010e927 <apply_alternatives+e7/180>
  13:   8b 34 9a                  mov    (%edx,%ebx,4),%esi
Code;  c010e92a <apply_alternatives+ea/180>
  16:   77 39                     ja     51 <_EIP+0x51>
Code;  c010e92c <apply_alternatives+ec/180>
  18:   89 d9                     mov    %ebx,%ecx
Code;  c010e92e <apply_alternatives+ee/180>
  1a:   c1 e9 02                  shr    $0x2,%ecx
Code;  c010e931 <apply_alternatives+f1/180>
  1d:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  c010e933 <apply_alternatives+f3/180>
  1f:   f6 c3 02                  test   $0x2,%bl
Code;  c010e936 <apply_alternatives+f6/180>
  22:   74 02                     je     26 <_EIP+0x26>
Code;  c010e938 <apply_alternatives+f8/180>
  24:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c010e93a <apply_alternatives+fa/180>
  26:   f6 c3 01                  test   $0x1,%bl
Code;  c010e93d <apply_alternatives+fd/180>
  29:   74 01                     je     2c <_EIP+0x2c>

This decode from eip onwards should be reliable

Code;  c010e93f <apply_alternatives+ff/180>
00000000 <_EIP>:
Code;  c010e93f <apply_alternatives+ff/180>   <=====
   0:   a4                        movsb  %ds:(%esi),%es:(%edi)   <=====
Code;  c010e940 <apply_alternatives+100/180>
   1:   29 dd                     sub    %ebx,%ebp
Code;  c010e942 <apply_alternatives+102/180>
   3:   01 5c 24 10               add    %ebx,0x10(%esp,1)
Code;  c010e946 <apply_alternatives+106/180>
   7:   85 ed                     test   %ebp,%ebp
Code;  c010e948 <apply_alternatives+108/180>
   9:   7f be                     jg     ffffffc9 <_EIP+0xffffffc9>
Code;  c010e94a <apply_alternatives+10a/180>
   b:   83 44 24 14 0c            addl   $0xc,0x14(%esp,1)
Code;  c010e94f <apply_alternatives+10f/180>
  10:   8b 5c 24 30               mov    0x30(%esp,1),%ebx
Code;  c010e953 <apply_alternatives+113/180>
  14:   39                        .byte 0x39

>Also you seem to be the only one with the problem so just to avoid
>any weird build problems do a make distclean and rebuild from scratch
>and reinstall the modules.

Will do later today if the above isn't helpful. One other thing I did do 
was a make -j19 KBUILD_VERBOSE=0 but I've been told this is completely 
safe these days.

Cheers,

Matt
