Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTKZXZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTKZXZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:25:35 -0500
Received: from relay-4m.club-internet.fr ([194.158.104.43]:36092 "EHLO
	relay-4m.club-internet.fr") by vger.kernel.org with ESMTP
	id S264378AbTKZXZ0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:25:26 -0500
From: pinotj@club-internet.fr
To: torvalds@osdl.org
Cc: manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Thu, 27 Nov 2003 00:25:23 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069889123.20138.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the result of test of 2.6.0-test10 with the printk patch in slab.c and this new patch for fork.c from Linus :

# --------------------------------------------
# 03/11/25 torvalds@home.osdl.org 1.1487
# Fix error return on concurrent fork() with threaded exit()
# --------------------------------------------

Again the test is made in heavy load (compilation of kernel)
1st compilation: OK
2nd compilation straight after, oops :

---
slab: double free detected in cache 'vm_area_struct', objp cd4783f8, objnr 10, slabp cd478000, s_mem cd478100, bufctl ffffffff.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1956!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[free_block+357/784]    Not tainted
EIP:    0060:[<c015ad55>]    Not tainted
EFLAGS: 00010096
EIP is at free_block+0x165/0x310
eax: 00000083   ebx: 00000009   ecx: c0697854   edx: c05714f8
esi: cd478000   edi: cd478018   ebp: ceaddb78   esp: ceaddb44
ds: 007b   es: 007b   ss: 0068
Process login (pid: 222, threadinfo=ceadc000 task=ceb0c960)
Stack: c0504f40 c0502370 cd4783f8 0000000a cd478000 cd478100 ffffffff 0000000a 
       cd4783f8 00000005 cffdff08 c5b29100 00000010 ceaddbb0 c015afda cffed980 
       cffdff08 00000010 c95d7ef8 c5b29234 cffd91dc ceaddbc4 cffee788 00000010 
Call Trace:
 [cache_flusharray+218/688] cache_flusharray+0xda/0x2b0
 [<c015afda>] cache_flusharray+0xda/0x2b0
 [kmem_cache_free+429/912] kmem_cache_free+0x1ad/0x390
 [<c015b7bd>] kmem_cache_free+0x1ad/0x390
 [exit_mmap+505/688] exit_mmap+0x1f9/0x2b0
---

Full log : http://cercle-daejeon.homelinux.org/oops-full2.txt
Ksymoops : http://cercle-daejeon.homelinux.org/oops2.txt

Sorry that is doesn't work.
Maybe the best way is to find which patch between test9 and test10 makes this happen but it takes me a really long time, I have no idea how to choose. I already tested the files in mm subfolder unsuccessfully.
As I already said, the problem appeared in the cset-20031115_0206.txt.gz.

Regards,

Jerome Pinot




