Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRDBQmh>; Mon, 2 Apr 2001 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbRDBQm1>; Mon, 2 Apr 2001 12:42:27 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:53511 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S130448AbRDBQmM>; Mon, 2 Apr 2001 12:42:12 -0400
Date: Mon, 2 Apr 2001 18:41:20 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: <linux-kernel@vger.kernel.org>
cc: ReiserFS Mailing List <reiserfs-list@namesys.com>,
   Robert NEDBAL <R.Nedbal@sh.cvut.cz>
Subject: Re: ReiserFS - corrupted files (2.4.3)
In-Reply-To: <Pine.BSF.4.31.0104021352030.24794-100000@veverka.sh.cvut.cz>
Message-ID: <Pine.LNX.4.33.0104021821500.989-100000@7812-grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am getting musch the same types of corruption. I am on a K6-2 with a
30Gb IBM HD and 256Mb RAM running vanilla 2.4.3 with iptables and squid
caching proxy. The problems arise on the cache part of the FS (i.e. with
many file operations).

I am considering using reiserfsck (3.x.0j) to fix it, but it has to wait
until the morning - so in the meantime perhaps somebody can use the info
about the corruptions? I have nowhere to back up my rather large (in
comparison to other space on the box) cache, but if it goes lost in the
process of rebuilding it, it does not matter so much.

What should I do to help? I will try to debug the problem if necessary -
should I turb on internal checks?

On Mon, 2 Apr 2001, Robert NEDBAL wrote:

> Hello,
> I'm using ReiserFS on my primary filesystem and yesterday, I have found
> that some files are corrupted. Yesterday I had to reset computer becase
> X Window freezed. Maybe it caused this problem.
>
> This comes from log:

[SNIP]

My log goes much the same (although I have fewer errors - it seems to
affect only few files):
Mar 30 10:32:09 wiibroe kernel: reiserfs: checking transaction log
(device 16:01) ...
Mar 30 10:32:09 wiibroe kernel: Using r5 hash to sort names
Mar 30 10:32:09 wiibroe kernel: ReiserFS version 3.6.25
[...]
Apr  2 14:36:10 wiibroe kernel: is_leaf: item location seems wrong:
*OLD*[1214 319934 0x8f1 DIRECT], item_len 0, item_location 0,
free_space(entry_count) 2289
Apr  2 14:36:10 wiibroe kernel: vs-5150: search_by_key: invalid format
found in block 132193. Fsck?
Apr  2 14:36:10 wiibroe kernel: is_leaf: item location seems wrong:
*OLD*[1214 319934 0x8f1 DIRECT], item_len 0, item_location 0,
free_space(entry_count) 2289
Apr  2 14:36:10 wiibroe kernel: vs-5150: search_by_key: invalid format
found in block 132193. Fsck?
Apr  2 14:36:10 wiibroe kernel: vs-13050: reiserfs_update_sd: i/o
failure occurred trying to update [1214 319936 0x0 SD] stat datais_leaf:
item location seems wrong: *OLD*[1214 319934 0x8f1 DIRECT], item_len 0,
item_location 0, free_space(entry_count) 2289
Apr  2 14:36:10 wiibroe kernel: vs-5150: search_by_key: invalid format
found in block 132193. Fsck?
Apr  2 14:36:10 wiibroe kernel: vs-: reiserfs_delete_solid_item: i/o
failure occurred trying to delete [1214 319936 0x0 SD]
[...]
Apr  2 18:36:25 wiibroe kernel: vs-13042: reiserfs_read_inode2: [1020
271248 0x0 SD] not found
Apr  2 18:36:25 wiibroe kernel: vs-13048: reiserfs_iget: bad_inode. Stat
data of (1020 271248) not found
Apr  2 18:36:50 wiibroe kernel: is_leaf: item location seems wrong:
*OLD*[1214 319934 0x8f1 DIRECT], item_len 0, item_location 0,
free_space(entry_count) 2289
Apr  2 18:36:50 wiibroe kernel: vs-5150: search_by_key: invalid format
found in block 132193. Fsck?
Apr  2 18:36:50 wiibroe kernel: vs-13070: reiserfs_read_inode2: i/o
failure occurred trying to find stat data of [1214 319935 0x0 SD]
Apr  2 18:36:50 wiibroe kernel: vs-13048: reiserfs_iget: bad_inode. Stat
data of (1214 319935) not found

> When I want to list corrupted directory, I get this:

What I get is:

root@wiibroe:/var/spool/squid# find /var/spool/squid/ -type f | xargs ls
> /dev/null
find: /var/spool/squid/01/C5/0001C5DA: Ingen sådan fil eller filkatalog
find: /var/spool/squid/01/C5/0001C5E6: Ingen sådan fil eller filkatalog
find: /var/spool/squid/03/F5/0003F5E9: Adgang nægtet
find: /var/spool/squid/04/B6/0004B6E0: Adgang nægtet

(Ingen sådan fil eller filkatalog = No such file or directory
 Adgang nægtet = Access denied)

Rasmus Bøg Hansen

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
if (getenv(EDITOR) == "vim") {karma++};
--------------------------------- [ moffe at amagerkollegiet dot dk ] -





