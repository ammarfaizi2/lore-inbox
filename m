Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262095AbSJDPjt>; Fri, 4 Oct 2002 11:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262098AbSJDPjt>; Fri, 4 Oct 2002 11:39:49 -0400
Received: from tailtiu.davidcoulson.net ([194.159.156.4]:48575 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S262095AbSJDPjq>; Fri, 4 Oct 2002 11:39:46 -0400
Message-ID: <3D9DB7A8.7050604@davidcoulson.net>
Date: Fri, 04 Oct 2002 16:45:44 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020915
X-Accept-Language: en-gb
MIME-Version: 1.0
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Latest host kernel problem with UML
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from a machine running 2.4.20-pre7 with an uptime of nearly 9 
days. It has been running fine since booting, without any other 
problems. I killed the UML who's pid is listed, and restarted it and it 
seems to work fine. The UML had been idle, and I simply switched to it's 
console and typed 'w'. I assume something was swapped back in (or 
attempted to be) at this point.

Reading Oops report from the terminal
  kernel BUG at page_alloc.c:102!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c012f5f2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0100001c   ebx: c191a030   ecx: c191a030   edx: 00000000
esi: 00000000   edi: c02dda10   ebp: 00035000   esp: d4cf1e1c
ds: 0018   es: 0018   ss: 0018
Process linux-8um (pid: 8251, stackpage=d4cf1000)
Stack: c191a030 0000000c c02dda10 00035000 00000002 c1c14000 00000000 
c027dfd4
        c1030020 c027dfec 00000203 ffffffff 0000886d c012fe38 c0130288 
c191a030
        c0123f93 c191a030 00000007 c0124589 308ab027 e327ac80 c51573c0 
8359b000
Call Trace:    [<c012fe38>] [<c0130288>] [<c0123f93>] [<c0124589>] 
[<c0126dc0>]
   [<c01155c0>] [<c011a0a4>] [<c011f592>] [<c0108711>] [<c01d937e>] 
[<c01367b1>]
   [<c01088f8>]
Code: 0f 0b 66 00 41 96 24 c0 89 d8 2b 05 30 0e 30 c0 69 c0 ab aa


 >>EIP; c012f5f2 <kmem_find_general_cachep+1bea/2090>   <=====

 >>ebx; c191a030 <___strtok+15e4eb0/384ccee0>
 >>ecx; c191a030 <___strtok+15e4eb0/384ccee0>
 >>edi; c02dda10 <kmap_prot+824/10034>
 >>esp; d4cf1e1c <___strtok+149bcc9c/384ccee0>

Trace; c012fe38 <__free_pages+1c/20>
Trace; c0130288 <free_pages+44c/2204>
Trace; c0123f93 <flush_scheduled_tasks+673/d0c>
Trace; c0124589 <flush_scheduled_tasks+c69/d0c>
Trace; c0126dc0 <do_brk+330/610>
Trace; c01155c0 <remove_wait_queue+318/1484>
Trace; c011a0a4 <exit_mm+414/630>
Trace; c011f592 <exit_sighand+146/148>
Trace; c0108711 <__read_lock_failed+fa9/1520>
Trace; c01d937e <sock_recvmsg+20a/7b8>
Trace; c01367b1 <default_llseek+4a9/c50>
Trace; c01088f8 <__read_lock_failed+1190/1520>

Code;  c012f5f2 <kmem_find_general_cachep+1bea/2090>
00000000 <_EIP>:
Code;  c012f5f2 <kmem_find_general_cachep+1bea/2090>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012f5f4 <kmem_find_general_cachep+1bec/2090>
    2:   66                        data16
Code;  c012f5f5 <kmem_find_general_cachep+1bed/2090>
    3:   00 41 96                  add    %al,0xffffff96(%ecx)
Code;  c012f5f8 <kmem_find_general_cachep+1bf0/2090>
    6:   24 c0                     and    $0xc0,%al
Code;  c012f5fa <kmem_find_general_cachep+1bf2/2090>
    8:   89 d8                     mov    %ebx,%eax
Code;  c012f5fc <kmem_find_general_cachep+1bf4/2090>
    a:   2b 05 30 0e 30 c0         sub    0xc0300e30,%eax
Code;  c012f602 <kmem_find_general_cachep+1bfa/2090>
   10:   69 c0 ab aa 00 00         imul   $0xaaab,%eax,%eax


David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/

