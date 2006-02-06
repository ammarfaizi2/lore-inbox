Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWBFRVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWBFRVd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWBFRVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:21:32 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:63372 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S932243AbWBFRVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:21:31 -0500
Date: Mon, 6 Feb 2006 18:21:41 +0100
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: [BUG] Linux 2.6.16-rcX breaks mutt
Message-ID: <20060206172141.GA15133@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found out that mutt when running with a 2.6.16-rcX kernel is unable to
discover new mails in mboxes other than the main one.
On my system mail is downloaded using fetchmail, which hands the mails
to procmail; procmail then saves the mails in the correct mbox (for
example each mailing list has its own mbox). Using mutt, the 'c' key is
used to changed mbox and it defaults to the first mbox that has new
mail. With kernel 2.6.16 'c' has no effects (mutt seems to think that
there's no new mail).

I think that the problem is related to the changes in:
fs/xfs/linux-2.6/xfs_iops.c

I've done a simple test with working and non working system:

* With kernel 2.6.16-rc2

Empty file:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 994             Blocks: 8          IO Block: 4096   regular file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:42:52.185598250 +0100
Modify: 2006-02-05 18:42:53.189661000 +0100
Change: 2006-02-05 18:42:53.189661000 +0100

Mutt opened:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 994             Blocks: 8          IO Block: 4096   regular file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:43:05.338420250 +0100
Modify: 2006-02-05 18:42:53.000000000 +0100
Change: 2006-02-05 18:43:05.338420250 +0100

New mail:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 1940            Blocks: 8          IO Block: 4096   regular file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:43:05.338420250 +0100
Modify: 2006-02-05 18:43:31.960084000 +0100
Change: 2006-02-05 18:43:31.960084000 +0100

Mutt opened:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 1940            Blocks: 8          IO Block: 4096   regular file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:43:59.073778500 +0100
Modify: 2006-02-05 18:43:31.000000000 +0100
Change: 2006-02-05 18:43:59.073778500 +0100

* With kernel 2.6.15

Before:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 0               Blocks: 0          IO Block: 4096   regular empty file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:46:13.186160000 +0100
Modify: 2006-02-05 18:46:06.000000000 +0100
Change: 2006-02-05 18:46:13.198160750 +0100

New mail:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 1187            Blocks: 8          IO Block: 4096   regular file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:46:13.186160000 +0100
Modify: 2006-02-06 17:38:24.547425000 +0100
Change: 2006-02-06 17:38:24.547425000 +0100

Mutt opened:

kronos:~/Mail/Lists$ stat ML-testml-February-2006
  File: `ML-testml-February-2006'
  Size: 1187            Blocks: 8          IO Block: 4096   regular file
Device: 306h/774d       Inode: 26045738    Links: 1
Access: (0600/-rw-------)  Uid: ( 1000/  kronos)   Gid: (  100/   users)
Access: 2006-02-05 18:46:13.000000000 +0100
Modify: 2006-02-06 17:38:24.000000000 +0100
Change: 2006-02-06 17:38:36.856194250 +0100

Note that with 2.6.15 the atime of the mbox is unchanged after opening
mutt, while with 2.6.16-rc2 it does change (I guess that's what confuses
mutt).

Also, looking at strace mutt reads the mbox (so atime changes) but
immediatly resets atime using utime:

stat64("/home/kronos/Mail/Lists/ML-testml-February-2006",
  {st_dev=makedev(3, 6), st_ino=26045738, st_mode=S_IFREG|0600,
  st_nlink=1, st_uid=1000, st_gid=100, st_blksize=4096, st_blocks=8,
  st_size=2159, st_atime=2006/02/05-18:46:13,
  st_mtime=2006/02/06-17:39:07, st_ctime=2006/02/06-18:01:12}) = 0

stat64("/home/kronos/Mail/Lists/ML-testml-February-2006",
  {st_dev=makedev(3, 6), st_ino=26045738, st_mode=S_IFREG|0600,
  st_nlink=1, st_uid=1000, st_gid=100, st_blksize=4096, st_blocks=8,
  st_size=2159, st_atime=2006/02/05-18:46:13,
  st_mtime=2006/02/06-17:39:07, st_ctime=2006/02/06-18:01:12}) = 0

open("/home/kronos/Mail/Lists/ML-testml-February-2006", O_RDONLY|O_LARGEFILE) = 4

fstat64(4, {st_dev=makedev(3, 6), st_ino=26045738, st_mode=S_IFREG|0600,
  st_nlink=1, st_uid=1000, st_gid=100, st_blksize=4096, st_blocks=8,
  st_size=2159, st_atime=2006/02/05-18:46:13,
  st_mtime=2006/02/06-17:39:07, st_ctime=2006/02/06-18:01:12}) = 0

mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f76000
read(4, "From kronos@kronoz.cjb.net  Mon "..., 4096) = 2159
close(4)                                = 0
munmap(0xb7f76000, 4096)                = 0

utime("/home/kronos/Mail/Lists/ML-testml-February-2006",
  [2006/02/05-18:46:13, 2006/02/06-17:39:07]) = 0

Luca
(Please CC me)
-- 
Home: http://kronoz.cjb.net
"La Via prosegue senza fine."
	Bilbo Baggins - Il Signore degli Anelli - J.R.R. Tolkien
