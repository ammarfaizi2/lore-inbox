Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbUDPWMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbUDPWD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:03:57 -0400
Received: from arhont1.eclipse.co.uk ([81.168.98.121]:59795 "EHLO
	pingo.core.arhont.com") by vger.kernel.org with ESMTP
	id S263885AbUDPWBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:01:18 -0400
Message-ID: <408057A5.6010604@arhont.com>
Date: Fri, 16 Apr 2004 23:01:09 +0100
From: Konstantin Gavrilenko <mlists@arhont.com>
Reply-To: k.gavrilenko@arhont.com
Organization: Arhont Ltd. - Information Security
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040331
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-mm6 reiserfs and hpt366 problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,


first time writing to kernel mlist and with a bunch of problems :|

initial problem is regarding hpt366 controller that I have, the 2.6.5 
kernel randomly crashes when I copy stuff bettween hdd's connected to 
hpt366 and hdd's conencted to normal piix

2x 200gb (raid1) hdd conencted to hpt366
1x 180gb hdd connected to piix

it seems that quite a few people around have the similar problem with 
2.6.x, since afaic remember I did not have this problem when I was using 
2.4.24

Anyway, I applied 2.6.5-mm6 patch. The system does not hang anymore, but,
I get this weird errors filling up syslog:


Apr 16 22:45:06 filo kernel: Debug: sleeping function called from 
invalid context at drivers/block/ll_rw_blk.c:1156
Apr 16 22:45:06 filo kernel: in_atomic():0, irqs_disabled():1
Apr 16 22:45:06 filo kernel: Call Trace:
Apr 16 22:45:06 filo kernel:  [<c0117449>] __might_sleep+0x99/0xb0
Apr 16 22:45:06 filo kernel:  [<c02950bf>] generic_unplug_device+0x1f/0x60
Apr 16 22:45:06 filo kernel:  [<c02d9fc9>] unplug_slaves+0x69/0x70
Apr 16 22:45:06 filo kernel:  [<c029511f>] blk_backing_dev_unplug+0x1f/0x30
Apr 16 22:45:06 filo kernel:  [<c014dc99>] __wait_on_buffer+0xd9/0xe0
Apr 16 22:45:06 filo kernel:  [<c0117770>] autoremove_wake_function+0x0/0x50
Apr 16 22:45:06 filo kernel:  [<c013998c>] mark_page_accessed+0x2c/0x40
Apr 16 22:45:06 filo kernel:  [<c0117770>] autoremove_wake_function+0x0/0x50
Apr 16 22:45:06 filo kernel:  [<c01a91da>] flush_commit_list+0x29a/0x3a0
Apr 16 22:45:06 filo kernel:  [<c01adf1a>] do_journal_end+0x85a/0xb60
Apr 16 22:45:06 filo kernel:  [<c0136b30>] pdflush+0x0/0x30
Apr 16 22:45:06 filo kernel:  [<c01acc8d>] journal_end_sync+0x4d/0x90
Apr 16 22:45:06 filo kernel:  [<c019964d>] reiserfs_sync_fs+0x4d/0x60
Apr 16 22:45:06 filo kernel:  [<c03776b7>] __down_failed_trylock+0x7/0xc
Apr 16 22:45:06 filo kernel:  [<c0152b81>] sync_supers+0xb1/0xc0
Apr 16 22:45:06 filo kernel:  [<c01361d6>] wb_kupdate+0x56/0x140
Apr 16 22:45:06 filo kernel:  [<c0377974>] schedule+0x2a4/0x480
Apr 16 22:45:06 filo kernel:  [<c0136a54>] __pdflush+0xa4/0x180
Apr 16 22:45:06 filo kernel:  [<c0136b58>] pdflush+0x28/0x30
Apr 16 22:45:06 filo kernel:  [<c0136180>] wb_kupdate+0x0/0x140
Apr 16 22:45:06 filo kernel:  [<c0136b30>] pdflush+0x0/0x30
Apr 16 22:45:06 filo kernel:  [<c012a8aa>] kthread+0xaa/0xb0
Apr 16 22:45:06 filo kernel:  [<c012a800>] kthread+0x0/0xb0
Apr 16 22:45:06 filo kernel:  [<c01022e5>] kernel_thread_helper+0x5/0x10



furthermore,

Sometimes I get shitloads of these in syslog:

Apr 16 21:57:48 filo kernel: is_tree_node: node level 59305 does not 
match to the expected one 1
Apr 16 21:57:48 filo kernel: vs-5150: search_by_key: invalid format 
found in block 691533. Fsck?
Apr 16 21:57:48 filo kernel: is_tree_node: node level 59305 does not 
match to the expected one 1
Apr 16 21:57:48 filo kernel: vs-5150: search_by_key: invalid format 
found in block 691533. Fsck?
Apr 16 21:57:48 filo kernel: is_tree_node: node level 59305 does not 
match to the expected one 1
Apr 16 21:57:48 filo kernel: vs-5150: search_by_key: invalid format 
found in block 691533. Fsck?
Apr 16 21:57:48 filo kernel: is_tree_node: node level 59305 does not 
match to the expected one 1
Apr 16 21:57:48 filo kernel: vs-5150: search_by_key: invalid format 
found in block 691533. Fsck?


I have unmounted the partition and run reiserfsck on it, that reported 
that everything is fine, and nothing to worry about.

Can someone advise whether I am likely to run into problems later on 
with these types of errors? SInce it is my first expirience with reiserfs.



-- 
Respectfully,
Konstantin V. Gavrilenko

Managing Director
Arhont Ltd - Information Security

web:    http://www.arhont.com
	http://www.wi-foo.com
e-mail: k.gavrilenko@arhont.com

tel: +44 (0) 870 44 31337
fax: +44 (0) 117 969 0141

PGP: Key ID - 0x4F3608F7
PGP: Server - keyserver.pgp.com

