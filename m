Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUGUOF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUGUOF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 10:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUGUOF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 10:05:56 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:9881 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S266473AbUGUOE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 10:04:59 -0400
Message-ID: <40FE78E2.4010502@att.net>
Date: Wed, 21 Jul 2004 10:08:34 -0400
From: Peter Santoro <psantoro@att.net>
Reply-To: psantoro@att.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.26 oops followup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 2.4.26 oops happened when I selected a newsgroup via keyboard (up 
arrow) in mozilla 1.7.  See my previous email for additional details.

Peter Santoro

======== FROM SYSLOG ==========

ksymoops 2.4.9 on i686 2.4.26.  Options used
      -v /usr/src/linux/vmlinux (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.26/ (default)
      -m /usr/src/linux/System.map (default)

kernel BUG at filemap.c:81!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012b684>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210206
eax: 00004000   ebx: c1950db0   ecx: c1989720   edx: f7feeb44
esi: c1950db0   edi: 00000510   ebp: f7feeb44   esp: f5cdbea0
ds: 0018   es: 0018   ss: 0018
Process mozilla-bin (pid: 2349, stackpage=f5cdb000)
Stack: c029f268 00000000 00000000 c012c20b f5bb1eb4 00000510 f7feeb44 
f5d9ea20
c012c2a6 c1950db0 f5bb1eb4 00000510 f7feeb44 c1950db0 00000510 0000001b
f5d9ea20 000004f4 c012c95c 0000001f 00000020 000006f6 f5d9ea20 c1951f20
Call Trace:    [<c012c20b>] [<c012c2a6>] [<c012c95c>] [<c012cd4c>] 
[<c012d190>]
[<c012d32d>] [<c012d190>] [<c013c0c3>] [<c010734f>]
Code: 0f 0b 51 00 16 ab 26 c0 89 1c 24 c7 44 24 04 01 00 00 00 e8


 >>EIP; c012b684 <add_page_to_hash_queue+24/50>   <=====

 >>ebx; c1950db0 <_end+162b718/384ee9c8>
 >>ecx; c1989720 <_end+1664088/384ee9c8>
 >>edx; f7feeb44 <_end+37cc94ac/384ee9c8>
 >>esi; c1950db0 <_end+162b718/384ee9c8>
 >>ebp; f7feeb44 <_end+37cc94ac/384ee9c8>
 >>esp; f5cdbea0 <_end+359b6808/384ee9c8>

Trace; c012c20b <add_to_page_cache_unique+ab/b0>
Trace; c012c2a6 <page_cache_read+96/d0>
Trace; c012c95c <generic_file_readahead+cc/160>
Trace; c012cd4c <do_generic_file_read+32c/490>
Trace; c012d190 <file_read_actor+0/e0>
Trace; c012d32d <generic_file_read+bd/1b0>
Trace; c012d190 <file_read_actor+0/e0>
Trace; c013c0c3 <sys_read+a3/140>
Trace; c010734f <system_call+33/38>

Code;  c012b684 <add_page_to_hash_queue+24/50>
00000000 <_EIP>:
Code;  c012b684 <add_page_to_hash_queue+24/50>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012b686 <add_page_to_hash_queue+26/50>
    2:   51                        push   %ecx
Code;  c012b687 <add_page_to_hash_queue+27/50>
    3:   00 16                     add    %dl,(%esi)
Code;  c012b689 <add_page_to_hash_queue+29/50>
    5:   ab                        stos   %eax,%es:(%edi)
Code;  c012b68a <add_page_to_hash_queue+2a/50>
    6:   26 c0 89 1c 24 c7 44      rorb   $0x24,%es:0x44c7241c(%ecx)
Code;  c012b691 <add_page_to_hash_queue+31/50>
    d:   24
Code;  c012b692 <add_page_to_hash_queue+32/50>
    e:   04 01                     add    $0x1,%al
Code;  c012b694 <add_page_to_hash_queue+34/50>
   10:   00 00                     add    %al,(%eax)
Code;  c012b696 <add_page_to_hash_queue+36/50>
   12:   00 e8                     add    %ch,%al

