Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312803AbSDSQx3>; Fri, 19 Apr 2002 12:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDSQx2>; Fri, 19 Apr 2002 12:53:28 -0400
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:15364 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S312803AbSDSQx1>;
	Fri, 19 Apr 2002 12:53:27 -0400
Date: 19 Apr 2002 16:53:19 -0000
Message-ID: <20020419165319.6213.qmail@legolas.dynup.net>
From: rudmer@legolas.dynup.net
To: davej@suse.de
Subject: 2.5.8-dj1: BUG in rd.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just downloaded patch-2.5.8.bz2 and patch-2.5.8-dj1.diff.bz2 and applied
them to a freshly extracted linux-2.5.7 and after boot I got this BUG.

processed through ksymoops:

ksymoops 2.4.5 on i586 2.5.8-dj1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.5.8-dj1/ (default)
     -m /boot/System.map-2.5.8-dj1 (specified)

No modules in ksyms, skipping objects
kernel BUG at rd.c:110!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c016f1b3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 01000041   ebx: c10633f8   ecx: c15162c0   edx: c10633f8
esi: c2c1c000   edi: 0003f3f0   ebp: 00000c00   esp: c15ebef8
ds: 0018   es: 0018   ss: 0018
Stack: c10633f8 c2c1c000 0003f3f0 00000c00 c10633f8 c2f455fc c016f2a1 c10633f8
       00000000 c10633f8 c0124957 c15162c0 c10633f8 00000400 00001000 00000000
       c15162c0 ffffffea 00000c00 c2f455c8 00001000 00000400 00000c00 fffffff4
Call Trace: [<c016f2a1>] [<c0124957>] [<c0134548>] [<c012f266>] [<c0108757>]
Code: 0f 0b 6e 00 2c 3b 1d c0 8b 7c 24 1c 31 c0 89 f9 8a 47 17 8b


>>EIP; c016f1b3 <ramdisk_updatepage+23/e8>   <=====

>>eax; 01000041 Before first symbol
>>ebx; c10633f8 <END_OF_CODE+e08bec/????>
>>ecx; c15162c0 <END_OF_CODE+12bbab4/????>
>>edx; c10633f8 <END_OF_CODE+e08bec/????>
>>esi; c2c1c000 <END_OF_CODE+29c17f4/????>
>>edi; 0003f3f0 Before first symbol
>>ebp; 00000c00 Before first symbol
>>esp; c15ebef8 <END_OF_CODE+13916ec/????>

Trace; c016f2a1 <ramdisk_prepare_write+d/20>
Trace; c0124957 <generic_file_write+497/6fc>
Trace; c0134548 <block_llseek+0/98>
Trace; c012f266 <sys_write+96/f0>
Trace; c0108757 <syscall_call+7/b>

Code;  c016f1b3 <ramdisk_updatepage+23/e8>
00000000 <_EIP>:
Code;  c016f1b3 <ramdisk_updatepage+23/e8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016f1b5 <ramdisk_updatepage+25/e8>
   2:   6e                        outsb  %ds:(%esi),(%dx)
Code;  c016f1b6 <ramdisk_updatepage+26/e8>
   3:   00 2c 3b                  add    %ch,(%ebx,%edi,1)
Code;  c016f1b9 <ramdisk_updatepage+29/e8>
   6:   1d c0 8b 7c 24            sbb    $0x247c8bc0,%eax
Code;  c016f1be <ramdisk_updatepage+2e/e8>
   b:   1c 31                     sbb    $0x31,%al
Code;  c016f1c0 <ramdisk_updatepage+30/e8>
   d:   c0 89 f9 8a 47 17 8b      rorb   $0x8b,0x17478af9(%ecx)

 kernel BUG at rd.c:110!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c016f1b3>]    Not tainted
EFLAGS: 00010246
eax: 01000041   ebx: c1063368   ecx: c1063368   edx: c1063368
esi: 0000000f   edi: 0000000f   ebp: c2f455fc   esp: c1483ec8
ds: 0018   es: 0018   ss: 0018
Stack: c1063368 0000000f 0000000f c2f455fc c0122b2f c1063368 c016f285 c1063368
       00000001 c1063368 c012d4e0 c1516340 c1063368 c1516384 00000002 00000000
       c2f45560 0000000f 0000007f c104c850 c105dca4 c012d620 c1516340 00000000
Call Trace: [<c0122b2f>] [<c016f285>] [<c012d4e0>] [<c012d620>] [<c012306b>]
   [<c01235ca>] [<c012349c>] [<c012f176>] [<c0108757>]
Code: 0f 0b 6e 00 2c 3b 1d c0 8b 7c 24 1c 31 c0 89 f9 8a 47 17 8b


>>EIP; c016f1b3 <ramdisk_updatepage+23/e8>   <=====

>>eax; 01000041 Before first symbol
>>ebx; c1063368 <END_OF_CODE+e08b5c/????>
>>ecx; c1063368 <END_OF_CODE+e08b5c/????>
>>edx; c1063368 <END_OF_CODE+e08b5c/????>
>>ebp; c2f455fc <END_OF_CODE+2ceadf0/????>
>>esp; c1483ec8 <END_OF_CODE+12296bc/????>

Trace; c0122b2f <add_to_page_cache_unique+3b/44>
Trace; c016f285 <ramdisk_readpage+d/1c>
Trace; c012d4e0 <do_page_cache_readahead+110/154>
Trace; c012d620 <page_cache_readahead+fc/104>
Trace; c012306b <do_generic_file_read+5f/2a0>
Trace; c01235ca <generic_file_read+7e/12c>
Trace; c012349c <file_read_actor+0/b0>
Trace; c012f176 <sys_read+96/f0>
Trace; c0108757 <syscall_call+7/b>

Code;  c016f1b3 <ramdisk_updatepage+23/e8>
00000000 <_EIP>:
Code;  c016f1b3 <ramdisk_updatepage+23/e8>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c016f1b5 <ramdisk_updatepage+25/e8>
   2:   6e                        outsb  %ds:(%esi),(%dx)
Code;  c016f1b6 <ramdisk_updatepage+26/e8>
   3:   00 2c 3b                  add    %ch,(%ebx,%edi,1)
Code;  c016f1b9 <ramdisk_updatepage+29/e8>
   6:   1d c0 8b 7c 24            sbb    $0x247c8bc0,%eax
Code;  c016f1be <ramdisk_updatepage+2e/e8>
   b:   1c 31                     sbb    $0x31,%al
Code;  c016f1c0 <ramdisk_updatepage+30/e8>
   d:   c0 89 f9 8a 47 17 8b      rorb   $0x8b,0x17478af9(%ecx)


If you need more information, please ask

Rudmer
