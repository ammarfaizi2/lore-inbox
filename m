Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSJPMzh>; Wed, 16 Oct 2002 08:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262458AbSJPMzh>; Wed, 16 Oct 2002 08:55:37 -0400
Received: from stine.vestdata.no ([195.204.68.10]:39315 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S262457AbSJPMzf>; Wed, 16 Oct 2002 08:55:35 -0400
Date: Wed, 16 Oct 2002 15:01:31 +0200
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@zet.no>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG at swap.c:62 [2.4.19 vanilla]
Message-ID: <20021016150131.F26786@stine.vestdata.no>
Reply-To: tlan@zet.no
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reading Oops report from the terminal
kernel BUG at swap.c:62! 
kernel BUG at swap.c:62! 
invalid operand: 0000 
CPU:    1 
EIP:    0010:[<c01329ca>]    Not tainted 
EFLAGS: 00010202 
invalid operand: 0000 
CPU:    1 
EIP:    0010:[<c01329ca>]    Not tainted 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202 
eax: 020008c1   ebx: c2302140   ecx: c2302140   edx: f7d514e4 
esi: 00000000   edi: f7d514e4   ebp: cf5439b0   esp: c6f0bee8 
ds: 0018   es: 0018   ss: 0018 
Process perl (pid: 16439, stackpage=c6f0b000) 
Stack: c012bc22 c2302140 f7d514e4 c2302140 c012e2b3 c2302140 cf5439b0 00000000  
        f7d514e4 00000001 00000286 00000003 00000001 f0f6a780 00000fff bfffd118  
        bfffe118 c01481b2 cf5439b0 00000000 c0162aa0 00000000 bfffe118 c0164453  
Call Trace:    [<c012bc22>] [<c012e2b3>] [<c01481b2>] [<c0162aa0>] [<c0164453>] 
eax: 020008c1   ebx: c2302140   ecx: c2302140   edx: f7d514e4 
esi: 00000000   edi: f7d514e4   ebp: cf5439b0   esp: c6f0bee8 
ds: 0018   es: 0018   ss: 0018 
Process perl (pid: 16439, stackpage=c6f0b000) 
Stack: c012bc22 c2302140 f7d514e4 c2302140 c012e2b3 c2302140 cf5439b0 00000000  
        f7d514e4 00000001 00000286 00000003 00000001 f0f6a780 00000fff bfffd118  
        bfffe118 c01481b2 cf5439b0 00000000 c0162aa0 00000000 bfffe118 c0164453  
Call Trace:    [<c012bc22>] [<c012e2b3>] [<c01481b2>] [<c0162aa0>] [<c0164453>] 
   [<c0148262>] [<c014f07e>] [<c0142600>] [<c0108b3b>] 
  
Code: 0f 0b 3e 00 f2 02 29 c0 8b 15 1c 6c 2d c0 8d 41 1c 89 42 04  
   [<c0148262>] [<c014f07e>] [<c0142600>] [<c0108b3b>] 
Code: 0f 0b 3e 00 f2 02 29 c0 8b 15 1c 6c 2d c0 8d 41 1c 89 42 04  

>>EIP; c01329ca <lru_cache_add+3a/70>   <=====
Trace; c012bc22 <add_to_page_cache_unique+82/90>
Trace; c012e2b3 <read_cache_page+73/120>
Trace; c01481b2 <page_getlink+22/b0>
Trace; c0162aa0 <ext3_readpage+0/20>
Trace; c0164453 <ext3_dirty_inode+a3/100>
Trace; c0148262 <page_readlink+22/90>
Trace; c014f07e <__mark_inode_dirty+2e/a0>
Trace; c0142600 <sys_readlink+80/a0>
Trace; c0108b3b <system_call+33/38>
Code;  c01329ca <lru_cache_add+3a/70>
00000000 <_EIP>:
Code;  c01329ca <lru_cache_add+3a/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01329cc <lru_cache_add+3c/70>
   2:   3e                        ds
Code;  c01329cd <lru_cache_add+3d/70>
   3:   00 f2                     add    %dh,%dl
Code;  c01329cf <lru_cache_add+3f/70>
   5:   02 29                     add    (%ecx),%ch
Code;  c01329d1 <lru_cache_add+41/70>
   7:   c0 8b 15 1c 6c 2d c0      rorb   $0xc0,0x2d6c1c15(%ebx)
Code;  c01329d8 <lru_cache_add+48/70>
   e:   8d 41 1c                  lea    0x1c(%ecx),%eax
Code;  c01329db <lru_cache_add+4b/70>
  11:   89 42 04                  mov    %eax,0x4(%edx)


This is a vanilla 2.4.19 kernel, and we've seen this bug on several machines,
but we haven't been able to find out what triggers it. And I don't see a
BUG-statement at swap.c line 62.  So, anyone with an idea of what to do is
welcome with suggestions :)

-- 
Thomas
