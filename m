Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWHETqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWHETqt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 15:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWHETqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 15:46:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:27075 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751483AbWHETqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 15:46:48 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
To: Clay Barnes <clay.barnes@gmail.com>, Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Reply-To: 7eggert@gmx.de
Date: Sat, 05 Aug 2006 21:38:25 +0200
References: <6Cdcz-1ZK-27@gated-at.bofh.it> <6EDFp-2YC-19@gated-at.bofh.it> <6EHfR-8uS-33@gated-at.bofh.it> <6EIvf-29Z-33@gated-at.bofh.it> <6EIOE-2xY-7@gated-at.bofh.it> <6EJ7V-2Xa-7@gated-at.bofh.it> <6EJUk-4br-11@gated-at.bofh.it> <6EKx5-5dy-19@gated-at.bofh.it> <6EL03-5OU-1@gated-at.bofh.it> <6ELt2-6Eh-1@gated-at.bofh.it> <6ELCQ-6Rl-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1G9Rz1-0000ks-R7@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Mon, 2006-07-31 12:17:12 -0700, Clay Barnes <clay.barnes@gmail.com> wrote:
>> On 20:43 Mon 31 Jul     , Jan-Benedict Glaw wrote:
>> > On Mon, 2006-07-31 20:11:20 +0200, Matthias Andree <matthias.andree@gmx.de>
>> > > Jan-Benedict Glaw schrieb am 2006-07-31:

> [Crippled DMA writes]
>> > > Massive hardware problems don't count. ext2/ext3 doesn't look much better
>> > > in such cases. I had a machine with RAM gone bad (no ECC - I wonder what
>> > 
>> > They do! Very much, actually. These happen In Real Life, so I have to
>> 
>> I think what he meant was that it is unfair to blame reiser3 for data
>> loss in a massive failure situation as a case example by itself.  What

<snip>

> The point is that it's quite hard to really fuck up ext{2,3} with only
> some KB being written while it seems (due to the
> fragile^Wsophisticated on-disk data structures) that it's just easy to
> kill a reiser3 filesystem.

- Once I had dying hdd without realizing this (I asumed heat problems or a
  failing power supply), and that caused the fs to become unaccessible.
  --rebuild-tree did the trick.

- I had a LVM on a set of some crappy disks with a reiser3fs-formated LV.  
  Windows decided it had to format the LVM partitions, and the reiserfs
  survived almost undamaged.

- I sometimes had errors on reiserfs resulting in inaccessible
  directories. I could fix that by moving them out of the way. (Maybe I
  could also have used --clean-attributes, I don't remember trying. OTOH,
  maybe that option is too new (2003).)

- I have an ext3 that can't be fixed by e2fsck (see below). fsck will fix
  some errors, trash some files and leave a fs waiting to throw the same
  error again. I'm fixing it using mkreiserfs now.

---------------------------------


Aug  2 15:15:23 server kernel: EXT3-fs error (device md(9,3)): ext3_free_blocks:
bit already cleared for block 13084101
Aug  2 15:15:23 server kernel: Aborting journal on device md(9,3).
Aug  2 15:15:23 server kernel: Remounting filesystem read-only
Aug  2 15:15:23 server kernel: ext3_reserve_inode_write: aborting transaction:
Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device
md(9,3)) in ext3_reserve_inode_write: Journal has aborted
Aug  2 15:15:23 server kernel: EXT3-fs error (device md(9,3)) in ext3_truncate:
Journal has aborted
Aug  2 15:15:23 server kernel: ext3_reserve_inode_write: aborting transaction:
Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device
md(9,3)) in ext3_reserve_inode_write: Journal has aborted
Aug  2 15:15:23 server kernel: EXT3-fs error (device md(9,3)) in
ext3_orphan_del: Journal has aborted
Aug  2 15:15:23 server kernel: ext3_reserve_inode_write: aborting transaction:
Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device
md(9,3)) in ext3_reserve_inode_write: Journal has aborted
Aug  2 15:15:23 server kernel: EXT3-fs error (device md(9,3)) in
ext3_delete_inode: Journal has aborted



-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
