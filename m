Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbVFYFOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbVFYFOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 01:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbVFYFOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 01:14:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4039 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S263340AbVFYFNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 01:13:51 -0400
Message-ID: <42BCE80A.2010802@pobox.com>
Date: Sat, 25 Jun 2005 01:13:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel Hackers Guide to git (v3)
Content-Type: multipart/mixed;
 boundary="------------020809050601000305070204"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809050601000305070204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

See attached.

An HTML version is also available at http://linux.yyz.us/git-howto.html

	Jeff



--------------020809050601000305070204
Content-Type: text/plain;
 name="git-howto.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-howto.txt"



Kernel Hackers' Guide to git


1) installing git

git requires bootstrapping, since you must have git installed in order
to check out git.git (git repo), and linux-2.6.git (kernel repo).  I
have put together a bootstrap tarball of a recent git repository.

Download tarball from:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050622.tar.bz2

tarball build-deps:  zlib, libcurl, libcrypto (openssl)

install tarball:  unpack && make && sudo make prefix=/usr/local install

jgarzik helper scripts, not in official git distribution:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script

After reading the rest of this document, come back and update your copy
of git to the latest:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git


2) download a linux kernel tree for the very first time

$ git clone \
   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
   linux-2.6
$ cd linux-2.6
$ rsync -a --delete --verbose --stats --progress \
   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
   .git/


NOTE:  The kernel tree is very large.  This constitutes downloading
several hundred megabytes of data.


3) update local kernel tree to latest 2.6.x upstream ("fast-forward merge")

$ cd linux-2.6
$ git-pull-script \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


4) check out files from the git repository into the working directory

$ git checkout -f


5) check in your own modifications (e.g. do some hacking, or apply a
patch)

# go to repo
$ cd linux-2.6

# make some modifications
$ vi drivers/net/sk98lin/skdim.c

# NOTE: add '--add' and/or '--remove' if files were added or removed
$ git-update-cache <list of all files changed>

# check in changes
$ git commit


6) List all changes in working dir, in diff format.

$ git diff


7) Obtain summary of all changes in working dir

$ git status


8) List all changesets (i.e. show each cset's description text) in local
branch of local tree, that are not present in remote tree.

$ cd my-kernel-tree-2.6
$ git-changes-script -L ../linux-2.6 | less


9) List all changesets:

$ git log


10) apply all patches in a Berkeley mbox-format file

First, download and add to your PATH Linus's git tools:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git-tools.git

$ cd my-kernel-tree-2.6
$ dotest /path/to/mbox  # yes, Linus has no taste in naming scripts


11) don't forget to download tags from time to time.

git-pull-script only downloads sha1-indexed object data, and the
requested remote head.  This misses updates to the .git/refs/tags/ and
.git/refs/heads directories.  It is advisable to update your kernel .git
directories periodically with a full rsync command, to make sure you got
everything:

$ cd linux-2.6
$ rsync -a --delete --verbose --stats --progress \
   rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
   .git/


12) list all branches

$ ls .git/refs/heads/


13) make desired branch current in working directory

$ git checkout -f $branch


14) create a new branch, and make it current

$ cp .git/refs/heads/master .git/refs/heads/my-new-branch-name
$ git checkout -f my-new-branch-name


15) examine which branch is current

$ ls -l .git/HEAD


16) undo all local modifications (same as checkout):

$ git checkout -f


17) obtain a diff between current branch, and master branch

In most trees WITH BRANCHES, .git/refs/heads/master contains the current
'vanilla' upstream tree, for easy diffing and merging.  (in trees
without branches, 'master' simply contains your latest changes)

$ git diff master..HEAD


--------------020809050601000305070204--
