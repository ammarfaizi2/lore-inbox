Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTBPErV>; Sat, 15 Feb 2003 23:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTBPErV>; Sat, 15 Feb 2003 23:47:21 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:15949
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265854AbTBPErU>; Sat, 15 Feb 2003 23:47:20 -0500
Date: Sat, 15 Feb 2003 23:55:57 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops in d_alloc:647 2.5.61
Message-ID: <Pine.LNX.4.50.0302152349310.16012-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this unmounting NFS filesystem. If anyone would require more 
information holla back.

Unmounting NFS filesystems:  Unable to handle kernel NULL pointer dereference at virtual address 0000007b
 printing eip:
c0172803
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0172803>]    Not tainted
EFLAGS: 00000207
EIP is at d_alloc+0x43/0x1f0
eax: 0000007b   ebx: c18a2d3c   ecx: 0000001e   edx: c0d9d874
esi: 0000007b   edi: c0d9d874   ebp: c0d8dd7c   esp: c0d8dd70
ds: 007b   es: 007b   ss: 0068
Process lockd (pid: 600, threadinfo=c0d8c000 task=c1a4ed00)
Stack: 00000000 c0d9fce4 c0daf27c c0d8dd98 c0169663 c0daf27c c0d8ddb4 c043d0bb
       00000077 c0d9fd54 c0d8dde8 c040ecc8 c0d8ddb4 c0daf27c c0d9fce4 c0daf27c
       c1ff9940 0000007b 0000007b ffffff00 00000010 00000001 00000000 00000000
Call Trace:
 [<c0169663>] lookup_hash+0x53/0xb0
 [<c040ecc8>] rpc_rmdir+0x68/0xb0
 [<c03fce63>] rpc_destroy_client+0x23/0x80
 [<c0402f3c>] rpc_release_task+0x23c/0x300
 [<c0402326>] __rpc_execute+0xc6/0x460
 [<c011d220>] default_wake_function+0x0/0x20
 [<c03fd18b>] rpc_call_sync+0x5b/0xa0
 [<c03fd19e>] rpc_call_sync+0x6e/0xa0
 [<c04012d0>] rpc_run_timer+0x0/0x130
 [<c040aa52>] rpc_register+0xa2/0x120
 [<c0140000>] set_ratelimit+0x30/0xa0
 [<c04056de>] svc_register+0x14e/0x180
 [<c0405272>] svc_destroy+0x42/0xc0
 [<c01e3895>] lockd+0x1b5/0x260
 [<c01e36e0>] lockd+0x0/0x260
 [<c0107355>] kernel_thread_helper+0x5/0x10

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 4d 0c 8b 41 04 c6

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  00000002 Before first symbol
   2:   a8 02                     test   $0x2,%al
Code;  00000004 Before first symbol
   4:   74 02                     je     8 <_EIP+0x8>
Code;  00000006 Before first symbol
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  00000008 Before first symbol
   8:   a8 01                     test   $0x1,%al
Code;  0000000a Before first symbol
   a:   74 01                     je     d <_EIP+0xd>
Code;  0000000c Before first symbol
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  0000000d Before first symbol
   d:   8b 4d 0c                  mov    0xc(%ebp),%ecx
Code;  00000010 Before first symbol
  10:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  00000013 Before first symbol
  13:   c6 00 00                  movb   $0x0,(%eax)


(gdb) list *d_alloc+0x43
0xc0172803 is in d_alloc (include/asm/string.h:196).
191     }
192
193     static inline void * __memcpy(void * to, const void * from, size_t n)
194     {
195     int d0, d1, d2;
196     __asm__ __volatile__(
197             "rep ; movsl\n\t"
198             "testb $2,%b4\n\t"
199             "je 1f\n\t"
200             "movsw\n"

(gdb) list *d_alloc+0x36
0xc01727f6 is in d_alloc (fs/dcache.c:645).
640                     if (!str) {
641                             kmem_cache_free(dentry_cache, dentry);
642                             return NULL;
643                     }
644             } else
645                     str = dentry->d_iname;
646
647             memcpy(str, name->name, name->len);
648             str[name->len] = 0;
649

-- 
function.linuxpower.ca
