Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSLINgH>; Mon, 9 Dec 2002 08:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSLINgH>; Mon, 9 Dec 2002 08:36:07 -0500
Received: from 213-97-251-19.uc.nombres.ttd.es ([213.97.251.19]:1952 "EHLO
	linalco.com") by vger.kernel.org with ESMTP id <S265787AbSLINgF>;
	Mon, 9 Dec 2002 08:36:05 -0500
Date: Mon, 9 Dec 2002 14:43:17 +0100
From: Ragnar Hojland Espinosa <ragnar@linalco.com>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.20
Message-ID: <20021209134317.GA16395@linalco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a present we got this morning (insert / remove _into_lru_list?)

-- 
Ragnar Hojland - Project Manager
Linalco "Especialistas Linux y en Software Libre"
http://www.linalco.com Tel: +34-91-5970074 Fax: +34-91-5970083

ksymoops 2.4.6 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.20 failed
kernel BUG at buffer.c:509!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012fff8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 00000002   ecx: c844b200   edx: c02f212c
esi: c844b200   edi: c844b200   ebp: 00000001   esp: c3405ee4
ds: 0018   es: 0018   ss: 0018
Process rsync (pid: 23054, stackpage=c3405000)
Stack: 00000002 c013081c c844b200 00000002 c844b200 00001000 c013082e c844b200
       c01311b3 c844b200 00000360 ccb73480 0036b360 00000000 00001000 00000000
       c01317f0 ccb73480 c109a964 00000000 00000360 c109a964 082a3038 c3836360
Call Trace:    [<c013081c>] [<c013082e>] [<c01311b3>] [<c01317f0>] [<c012529b>]
  [<c012ee56>] [<c0106bc7>]
Code: 0f 0b fd 01 20 be 24 c0 83 3a 00 75 05 89 0a 89 49 24 8b 02


>>EIP; c012fff8 <file_fsync+1cc/2a0>   <=====

>>ecx; c844b200 <___strtok+8132c20/108faa80>
>>edx; c02f212c <zone_table+fec/1cd8>
>>esi; c844b200 <___strtok+8132c20/108faa80>
>>edi; c844b200 <___strtok+8132c20/108faa80>
>>esp; c3405ee4 <___strtok+30ed904/108faa80>

Trace; c013081c <set_buffer_flushtime+68/70>
Trace; c013082e <refile_buffer+a/10>
Trace; c01311b3 <create_empty_buffers+587/5d0>
Trace; c01317f0 <generic_commit_write+34/60>
Trace; c012529b <generic_file_write+4e3/1f84>
Trace; c012ee56 <default_llseek+39e/a08>
Trace; c0106bc7 <__up_wakeup+1013/13d4>

Code;  c012fff8 <file_fsync+1cc/2a0>
00000000 <_EIP>:
Code;  c012fff8 <file_fsync+1cc/2a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012fffa <file_fsync+1ce/2a0>
   2:   fd                        std    
Code;  c012fffb <file_fsync+1cf/2a0>
   3:   01 20                     add    %esp,(%eax)
Code;  c012fffd <file_fsync+1d1/2a0>
   5:   be 24 c0 83 3a            mov    $0x3a83c024,%esi
Code;  c0130002 <file_fsync+1d6/2a0>
   a:   00 75 05                  add    %dh,0x5(%ebp)
Code;  c0130005 <file_fsync+1d9/2a0>
   d:   89 0a                     mov    %ecx,(%edx)
Code;  c0130007 <file_fsync+1db/2a0>
   f:   89 49 24                  mov    %ecx,0x24(%ecx)
Code;  c013000a <file_fsync+1de/2a0>
  12:   8b 02                     mov    (%edx),%eax


1 warning and 1 error issued.  Results may not be reliable.
