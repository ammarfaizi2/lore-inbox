Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWDVAwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDVAwf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDVAwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:52:35 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:22943 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750800AbWDVAwe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:52:34 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: What's in git.git
cc: linux-kernel@vger.kernel.org
X-maint-at: 34fd1c9ac5845d541e3196983df7f993e751b544
X-master-at: 70827b15bfb11f7aea52c6995956be9d149233e1
Date: Fri, 21 Apr 2006 17:52:00 -0700
Message-ID: <7vzmieo2j3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* The 'maint' branch has these fixes since the last announcement.
  They will be part of 1.3.1 early next week.

  - Fix diff --stat filename output when binary files with long
    names are involved (Jonas Fonseca)

  - git-merge gives a bit more readable user guidance upon conflicts.

  - The example pre-commit hook complains about conflict markers.

  - Two fixes to git-commit --amend.

  - Fix pack-objects.  This was discussed in this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/19021

  - mailinfo: decode underscore used in "Q" encoding properly.

    The versions before this fix broke some peoples names;
    apologies to Santi and Lukas.

  - Fix spawning of PAGER (Linus Torvalds).  This was discussed
    in this thread:

    http://thread.gmane.org/gmane.comp.version-control.git/18969

  - Fix pack-object buffer size (Nicolas Pitre)

  - Reintroduce svn pools to solve the memory leak (Santi Béjar)

  - Document git-clone --reference (Shawn Pearce)


* The 'master' branch has these since the last announcement.
  All the 'maint' fixes are included.

  - Big 'revision.c/log-tree.c' option parsing unification (Linus).
  - Big log formatting unification (Linus).
  - Built-in git-whatchanged.
  - Do not fork PAGER=cat
  - combine-diff --stat: show diffstat with the first parent.
  - get_sha1() shorthands for blob/tree objects (Linus)
  - Allow "git repack" users to specify repacking window/depth (Linus)
  - Split up builtin commands into separate files from git.c (Linus)

    Most of the above happened immediately after 1.3.0, and will
    not be part of 1.3.X series, which is maintenance fixes only.

    The general direction is that many commands we used to
    implement as one liner pipe from git-rev-list to
    git-diff-tree are converted into built-in C implementation.

* The 'next' branch, in addition, has these.

  - daemon::socksetup: don't return on set_reuse_addr() error (Serge E. Hallyn)

    Comments?

  - Tentative built-in format-patch

    This is meant to be the next in the "internalize rev-list
    piped to diff-tree" series.  Currently it does only --stdout
    form and does not take any options.  It needs more work in
    the core area to spit things out into separate files with
    munged filenames.

  - git-update-index --unresolve.  This was discussed in this
    thread:

    http://thread.gmane.org/gmane.comp.version-control.git/18936

    This thread was fruitful; three patches came out of it.

  - diff --stat: do not drop rename information.

    I think this is ready to graduate to "master"; I just
    haven't got around to it.

    Johannes suggested "file => /dev/null" to show a deleted
    file as if a rename was done.  While I think it makes some
    sense, I am afraid it diverges too much from the traditional
    diffstat output.  I am undecided, somewhat negative, about
    the suggestion.

* The 'pu' branch, in addition, has these.

  - gitk: Fix geometry on rootless X (Johannes Schindelin)

  - "bind commit" resurrected.

    Somebody off-list volunteered to look into adding
    subprojects support, so I merged the old codebase and placed
    it here.  The merge conflict was not too bad, to my
    surprise.  Subpro.txt file in the "todo" branch describes
    one suggested plan, but who he codes gets to decide the
    details of the implementation and semantics, so we will see
    what emerges.  One big piece still missing from the core
    side to implement Subpro.txt plan is an enhancement to the
    index file format to do "update-index --bind/--unbind".  I
    may have to fill that gap over the weekend, but no firm
    promises.

  - contrib/colordiff.

    This is an external colorizer you can use by saying:
    
	PAGER="colordiff | less -RS" git log --cc

  - colored diff with diff.usecolor configuration option.

    I'll not be using colorization myself, so there is no strong
    incentive on my part to carry this forward, but this is here
    just in case if people are interested.  Currently it does
    not do color for combined diffs.




