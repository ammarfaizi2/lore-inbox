Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSKUJXW>; Thu, 21 Nov 2002 04:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266462AbSKUJXW>; Thu, 21 Nov 2002 04:23:22 -0500
Received: from mortar.viawest.net ([216.87.64.7]:24269 "EHLO
	mortar.viawest.net") by vger.kernel.org with ESMTP
	id <S266460AbSKUJXU>; Thu, 21 Nov 2002 04:23:20 -0500
Date: Thu, 21 Nov 2002 01:30:21 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19: deleting files on hfs causes oops
Message-ID: <20021121093021.GA17678@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.4.19 (i686)
X-uptime: 01:15:49 up 24 days, 12:49,  2 users,  load average: 0.22, 0.25, 0.25
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Subject sez it all. Want more? you got it.

        disk is a LS-120 superdisk, USB, Mac format, mounted under hfs. tried 
to delete a file that wasn't being used. from syslog, looks like it was rm 
that did the damage. lsmod follows:

Module                  Size  Used by    Not tainted
ppp_async               6528   1 (autoclean)
ppp_generic            15936   3 (autoclean) [ppp_async]
slhc                    4640   1 (autoclean) [ppp_generic]
serial                 45572   1 (autoclean)
isa-pnp                28612   0 (autoclean) [serial]
snd-pcm-oss            45028   0
hfs                    74048   1 (autoclean)
usb-storage            21140   1
snd-mixer-oss          10876   1 (autoclean) [snd-pcm-oss]
snd-fm801               7500   1
snd-pcm                58656   0 [snd-pcm-oss snd-fm801]
snd-mpu401-uart         2944   0 [snd-fm801]
snd-rawmidi            14048   0 [snd-mpu401-uart]
snd-opl3-lib            6052   0 [snd-fm801]
snd-timer              11720   0 [snd-pcm snd-opl3-lib]
snd-hwdep               4032   0 [snd-opl3-lib]
snd-seq-device          4048   0 [snd-rawmidi snd-opl3-lib]
snd-ac97-codec         24292   0 [snd-fm801]
snd                    30444   0 [snd-pcm-oss snd-mixer-oss snd-fm801 snd-pcm 
snd-mpu401-uart snd-rawmidi snd-opl3-lib snd-timer snd-hwdep snd-seq-device 
snd-ac97-codec]
soundcore               3652   6 [snd]
sd_mod                 10092   2 (autoclean)
usb-uhci               21548   0 (unused)
usbcore                55648   0 [usb-storage usb-uhci]
sr_mod                 13360   2
cdrom                  29216   0 [sr_mod]
ide-scsi                7664   1
scsi_mod               82504   4 [usb-storage sd_mod sr_mod ide-scsi]
softdog                 1628   1 (autoclean)
ipt_LOG                 3128   2 (autoclean)
ipt_limit                920   4 (autoclean)
ipt_MASQUERADE          1688   1 (autoclean)
ipt_state                600   4
ip_nat_ftp              3440   0 (unused)
ip_conntrack_ftp        3424   0 [ip_nat_ftp]
iptable_filter          1704   1
iptable_nat            18488   2 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack           20252   3 [ipt_MASQUERADE ipt_state ip_nat_ftp 
ip_conntrack_ftp iptable_nat]
ip_tables              13048   8 [ipt_LOG ipt_limit ipt_MASQUERADE ipt_state 
iptable_filter iptable_nat]
eepro100               18744   1 (autoclean)
reiserfs              159472  11 (autoclean)
unix                   13608  90 (autoclean)

        Oops follows, with trace afterwards:

-- snip --

ksymoops 2.4.7 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map (specified)

Nov 21 01:02:28 bellicha kernel: kernel BUG in header file at line 247
Nov 21 01:02:28 bellicha kernel: kernel BUG at panic.c:141!
Nov 21 01:02:28 bellicha kernel: invalid operand: 0000
Nov 21 01:02:28 bellicha kernel: CPU:    0
Nov 21 01:02:28 bellicha kernel: EIP:    0010:[<c011791f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 21 01:02:28 bellicha kernel: EFLAGS: 00010282
Nov 21 01:02:28 bellicha kernel: eax: 00000026   ebx: ce326790   ecx: de984000   edx: da26c154
Nov 21 01:02:28 bellicha kernel: esi: 00000001   edi: dc41a60c   ebp: c8703820   esp: de985f1c
Nov 21 01:02:28 bellicha kernel: ds: 0018   es: 0018   ss: 0018
Nov 21 01:02:28 bellicha kernel: Process rm (pid: 17446, stackpage=de985000)
Nov 21 01:02:28 bellicha kernel: Stack: c0214be0 000000f7 e3169da9 000000f7 ffffffff d068fd6c cfec8d00 de985fa4 
Nov 21 01:02:28 bellicha kernel:        c7a20c20 00000000 c7a20c00 00003d0e 70084601 2e5f7073 5f666967 5f64de98 
Nov 21 01:02:28 bellicha kernel:        8d00de98 3b30cfec fd6cce4b 0678d068 0000e317 c013f91a d068fd6c cfec8d00 
Nov 21 01:02:28 bellicha kernel: Call Trace:    [<e3169da9>] [<c013f91a>] [<c013fa08>] [<c01086ff>]
Nov 21 01:02:28 bellicha kernel: Code: 0f 0b 8d 00 06 4c 21 c0 eb fe 90 90 90 90 90 90 90 83 ec 18 


>>EIP; c011791f <__out_of_line_bug+f/20>   <=====

>>ebx; ce326790 <_end+e0559a0/2254b210>
>>ecx; de984000 <_end+1e6b3210/2254b210>
>>edx; da26c154 <_end+19f9b364/2254b210>
>>edi; dc41a60c <_end+1c14981c/2254b210>
>>ebp; c8703820 <_end+8432a30/2254b210>
>>esp; de985f1c <_end+1e6b512c/2254b210>

Trace; e3169da9 <[hfs]hfs_unlink+c9/190>
Trace; c013f91a <vfs_unlink+fa/140>
Trace; c013fa08 <sys_unlink+a8/120>
Trace; c01086ff <system_call+33/38>

Code;  c011791f <__out_of_line_bug+f/20>
00000000 <_EIP>:
Code;  c011791f <__out_of_line_bug+f/20>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0117921 <__out_of_line_bug+11/20>
   2:   8d 00                     lea    (%eax),%eax
Code;  c0117923 <__out_of_line_bug+13/20>
   4:   06                        push   %es
Code;  c0117924 <__out_of_line_bug+14/20>
   5:   4c                        dec    %esp
Code;  c0117925 <__out_of_line_bug+15/20>
   6:   21 c0                     and    %eax,%eax
Code;  c0117927 <__out_of_line_bug+17/20>
   8:   eb fe                     jmp    8 <_EIP+0x8> c0117927 <__out_of_line_bug+17/20>
Code;  c0117929 <__out_of_line_bug+19/20>
   a:   90                        nop    
Code;  c011792a <__out_of_line_bug+1a/20>
   b:   90                        nop    
Code;  c011792b <__out_of_line_bug+1b/20>
   c:   90                        nop    
Code;  c011792c <__out_of_line_bug+1c/20>
   d:   90                        nop    
Code;  c011792d <__out_of_line_bug+1d/20>
   e:   90                        nop    
Code;  c011792e <__out_of_line_bug+1e/20>
   f:   90                        nop    
Code;  c011792f <__out_of_line_bug+1f/20>
  10:   90                        nop    
Code;  c0117930 <do_syslog+0/2e0>
  11:   83 ec 18                  sub    $0x18,%esp

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

