Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTFWPg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 11:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFWPg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 11:36:28 -0400
Received: from [62.75.136.201] ([62.75.136.201]:28051 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264158AbTFWPg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 11:36:26 -0400
Message-ID: <3EF721C0.9010801@g-house.de>
Date: Mon, 23 Jun 2003 17:50:24 +0200
From: Christian Kujau <evil@g-house.de>
Reply-To: evil@g-house.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4b) Gecko/20030507
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: shaggy@austin.ibm.com
Subject: kernel BUG at jfs_dmap.c:776
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, this occurs for 2.4.21 *AND* 2.5.72 :-(
here again the error from the 2.5.72 kernel, below is the known part.


XT_GETPAGE: xtree page corrupt
xtLookup: xtSearch returned 5
XT_GETPAGE: xtree page corrupt
xtLookup: xtSearch returned 5
XT_GETPAGE: xtree page corrupt
xtLookup: xtSearch returned 5
XT_GETPAGE: xtree page corrupt
xtLookup: xtSearch returned 5
jfs_read_super: get root inode failed
XT_GETPAGE: xtree page corrupt
xtLookup: xtSearch returned 5
BUG at fs/jfs/jfs_dmap.c:760 assert(hint < mapSize)
Kernel bug at fs/jfs/jfs_dmap.c:760
mount(669): Kernel Bug 1
pc = [<fffffffc003b0980>]  ra = [<fffffffc003b0974>]  ps = 0000    Not 
tainted
v0 = 0000000000000037  t0 = 0000000000000001  t1 = fffffc0000539250
t2 = 0000000000000000  t3 = 0000000000000000  t4 = ffffffff00000000
t5 = 0000000000000001  t6 = fffffc000052e210  t7 = fffffc00033f4000
a0 = 0000000000000000  a1 = 0000000000000000  a2 = 0000000000000000
a3 = 0000000000000000  a4 = 0000000000000001  a5 = 0000000000000002
t8 = 0000000000000004  t9 = fffffc0000562e70  t10= 0000000000000000
t11= 000000000000000a  pv = fffffc0000324a50  at = 0000000000000000
gp = fffffffc003cdc30  sp = fffffc00033f78f8
Trace:fffffc0000318a24 fffffc000036d51c fffffc00003fe2d8 
fffffc00003fd178 fffffc00004038e4 fffffc00004022f0 fffffc0000329294 
fffffc0000348734 fffffc0000348508 fffffc0000344e5c fffffc00003716e4 
fffffc0000371ab0 fffffc000038b9bc fffffc000038bdcc fffffc000038c3ec 
fffffc000038c3c8 fffffc0000313084 fffffc0000312fe0
Code: 22730d1b  225f02f8  6b5b4000  27ba0002  23bdd2bc  00000081 
<000002f8> 003ce916

Note: i don't know about the XT_Ü* messages right before the "Bug at..".
seconds before i mounted a created a reiserfs on this partition, mounted 
it, unmounted it. the i created the JFS, the bug msg appeared at the 
mount attempt. but the XT_* msg are like to be some product of JFS, 
because of the timestamp in my logs (but you'll know better anyway).

Thanks,
Christian.


-------------------------------------

Hi,

while doing some benchmarks, i noticed a segfault when trying to mount a
newly created JFS. mkfs.jfs passes, but mount gives:


BUG at jfs_dmap.c:776 assert(hint < mapSize)
kernel BUG at jfs_dmap.c:776!
mount(1055): Kernel Bug 1
pc = [<fffffffc003236b4>]  ra = [<fffffffc003236a8>]  ps = 0000    Not
tainted
v0 = 000000000000001e  t0 = 0000000000000001  t1 = 0000000000000000
t2 = fffffc00011d2948  t3 = 0000000000000000  t4 = ffffffff00000000
t5 = 0000000000000001  t6 = 343c0a29657a6953  t7 = fffffc0002cf8000
a0 = 0000000000000000  a1 = 0000000000000001  a2 = 0000000000000001
a3 = 0000000000000001  a4 = 0000000000000001  a5 = 0000000000000002
t8 = 0000000000000004  t9 = 0000000000001c0e  t10= 0000000000001c0f
t11= fffffc00011f0988  pv = fffffc000101fb90  at = fffffc00011f0988
gp = fffffffc00347c88  sp = fffffc0002cfb9e8
Trace:fffffc0001029f50 fffffc0001053b88 fffffc0001054838
fffffc000103e1ac fffffc00010168b0 fffffc000105808c fffffc00010585a4
fffffc0001058434 fffffc0001070b28 fffffc0001070f3c fffffc0001070d18
fffffc000107155c fffffc0001071538 fffffc0001010d30 fffffc0001010c88
Code: 22106a0c  47e90411  6b5b4106  27ba0002  23bd45e0  00000081
<c3fffecb> 47ff041f


this is with vanilla 2.4.21 (Alpha), compiled with gcc3.3, glibc 2.3.1,
util-linux 2.11z.


thanks,
Christian.


