Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbTERXYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTERXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:24:51 -0400
Received: from pcp02462394pcs.chrchv01.md.comcast.net ([68.33.20.149]:50180
	"EHLO mail.jettisonnetworks.com") by vger.kernel.org with ESMTP
	id S262268AbTERXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:24:43 -0400
From: "David Lewis" <dlewis@vnxsolutions.com>
To: <linux-kernel@vger.kernel.org>
Subject: OOPS report and ksymoops output
Date: Sun, 18 May 2003 19:35:25 -0400
Message-ID: <EMEOIBCHEHCPNABJGHGOMEFLCNAA.dlewis@vnxsolutions.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am having trouble tracking down the source of the following oops. I am
having trouble on various machines with various hardware configs. Some are
dual p3 with a via chipset, dual xeon with e7500, and i845GL with P4 3.06
with Hyperthreading enabled. The kernel is a stock 2.4.20 with SMP enabled.
All of the platforms are using a Falcon quattro video capture board, which
uses the bttv driver. This is being compiled as a module and is version
0.7.96. This particular oops is from the 845GL, p4 3.06HT, 512 ddr dram,
2x200Gb HD, 1G swap (2 partitions of 512 each).

I dont have any non-smp hardware available to try to recreate this on (until
a few days from now) so I cant say if it only happens with SMP or not. Below
is the OOPS and the ksymoops output. In this example, it was process ffnext
that caused the oops, but normally it seems to be kswapd that is the
offender. If there is any additionaly info I can provide, or if I am posting
to the wrong place, please let me know! I am anxious to get this resolved
and hopefully I can make a contribution to the linux kernel community in the
process.

May 18 16:16:10 nicebox kernel: Unable to handle kernel paging request at
virtual address 8d8f929b

May 18 16:16:10 nicebox kernel: printing eip:

May 18 16:16:10 nicebox kernel: c013593c

May 18 16:16:10 nicebox kernel: *pde = 00000000

May 18 16:16:10 nicebox kernel: Oops: 0002

May 18 16:16:10 nicebox kernel: CPU: 1

May 18 16:16:10 nicebox kernel: EIP: 0010:[<c013593c>] Not tainted

May 18 16:16:10 nicebox kernel: EFLAGS: 00210056

May 18 16:16:10 nicebox kernel: eax: c1573088 ebx: cf586980 ecx: cf586000
edx: 8d8f9297

May 18 16:16:10 nicebox kernel: esi: 00000000 edi: 0000007d ebp: c1573080
esp: d7003ec8

May 18 16:16:10 nicebox kernel: ds: 0018 es: 0018 ss: 0018

May 18 16:16:10 nicebox kernel: Process ffnext (pid: 32389,
stackpage=d7003000)

May 18 16:16:10 nicebox kernel: Stack: c1573088 c1573090 c1573080 00200246
000001f0 d1828700 c01365bb c1573080

May 18 16:16:11 nicebox kernel: df6d7400 000001f0 db368b00 dbb7a900 d1828700
d1828700 c01555b6 c1573080

May 18 16:16:11 nicebox kernel: 000001f0 d7003f8c fffffff4 dbb7a900 d1828700
d7003f8c c014b9ad d1828700

May 18 16:16:11 nicebox kernel: Call Trace: [<c01365bb>] [<c01555b6>]
[<c014b9ad>] [<c014bef1>] [<c013e263>]

May 18 16:16:11 nicebox kernel: [<c013e663>] [<c010770f>]

May 18 16:16:11 nicebox kernel:

May 18 16:16:11 nicebox kernel: Code: 89 42 04 8b 45 00 89 48 04 89 01 89 69
04 89 4d 00 eb b1 8b



And now the report from ksymoops:

>>EIP; c013593c <kmem_cache_alloc_batch+9c/e0>   <=====

>>eax; c1573088 <_end+120cb30/1fea4b08>
>>ebx; cf586980 <_end+f220428/1fea4b08>
>>ecx; cf586000 <_end+f21faa8/1fea4b08>
>>edx; 8d8f9297 Before first symbol
>>ebp; c1573080 <_end+120cb28/1fea4b08>
>>esp; d7003ec8 <_end+16c9d970/1fea4b08>

Trace; c01365bb <__kmem_cache_alloc+5b/140>
Trace; c01555b6 <d_alloc+156/190>
Trace; c014b9ad <lookup_hash+8d/120>
Trace; c014bef1 <open_namei+281/590>
Trace; c013e263 <filp_open+43/70>
Trace; c013e663 <sys_open+53/c0>
Trace; c010770f <system_call+33/38>

Code;  c013593c <kmem_cache_alloc_batch+9c/e0>
00000000 <_EIP>:
Code;  c013593c <kmem_cache_alloc_batch+9c/e0>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c013593f <kmem_cache_alloc_batch+9f/e0>
   3:   8b 45 00                  mov    0x0(%ebp),%eax
Code;  c0135942 <kmem_cache_alloc_batch+a2/e0>
   6:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c0135945 <kmem_cache_alloc_batch+a5/e0>
   9:   89 01                     mov    %eax,(%ecx)
Code;  c0135947 <kmem_cache_alloc_batch+a7/e0>
   b:   89 69 04                  mov    %ebp,0x4(%ecx)
Code;  c013594a <kmem_cache_alloc_batch+aa/e0>
   e:   89 4d 00                  mov    %ecx,0x0(%ebp)
Code;  c013594d <kmem_cache_alloc_batch+ad/e0>
  11:   eb b1                     jmp    ffffffc4 <_EIP+0xffffffc4>
Code;  c013594f <kmem_cache_alloc_batch+af/e0>
  13:   8b 00                     mov    (%eax),%eax


David Lewis
Senior Security Engineer
VNX Solutions, Inc
dlewis@vnxsolutions.com
410-459-7428 Cell


