Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTD3G31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 02:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTD3G31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 02:29:27 -0400
Received: from mail.ithnet.com ([217.64.64.8]:19731 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262093AbTD3G30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 02:29:26 -0400
Date: Wed, 30 Apr 2003 08:41:36 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc1-ac3
Message-Id: <20030430084136.5f6c871a.skraw@ithnet.com>
In-Reply-To: <200304281704.h3SH4d609033@devserv.devel.redhat.com>
References: <200304281704.h3SH4d609033@devserv.devel.redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I got the following oops from ac3 this morning. This occured while tar-ing about 70G of data to a tape.


Apr 30 07:17:58 admin kernel: kernel BUG at page_alloc.c:100!
Apr 30 07:17:58 admin kernel: invalid operand: 0000
Apr 30 07:17:58 admin kernel: CPU:    1
Apr 30 07:17:58 admin kernel: EIP:    0010:[__free_pages_ok+68/704]    Not tainted
Apr 30 07:17:58 admin kernel: EIP:    0010:[<c0139bd4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 30 07:17:58 admin kernel: EFLAGS: 00010286
Apr 30 07:17:58 admin kernel: eax: c30f64fc   ebx: c1e6c480   ecx: c1e6c49c   edx: c1f71d0c
Apr 30 07:17:58 admin kernel: esi: c1e6c480   edi: 00000000   ebp: f3008f00   esp: d03c5ee0
Apr 30 07:17:58 admin kernel: ds: 0018   es: 0018   ss: 0018
Apr 30 07:17:58 admin kernel: Process tar (pid: 19174, stackpage=d03c5000)
Apr 30 07:17:58 admin kernel: Stack: c014029c c1e6c480 00000000 00001000 c0131f05 0000001f 00000000 00007000 
Apr 30 07:17:58 admin kernel:        00001000 c1e6c480 d7f7f374 0004f2cc c013196b d03c5f74 c1e6c480 00000000 
Apr 30 07:17:58 admin kernel:        00001000 00001000 00000001 00000000 00000000 d7f7f2c0 c0131e30 d03c5f74 
Apr 30 07:17:58 admin kernel: Call Trace:    [kmap_high+92/112] [file_read_actor+213/256] [do_generic_file_read+619/1184] [file_read_actor+0/256] [generic_file_read+168/336]
Apr 30 07:17:58 admin kernel: Call Trace:    [<c014029c>] [<c0131f05>] [<c013196b>] [<c0131e30>] [<c0131fd8>]
Apr 30 07:17:58 admin kernel:   [<c0131e30>] [<c01427e3>] [<c010760f>]
Apr 30 07:17:58 admin kernel: Code: 0f 0b 64 00 00 bc 29 c0 8b 73 08 85 f6 74 08 0f 0b 66 00 00 


>>EIP; c0139bd4 <__free_pages_ok+44/2c0>   <=====

>>eax; c30f64fc <_end+2d5df84/38541ae8>
>>ebx; c1e6c480 <_end+1ad3f08/38541ae8>
>>ecx; c1e6c49c <_end+1ad3f24/38541ae8>
>>edx; c1f71d0c <_end+1bd9794/38541ae8>
>>esi; c1e6c480 <_end+1ad3f08/38541ae8>
>>ebp; f3008f00 <_end+32c70988/38541ae8>
>>esp; d03c5ee0 <_end+1002d968/38541ae8>

Trace; c014029c <kmap_high+5c/70>
Trace; c0131f05 <file_read_actor+d5/100>
Trace; c013196b <do_generic_file_read+26b/4a0>
Trace; c0131e30 <file_read_actor+0/100>
Trace; c0131fd8 <generic_file_read+a8/150>
Trace; c0131e30 <file_read_actor+0/100>
Trace; c01427e3 <sys_read+a3/160>
Trace; c010760f <system_call+33/38>

Code;  c0139bd4 <__free_pages_ok+44/2c0>
00000000 <_EIP>:
Code;  c0139bd4 <__free_pages_ok+44/2c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0139bd6 <__free_pages_ok+46/2c0>
   2:   64 00 00                  add    %al,%fs:(%eax)
Code;  c0139bd9 <__free_pages_ok+49/2c0>
   5:   bc 29 c0 8b 73            mov    $0x738bc029,%esp
Code;  c0139bde <__free_pages_ok+4e/2c0>
   a:   08 85 f6 74 08 0f         or     %al,0xf0874f6(%ebp)
Code;  c0139be4 <__free_pages_ok+54/2c0>
  10:   0b 66 00                  or     0x0(%esi),%esp
