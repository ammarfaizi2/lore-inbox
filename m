Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281465AbRKME3W>; Mon, 12 Nov 2001 23:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281466AbRKME3L>; Mon, 12 Nov 2001 23:29:11 -0500
Received: from TK212017087078.teleweb.at ([212.17.87.78]:27633 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S281465AbRKME3E>;
	Mon, 12 Nov 2001 23:29:04 -0500
Date: Tue, 13 Nov 2001 05:28:54 +0100
From: Armin Obersteiner <armin@xos.net>
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: 2.4.15-pre2 and earlier: reiserfs problem
Message-ID: <20011113052854.A26879@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

i have some problems with reiserfs. i write to both the kernel mailing list and
reiserfs list because i found no solution in the reiserfs-mailing list archives ... 
(i found some answers, but controversial advices :-( and they did not work for me.)

i use reiserfs for a very long time, nearly 2 years if i calculate right. i needed
large filesystem support so i had to update from 3.5 to 3.6 in order to get it.

i booted with suse 7.3 rescue dvd and mounted the / partition with the conv flag.
then after unmounting i rebooted...

the kernel i was using that time: with 2.4.12-ac5 with preempt patch.

some errors occured during reboot: permission denied, processes could not be started.
some files simply weren't there (ls), but you could get a bash TAB filename completion 
on them... (with 'ls' at the bgeinning of the line). if i tried to access them i got: permission denied.

after some emergency backups i used suse 7.3 rescue dvd to do a reiserfsck (3.x.0k-pre9
if i remember right). first i did --check then --fix-non-critical after some reboots
(and some files "visible" again) but not all i did a --rebuild-tree. it did not take
that long (30 min on 40GB)...

the positive aspect: no invisible/inaccessible files any more

BUT the negative ones: 

* filename tab completion within bash is working in some cases/dirs but not ALL (this is really strange).
  with 'ls name<TAB>' i get completion, but e.g. with 'gv name<TAB>' i don't ...

* i get a lot of "reiserfs_release_objectid: tried to free free object id" these started
  immediately after converting to 3.6...

* i couldn't create large files so far ;-) [but that is of no concern right now]

i tried to be cool for now, but i don't know if the filesystem problem is small or large.

before converting i got these exotic error: (may be irrelevant, but i wanted to show all error lines)

PAP-5710: reiserfs_paste_into_item: entry or pasted byte ([251560 167552 0x1d3001 IND]) exists<4>vs-: reiserfs_get_block: [251560 167552 0x1b5f001 UNKNOWN] should not be found<7>ISO 9660 Extensions: Microsoft Joliet Level 3

this is an example of the release object id problem:

vs-15010: reiserfs_release_objectid: tried to free free object id (292421)<4>vs-15010: reiserfs_release_objectid: tried to free free object id (221948)<4>vs-15010: reiserfs_release_objectid: tried to free free object id (240872)<4>vs-15010: reiserfs_release_objectid: tried to free free object id (275896)<4>nfsd: last server has exited

reiserfscks with --rebuild-tree throws all these files in /lost+found (i suppose *these* files), well i actually 
deleted them on purpose ...

but they seem to be creeping in the filesystem again from time to time ...

is it somehow possible to recover my filesystem to a working one again? 

now i'm using linux-2.4.15-pre2 (i hoped some reiserfs problems would have been corrected in this
release ...).

if i had to reformat, i wouldn't use reiserfs anymore now that ext3 is in the kernel ...

MfG,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU
