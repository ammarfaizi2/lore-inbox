Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJILO6>; Wed, 9 Oct 2002 07:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSJILO6>; Wed, 9 Oct 2002 07:14:58 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19214 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261525AbSJILOz>; Wed, 9 Oct 2002 07:14:55 -0400
Message-ID: <3DA41105.3020300@namesys.com>
Date: Wed, 09 Oct 2002 15:20:37 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] ReiserFS v3 changesets resend
Content-Type: multipart/mixed;
 boundary="------------030306020509040903030401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030306020509040903030401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------030306020509040903030401
Content-Type: message/rfc822;
 name="Please send to Linus"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Please send to Linus"

Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 12065 invoked from network); 9 Oct 2002 09:07:09 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 9 Oct 2002 09:07:09 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 6D9772A75B1; Wed,  9 Oct 2002 13:07:09 +0400 (MSD)
Date: Wed, 9 Oct 2002 13:07:09 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: Please send to Linus
Message-ID: <20021009130709.A23353@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i

Hello!

   It seems our first attempt of sending these to Linus have failed,
   here is another one.

Bye,
    Oleg

    reiserfs updates:

    These first two changesets contain fixes for reiserfs. They fix issue with
    handling of displacing_large_files allocator option and a problem with
    remounting from readwrite to readwrite mode if FS holds some deleted but
    not yet closed files.

    Next three changesets implement reiserfs_file_write. Also third one
    exports generic_osync_inode,block_commit_write and remove_suid
    because these are now needed for reiserfs.
    There was no reiserfs_file_write in the 2.4 port of reiserfs
    (and Hans was very unhappy about it).
    With current 'one block at a time' algorithm, writes past the end of a file
    are slow because each new file block is separately added into the tree
    causing shifting of other items which is CPU expensive.
    With this new implementation if you write into file with big enough chunks,
    it uses half as much CPU. Also this version is more SMP friendly than
    the current one.

    Next four changesets replace recently added lock_kernels with
    reiserfs wrappers (that would eventually evolve into real separate
    locks), includes more C99 designated initialisers cleanups (this time
    from Art Haas) and updates some reiserfs help entries. Also fixing a
    buglet in reiserfs_file_write code discovered during some 2.4.20-pre
    testing.

    You can pull these from bk://thebsh.namesys.com/bk/reiser3-linux-2.5

Diffstats:
 fs/reiserfs/inode.c         |    2 +-
 include/linux/reiserfs_fs.h |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

 super.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

 do_balan.c        |  105 +++++++++++++++++++++++++++---------------------------
 inode.c           |   48 ++++++++++++++++++++----
 tail_conversion.c |    5 +-
 3 files changed, 95 insertions(+), 63 deletions(-)

 fs/reiserfs/bitmap.c           |   21
 fs/reiserfs/file.c             | 1080 ++++++++++++++++++++++++++++++++++++++++-
 fs/reiserfs/inode.c            |    4
 fs/reiserfs/super.c            |    1
 include/linux/reiserfs_fs.h    |    1
 include/linux/reiserfs_fs_sb.h |    1
 6 files changed, 1104 insertions(+), 4 deletions(-)

 kernel/ksyms.c |    3 +++
 mm/filemap.c   |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

 journal.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

 dir.c   |    6 +++---
 inode.c |   14 +++++++-------
 namei.c |   18 +++++++++---------
 super.c |   30 +++++++++++++++---------------
 4 files changed, 34 insertions(+), 34 deletions(-)

 Config.help |   33 ++++++++++++---------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

 file.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


ChangeSet@1.664, 2002-10-02 22:16:12+04:00, green@angband.namesys.com
  Small buglet in reiserfs_file_write fixed, that was found during 2.4 stage testing, but somehow it was lost in 2.5 version

ChangeSet@1.663, 2002-10-01 17:29:34+04:00, green@angband.namesys.com
  Update reiserfs config help entries.

ChangeSet@1.662, 2002-10-01 17:13:13+04:00, green@angband.namesys.com
  reiserfs: C99 designated initializers, by Art Haas

ChangeSet@1.661, 2002-10-01 17:12:19+04:00, green@angband.namesys.com
  lock_kernel is replaced with per superblock lock (kind of)

ChangeSet@1.660, 2002-10-01 17:11:32+04:00, green@angband.namesys.com
  export generic_osync_inode,block_commit_write, remove_suid

ChangeSet@1.659, 2002-10-01 17:09:56+04:00, green@angband.namesys.com
  reiserfs_file_write() implemenation. Ported from 2.4

ChangeSet@1.658, 2002-10-01 17:08:55+04:00, green@angband.namesys.com
  reiserfs: Implement insertion of more than one unformatted pointer insertion at a time. Considerably speedup hole creation.

ChangeSet@1.657, 2002-10-01 17:07:40+04:00, green@angband.namesys.com
  reiserfs: Fix a problem with delayed unlinks and remounting RW filesystem RW.

ChangeSet@1.656, 2002-10-01 17:06:40+04:00, green@angband.namesys.com
  reiserfs: Take into account file information even when not doing preallocation. Fixes a bug with displacing_large_files option.




--------------030306020509040903030401--

