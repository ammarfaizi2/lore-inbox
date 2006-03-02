Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWCBGYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWCBGYe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWCBGYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:24:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49899 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751398AbWCBGYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:24:33 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.2.4
cc: linux-kernel@vger.kernel.org
Date: Wed, 01 Mar 2006 22:24:30 -0800
Message-ID: <7vslq19xep.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest maintenance release GIT 1.2.4 is available at the
usual places:

	http://www.kernel.org/pub/software/scm/git/

	git-1.2.4.tar.{gz,bz2}			(tarball)
	RPMS/$arch/git-*-1.2.4-1.$arch.rpm	(RPM)

Among some fixes, there is one feature item: war on whitespace.

This was done in response to Andrew Morten's request, and
backported from the primary development track.

When you apply an e-mailed patch with git-am (or git-applymbox),
if the patch introduces new trailing whitespaces, you will get
warning messages by default.  This behaviour can be tweaked by
setting the configuration item "apply.whitespace" to various
values.

For kernel subsystem maintainers, the earlier Andrew's requests
translate to setting it to either "error" or "strip".

E.g.

	$ git repo-config apply.whitespace error

What are the available choices, and which one is for you?

 * If you are a busy top echelon person who cares about tree
   cleanliness, apply.whitespace=error is a good choice.  This
   stops after giving a handful error messages, and refuses to
   apply a patch that introduces trailing whitespaces.  After
   the failed patch, you should return the patch to the
   submitter; your tree remains clean.

 * apply.whitespace=error-all is a better choice for you, if you
   are willing to clean up other peoples' mess.  You will get
   all errors, and the patch is not applied.  You can go through
   with your editor (e.g. Emacs users can use C-x `; I hope vim
   users have similar macros) and fix things in .dotest/patch.
   After fixing them up, "git am" without flags (or "-i" for
   "interactive" if you want) to apply it.  Do not forget to
   tell the person who wasted your time doing this to be more
   careful next time.

 * If you do not care much about new trailing whitespaces, there
   is apply.whitespace=warn, which is the default.  This shows
   warning messages and applies the patch.  Make a mental note
   to scold the patch submitter to be careful the next time.

 * If you care about cleanliness, want to be nice to the
   submitters by not forcing them to resubmit solely on
   whitespace basis, but not nice enough to educate them,
   apply.whitespace=strip is for you.  This applies the patch
   after stripping the trailing whitespaces it introduces.

 * If you do not care about whitespace errors at all,
   apply.whitespace=nowarn is for you.  No warnings, no errors.

----------------------------------------------------------------

Changes since v1.2.3 are as follows:

Alex Riesen:
      fix t5600-clone-fail-cleanup.sh on windows

Josef Weidendorfer:
      git-mv: Allow -h without repo & fix error message
      git-mv: fixes for path handling

Junio C Hamano:
      checkout - eye candy.
      Give no terminating LF to error() function.
      diffcore-rename: plug memory leak.
      git-am: do not allow empty commits by mistake.
      sample hooks template.
      apply --whitespace fixes and enhancements.
      apply: squelch excessive errors and --whitespace=error-all
      apply --whitespace: configuration option.
      git-apply --whitespace=nowarn
      git-apply: war on whitespace -- finishing touches.
      git-am: --whitespace=x option.
      diffcore-break: micro-optimize by avoiding delta between identical files.
      Allow git-mv to accept ./ in paths.

Linus Torvalds:
      The war on trailing whitespace

Mark Wooding:
      combine-diff: Honour --full-index.
      combine-diff: Honour -z option correctly.

