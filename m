Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWHZQGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWHZQGR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWHZQGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:06:17 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:25210 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422670AbWHZQGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:06:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.ar;
  h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=azt833zh9EYTzb5cUFuWegUxn66/ahAkY/6Mkd0hH51gJl2D7j/FQpLRaS3pHGsSCkhuWhjFHNZIbmYYwDO6LoUJq/jRn/PindhGsFWCtleGYGkFXVdc+xRGXTRyq9SHloFM4GijcgkRNlg9utszUFHs2L5AQfq9WWfvk9McwYY=  ;
Message-ID: <44F07174.8080207@yahoo.com.ar>
Date: Sat, 26 Aug 2006 13:06:12 -0300
From: Gerardo Exequiel Pozzi <djgeray2k@yahoo.com.ar>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: XFS internal error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(sorry for my english)
(please cc to my email i am not suscribe to this list)
Linux version 2.6.17.11 (root@djgera) (gcc version 3.4.6) #1 PREEMPT Thu 
Aug 24 00:27:47 ART 2006
and previusly used, .7 .6 .2, and .16.X ...

This problem can be related with previus kernels that write on fs, and 
now when delete files apears the errors?

I delete a big tree directory with many files (39G) from my filesystem,
then appears this error:

djgera@djgera:/mnt/sdb1$ time rm -rf frugalware
rm: cannot remove 
`frugalware/frugalware-stable/extra/frugalware-x86_64/gnet-2.0.7-1-x86_64.fpm': 
Unknown error 990
rm: cannot lstat 
`frugalware/frugalware-stable/extra/frugalware-x86_64/firefox-hu-1.5-2-x86_64.fpm': 
Input/output error

real    0m54.650s
user    0m0.059s
sys     0m2.582s

the dmesg shows:
xfs_da_do_buf: bno 16777216
dir: inode 168328424
Filesystem "sdb1": XFS internal error xfs_da_do_buf(1) at line 2119 of 
file fs/xfs/xfs_da_btree.c.  Caller 0xc01e6597
 <c01e6276> xfs_da_do_buf+0x5f6/0x880  <c01e6597> xfs_da_read_buf+0x47/0x50
 <c01e43bd> xfs_da_node_lookup_int+0xcd/0x3a0  <c01ebcbb> 
xfs_dir2_data_log_unused+0x6b/0x80
 <c01e6597> xfs_da_read_buf+0x47/0x50  <c01f03b3> 
xfs_dir2_leafn_remove+0x2a3/0x440
 <c01f03b3> xfs_dir2_leafn_remove+0x2a3/0x440  <c01f1824> 
xfs_dir2_node_removename+0xb4/0x100
 <c01e8c92> xfs_dir2_removename+0x122/0x130  <c0229e46> 
kmem_zone_alloc+0x56/0xe0
 <c021d205> xfs_trans_ijoin+0x35/0xa0  <c0225050> xfs_remove+0x280/0x560
 <c01ff3e0> xfs_iget+0xd0/0x140  <c0231cd8> xfs_vn_unlink+0x48/0x90
 <c021bfa1> xfs_trans_unlocked_item+0x41/0x60  <c0174b10> d_rehash+0x50/0x80
 <c0174648> d_splice_alias+0xa8/0x110  <c01687e5> permission+0x85/0xb0
 <c016a7a1> may_delete+0x41/0x120  <c016bc7f> vfs_unlink+0xaf/0xc0
 <c016bd3c> do_unlinkat+0xac/0x130  <c016e67c> sys_getdents64+0xcc/0xf0
 <c016e4c0> filldir64+0x0/0xf0  <c016be17> sys_unlink+0x17/0x20
 <c01031e3> syscall_call+0x7/0xb
Filesystem "sdb1": XFS internal error xfs_trans_cancel at line 1150 of 
file fs/xfs/xfs_trans.c.  Caller 0xc02250be
 <c021b998> xfs_trans_cancel+0x108/0x150  <c02250be> xfs_remove+0x2ee/0x560
 <c02250be> xfs_remove+0x2ee/0x560  <c01ff3e0> xfs_iget+0xd0/0x140
 <c0231cd8> xfs_vn_unlink+0x48/0x90  <c021bfa1> 
xfs_trans_unlocked_item+0x41/0x60
 <c0174b10> d_rehash+0x50/0x80  <c0174648> d_splice_alias+0xa8/0x110
 <c01687e5> permission+0x85/0xb0  <c016a7a1> may_delete+0x41/0x120
 <c016bc7f> vfs_unlink+0xaf/0xc0  <c016bd3c> do_unlinkat+0xac/0x130
 <c016e67c> sys_getdents64+0xcc/0xf0  <c016e4c0> filldir64+0x0/0xf0
 <c016be17> sys_unlink+0x17/0x20  <c01031e3> syscall_call+0x7/0xb
xfs_force_shutdown(sdb1,0x8) called from line 1151 of file 
fs/xfs/xfs_trans.c.  Return address = 0xc021b9be
Filesystem "sdb1": Corruption of in-memory data detected.  Shutting down 
filesystem: sdb1
Please umount the filesystem, and rectify the problem(s)

when umount appears this at dmesg:
xfs_force_shutdown(sdb1,0x1) called from line 338 of file 
fs/xfs/xfs_rw.c.  Return address = 0xc02299e7

now mount and: (to replay log for check with xfs_check)
XFS mounting filesystem sdb1
Starting XFS recovery on filesystem: sdb1 (logdev: internal)
Ending XFS recovery on filesystem: sdb1 (logdev: internal)

umount and xfs_check:
root@djgera:~# xfs_check /dev/sdb1
bad free block nused 34 should be 43 for dir ino 78944224 block 16777216
missing free index for data block 0 in dir ino 168328424
missing free index for data block 2 in dir ino 168328424
missing free index for data block 3 in dir ino 168328424
missing free index for data block 4 in dir ino 168328424
missing free index for data block 5 in dir ino 168328424
missing free index for data block 6 in dir ino 168328424
missing free index for data block 7 in dir ino 168328424
missing free index for data block 8 in dir ino 168328424
missing free index for data block 9 in dir ino 168328424
bad free block nused 4 should be 21 for dir ino 168328959 block 16777216

xfs_repair:
root@djgera:~# xfs_repair /dev/sdb1
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
        - found root inode chunk
Phase 3 - for each AG...
        - scan and clear agi unlinked lists...
        - process known inodes and perform inode discovery...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - clear lost+found (if it exists) ...
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
Phase 5 - rebuild AG headers and trees...
        - reset superblock...
Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - ensuring existence of lost+found directory
        - traversing filesystem starting at / ...
free block 16777216 for directory inode 78944224 bad nused
rebuilding directory inode 78944224
free block 16777216 for directory inode 168328959 bad nused
rebuilding directory inode 168328959
can't read freespace block 16777216 for directory inode 168328424
rebuilding directory inode 168328424
        - traversal finished ...
        - traversing all unattached subtrees ...
        - traversals finished ...
        - moving disconnected inodes to lost+found ...
Phase 7 - verify and correct link counts...
cache_purge: shake on cache 0x80daa78 left 3 nodes!?
cache_purge: shake on cache 0x80daa78 left 3 nodes!?
done

root@djgera:~# xfs_info /dev/sdb1
meta-data=/dev/sdb1              isize=256    agcount=16, agsize=1525923 
blks
         =                       sectsz=512   attr=0
data     =                       bsize=4096   blocks=24414768, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=11921, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D


	
	
		
__________________________________________________
Preguntá. Respondé. Descubrí.
Todo lo que querías saber, y lo que ni imaginabas,
está en Yahoo! Respuestas (Beta).
¡Probalo ya! 
http://www.yahoo.com.ar/respuestas

