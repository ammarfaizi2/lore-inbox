Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313827AbSDIIno>; Tue, 9 Apr 2002 04:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313828AbSDIInn>; Tue, 9 Apr 2002 04:43:43 -0400
Received: from mail.spylog.com ([194.67.35.220]:54144 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S313827AbSDIInm>;
	Tue, 9 Apr 2002 04:43:42 -0400
Date: Tue, 9 Apr 2002 12:43:35 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: BUG: 2.4.19-pre6aa1
Message-ID: <20020409084335.GA10890@spylog.ru>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

1. kernel 2.4.19-pre6aa1, 1CPU, highmem 4Gb, userspace 3.5Gb
 
2. log from serial console:

...
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 252k freed
INIT: version 2.78 booting
kernel BUG at panic.c:139!
invalid operand: 0000
CPU:    0
EIP:    0010:[<e0115c1c>]    Not tainted
EFLAGS: 00010202
eax: e27d3260   ebx: 3ffe5005   ecx: 00000120   edx: ffff02b0
esi: ffff02b0   edi: ffff12b0   ebp: 080ad000   esp: e1c17f1c
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, stackpage=e1c17000)
Stack: e012069b e27d3130 e1c16000 e27d3158 e27d5134 00000001 080ad000 e27de080 
       e27d4080 e0114caa e27d5134 e27d50a4 e27d3260 e27ca000 e27d6584 e27d6aa4 
       00000011 e27d3260 e27d50a4 e27d50c0 e1c16000 e27d326c e01154b7 00000011 
Call Trace: [<e012069b>] [<e0114caa>] [<e01154b7>] [<e0107270>] [<e010858b>] 

Code: 0f 0b 8b 00 36 f5 25 e0 eb fe 8d 76 00 8d bc 27 00 00 00 00 
 <0>Kernel panic: Attempted to kill init!


 3. keymoops :

..

>>EIP; e0115c1c <out_of_line_bug+0/14>   <=====
Trace; e012069a <copy_page_range+1da/334>
Trace; e0114caa <copy_mm+222/2bc>
Trace; e01154b6 <do_fork+42e/744>
Trace; e0107270 <sys_fork+14/1c>
Trace; e010858a <system_call+32/38>
Code;  e0115c1c <out_of_line_bug+0/14>
00000000 <_EIP>:
Code;  e0115c1c <out_of_line_bug+0/14>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e0115c1e <out_of_line_bug+2/14>
   2:   8b 00                     mov    (%eax),%eax
Code;  e0115c20 <out_of_line_bug+4/14>
   4:   36                        ss
Code;  e0115c20 <out_of_line_bug+4/14>
   5:   f5                        cmc    
Code;  e0115c22 <out_of_line_bug+6/14>
   6:   25 e0 eb fe 8d            and    $0x8dfeebe0,%eax
Code;  e0115c26 <out_of_line_bug+a/14>
   b:   76 00                     jbe    d <_EIP+0xd> e0115c28
<out_of_line_bug+c/14>
Code;  e0115c28 <out_of_line_bug+c/14>
   d:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi




-- 
bye.
Andrey Nekrasov, SpyLOG.
