Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWDZLJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWDZLJf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDZLJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:09:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19161 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932394AbWDZLJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:09:33 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: What's in git.git
cc: linux-kernel@vger.kernel.org
X-maint-at: 7d09fbe4ab7f080a8f8f5dcef7e0f3edf5e26019
X-master-at: 3496277a561307c3d31d2085347af8eb4c667c36
Date: Wed, 26 Apr 2006 04:09:32 -0700
Message-ID: <7vhd4goaoj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* The 'maint' branch has fixes mentioned in the 1.3.1 
  announcement.

  As I outlined in the 1.3.1 maintenance release announcement,
  people with that release will soon be missing many
  improvements.  The following is a list of what to expect.


* In addition to the above. the 'master' branch has these since
  the last announcement,

  - git-update-index --chmod=+x now affects all the subsequent
    files (Alex Riesen).

  - git-update-index --unresolve paths...; this needs
    documentation (hint).

  - minor "diff --stat" and "show --stat" fixes.

  - Makefile dependency fixes.  This fixes the infamous
    "libgit.a still contains stale diff.o" problem.

  - contrib has colordiff that understands --cc output.

  - beginning of libified "git diff" family.

  - git-commit-tree <ent> -p <parent> now takes extended SHA1
    expression, not limited to 40-byte SHA1, for <ent> (it
    already did so for <parent>).

  - updated gitk to handle repositories with large number of
    tags and heads (Paul).


* The 'next' branch, in addition, has these.

  - internal log/show/whatchanged family (Linus and me).

  - beginning of internal format-patch.

  - Geert's similarity code in contrib/

  - cache-tree optimization to speed up git-apply + write-tree
    cycles.

    Initially I was getting close to 50% improvement, but
    re-benching suggests it is more like 16%.  An earlier
    version in 'next' used a separate .git/index.aux to record
    the cache-tree information but now it is stored as part of
    the index.  If you used previous 'next' (ha, ha) version and
    see tmp-indexXXXX.aux or next-indexXXXX.aux files left in
    your $GIT_DIR, they can safely be removed.

  - more "diff --stat" fixes.

  - git-cvsserver: typofixes.

  - diff-delta interface reorganization (Nico)

  - git-repo-config --list (Pasky)


* The 'pu' branch, in addition, has these.

  - resurrect "bind commit"; this has been done only partially.

    I have not updated the rev-list/fsck-objects yet.  Probably
    need to drop the specific "bind " line and replace it with
    "link object bind" in the commit objects before going
    forward.

  - get_sha1(): :path and :[0-3]:path to extract from index.

  - Loosening path argument check a little bit in revision.c.

    I've been meaning to do the opposite of this, the tightening
    of ambiguous case mentione by Linus, but haven't got around
    to yet (I haven't got around to too many things, hint hint).

  - reverse the pack-objects delta window logic (Nico)

    This is in theory the right thing to do, but things are not
    quite there yet.  But Nico is on top of it so we will see
    quite an improvement in the pack generation hopefully very
    soon.

