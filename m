Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318218AbSHIKCx>; Fri, 9 Aug 2002 06:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318220AbSHIKCx>; Fri, 9 Aug 2002 06:02:53 -0400
Received: from smtp2.vol.cz ([195.250.128.42]:57873 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S318218AbSHIKCw>;
	Fri, 9 Aug 2002 06:02:52 -0400
Message-ID: <3D53931A.7060300@illich.cz>
Date: Fri, 09 Aug 2002 12:02:02 +0200
From: Michal Illich <michal@illich.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 crash
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Happened again, now with "kernel BUG at buffer.c:510!" message.
Everything same as before, except:
(a) kernel was recompiled without high memory option
(b) machine was running but not responding at all (no ping)
Seems quite serious to me, any ideas?

--------------------------------------------------------------------------

ksymoops 2.4.4 on i686 2.4.19.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19/ (default)
      -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information. [...]

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Aug  9 10:11:47 [...] kernel: kernel BUG at buffer.c:510!
Aug  9 10:11:47 [...] kernel: invalid operand: 0000
Aug  9 10:11:47 [...] kernel: CPU:    0
Aug  9 10:11:47 [...] kernel: EIP:    0010:[<c01313ee>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  9 10:11:47 [...] kernel: EFLAGS: 00010286
Aug  9 10:11:47 [...] kernel: eax: df5ea969   ebx: 00000002   ecx: d50c0040 
   edx: c02d2794
Aug  9 10:11:47 [...] kernel: esi: d50c0040   edi: 00000001   ebp: d50c0040 
   esp: e5005e68
Aug  9 10:11:47 [...] kernel: ds: 0018   es: 0018   ss: 0018
Aug  9 10:11:47 [...] kernel: Process [...] (pid: 14320, stackpage=e5005000)
Aug  9 10:11:47 [...] kernel: Stack: 00000002 c0131c93 d50c0040 00000002 
d757b300 00000000 c0132493 d50c0040
Aug  9 10:11:47 [...] kernel:        d50c0040 00001000 c0131ca9 d50c0040 
c01326f6 d50c0040 00001000 00000000
Aug  9 10:11:47 [...] kernel:        00001000 0b2ae000 00000000 d757b300 
c0132d32 d757b300 c144fb10 00000000
Aug  9 10:11:47 [...] kernel: Call Trace:    [<c0131c93>] [<c0132493>] 
[<c0131ca9>] [<c01326f6>] [<c0132d32>]
Aug  9 10:11:47 [...] kernel:   [<c0153045>] [<c01528a0>] [<c01261b8>] 
[<c011b5dd>] [<c0130175>] [<c011790b>]
Aug  9 10:11:47 [...] kernel:   [<c010878b>]
Aug  9 10:11:48 [...] kernel: Code: 0f 0b fe 01 ba 2f 24 c0 8b 02 85 c0 75 
07 89 0a 89 49 24 8b

 >>EIP; c01313ee <__insert_into_lru_list+1e/70>   <=====
Trace; c0131c93 <__refile_buffer+53/60>
Trace; c0132493 <__block_prepare_write+103/2e0>
Trace; c0131ca9 <refile_buffer+9/10>
Trace; c01326f6 <__block_commit_write+86/d0>
Trace; c0132d32 <generic_commit_write+32/60>
Trace; c0153045 <ext3_commit_write+135/1c0>
Trace; c01528a0 <ext3_get_block+0/60>
Trace; c01261b8 <generic_file_write+4e8/6e0>
Trace; c011b5dd <do_timer+3d/70>
Trace; c0130175 <sys_write+95/f0>
Trace; c011790b <sys_gettimeofday+1b/a0>
Trace; c010878b <system_call+33/38>
Code;  c01313ee <__insert_into_lru_list+1e/70>
00000000 <_EIP>:
Code;  c01313ee <__insert_into_lru_list+1e/70>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c01313f0 <__insert_into_lru_list+20/70>
    2:   fe 01                     incb   (%ecx)
Code;  c01313f2 <__insert_into_lru_list+22/70>
    4:   ba 2f 24 c0 8b            mov    $0x8bc0242f,%edx
Code;  c01313f7 <__insert_into_lru_list+27/70>
    9:   02 85 c0 75 07 89         add    0x890775c0(%ebp),%al
Code;  c01313fd <__insert_into_lru_list+2d/70>
    f:   0a 89 49 24 8b 00         or     0x8b2449(%ecx),%cl

Aug  9 10:11:48 [...] kernel:  <1>Unable to handle kernel paging request at 
virtual address 546a53b8

2 warnings issued.  Results may not be reliable.

