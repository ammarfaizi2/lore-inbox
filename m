Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263382AbTDGLVh (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbTDGLVh (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:21:37 -0400
Received: from kestrel.vispa.uk.net ([62.24.228.12]:50695 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id S263382AbTDGLVf (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 07:21:35 -0400
Message-ID: <3E916F8E.2050309@walrond.org>
Date: Mon, 07 Apr 2003 13:31:10 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5-bk Oops : kernel BUG at fs/dcache.c:765!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have replicated this problem on both 2.4-bk and 2.5-bk. It occurs 50% 
of boots during early boot script processing

kernel BUG at fs/dcache.c:765!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c016edb3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: f7a77e20   ebx: f7dc9300   ecx: 00000000   edx: 00000000
esi: f7a77e20   edi: f7a73a48   ebp: f7a73a20   esp: f7aade30
ds: 007b   es: 007b   ss: 0068
Stack: 00000001 f7dc9300 f7aac000 f7dd5ba0 f7a73a20 c01b7368 f7a73a20 
f7a77e20
        f7a73a20 f7ab1e10 f7fe28c0 00000000 f7ae52d0 c011bde0 00000000 
00000000
        f7ae0080 00000246 f7bb2940 00000000 f7ae52d0 c011bde0 00000000 
00000000
Call Trace: [<c01b7368>]  [<c011bde0>]  [<c011bde0>]  [<c01642ed>] 
[<c0164867>]  [<c011971c>]  [<c01656ce>]  [<c01550d3>]  [<c01556db>] 
[<c010950b>]
Code: 0f 0b fd 02 66 22 30 c0 bb 00 e0 ff ff 21 e3 ff 43 14 31 c0


 >>EIP; c016edb3 <d_instantiate+23/b0>   <=====

Trace; c01b7368 <devfs_d_revalidate_wait+d8/1d0>
Trace; c011bde0 <default_wake_function+0/20>
Trace; c011bde0 <default_wake_function+0/20>
Trace; c01642ed <do_lookup+6d/c0>
Trace; c0164867 <link_path_walk+527/9f0>
Trace; c011971c <do_page_fault+20c/43f>
Trace; c01656ce <open_namei+7e/460>
Trace; c01550d3 <filp_open+43/70>
Trace; c01556db <sys_open+5b/90>
Trace; c010950b <syscall_call+7/b>

Code;  c016edb3 <d_instantiate+23/b0>
00000000 <_EIP>:
Code;  c016edb3 <d_instantiate+23/b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c016edb5 <d_instantiate+25/b0>
    2:   fd                        std
Code;  c016edb6 <d_instantiate+26/b0>
    3:   02 66 22                  add    0x22(%esi),%ah
Code;  c016edb9 <d_instantiate+29/b0>
    6:   30 c0                     xor    %al,%al
Code;  c016edbb <d_instantiate+2b/b0>
    8:   bb 00 e0 ff ff            mov    $0xffffe000,%ebx
Code;  c016edc0 <d_instantiate+30/b0>
    d:   21 e3                     and    %esp,%ebx
Code;  c016edc2 <d_instantiate+32/b0>
    f:   ff 43 14                  incl   0x14(%ebx)
Code;  c016edc5 <d_instantiate+35/b0>
   12:   31 c0                     xor    %eax,%eax

