Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbTHZQRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTHZQRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:17:19 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:19342 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S261652AbTHZQRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:17:09 -0400
Date: Tue, 26 Aug 2003 18:15:57 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org, <sct@redhat.com>, <akpm@osdl.org>
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164 
In-Reply-To: <Pine.LNX.4.44.0308261754390.950-100000@neptune.local>
Message-ID: <Pine.LNX.4.44.0308261811240.1021-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003, Pascal Schmidt wrote:

> I've just updated to 2.4.22-rc3 (since bkcvs doesn't seem to have
> final 2.4.22 yet). There, the BUG is not triggered.

Sigh. I spoke too soon. Turns out I have two different versions of
fsx.c around. The one that caused the BUG before still does, but
it's a different one now:

Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 84449)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 84450)
Unexpected dirty buffer encountered at do_get_write_access:616 (03:07 blocknr 84451)
Assertion failure in journal_commit_transaction() at commit.c:712: "!(((bh)->b_state & (1UL << BH_Dirty)) != 0)"
kernel BUG at commit.c:712!

ksymoops 2.4.4 on i686 2.4.22-rc3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc3/ (default)
     -m /boot/System.map-2.4.22-rc3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at commit.c:712!
invalid operand: 0000
CPU:    0
EIP:    0010:[journal_commit_transaction+4387/4881]    Not tainted
EIP:    0010:[<c015fd63>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000074   ebx: e605b9c0   ecx: ffffffff   edx: e6ccff44
esi: 00000000   edi: e42207c0   ebp: 00000000   esp: e609fe08
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 1523, stackpage=e609f000)
Stack: c02d9640 c02d53bf c02d53b6 000002c8 c02dc3e0 e7c44880 00000000 00000f2c 
       e2a8a0d4 00000000 00000000 e752b440 e605b270 00000b07 00000000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:    [schedule+786/832] [kjournald+371/704] [commit_timeout+0/16] [arch_kernel_thread+38/48] [kjournald+0/704]
Call Trace:    [<c0114662>] [<c01620e3>] [<c0161f50>] [<c0107116>] [<c0161f70>]
Code: 0f 0b c8 02 b6 53 2d c0 83 c4 14 8b 73 18 85 f6 74 29 68 c0 

>>EIP; c015fd63 <journal_commit_transaction+1123/1311>   <=====
Trace; c0114662 <schedule+312/340>
Trace; c01620e3 <kjournald+173/2c0>
Trace; c0161f50 <commit_timeout+0/10>
Trace; c0107116 <arch_kernel_thread+26/30>
Trace; c0161f70 <kjournald+0/2c0>
Code;  c015fd63 <journal_commit_transaction+1123/1311>
00000000 <_EIP>:
Code;  c015fd63 <journal_commit_transaction+1123/1311>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015fd65 <journal_commit_transaction+1125/1311>
   2:   c8 02 b6 53               enter  $0xb602,$0x53
Code;  c015fd69 <journal_commit_transaction+1129/1311>
   6:   2d c0 83 c4 14            sub    $0x14c483c0,%eax
Code;  c015fd6e <journal_commit_transaction+112e/1311>
   b:   8b 73 18                  mov    0x18(%ebx),%esi
Code;  c015fd71 <journal_commit_transaction+1131/1311>
   e:   85 f6                     test   %esi,%esi
Code;  c015fd73 <journal_commit_transaction+1133/1311>
  10:   74 29                     je     3b <_EIP+0x3b> c015fd9e <journal_commit_transaction+115e/1311>
Code;  c015fd75 <journal_commit_transaction+1135/1311>
  12:   68 c0 00 00 00            push   $0xc0


1 warning and 1 error issued.  Results may not be reliable.

-- 
Ciao,
Pascal

