Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWFOGlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWFOGlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWFOGlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:41:35 -0400
Received: from thunk.org ([69.25.196.29]:11409 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932450AbWFOGle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:41:34 -0400
Date: Thu, 15 Jun 2006 00:55:51 -0400
From: Theodore Tso <tytso@mit.edu>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060615045550.GB7318@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"Barry K. Nathan" <barryn@pobox.com>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz> <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com> <20060614213431.GF4950@ucw.cz> <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 05:28:31PM -0700, Barry K. Nathan wrote:
> BTW, I actually have a test filesystem here (an e2image from an actual
> filesystem I encountered once) that used to cause e2fsck 1.36/1.37 to
> segfault. Strangely, more ancient versions (like what ships in Red Hat
> 7.2) were able to repair it without segfaulting. In a few days, once
> other stuff calms down for me, I need to revisit that and see if the
> bug still exists with 1.39.

Please try it with 1.39; if it still crashes, let me know --- I treat
any filesystem corruptions that causes e2fsck to crash or which e2fsck
can't fix in a single pass to be a bug.  I'm guessing though that this
was probably this bug which was fixed right after 1.38 released (some
distributions did have the fix, but it's in the mainline e2fsprogs
starting with 1.39):

2005-07-04  Theodore Ts'o  <tytso@mit.edu>

	* pass2.c (e2fsck_process_bad_inode): Fixed bug which could cause
		e2fsck to core dump if a disconnected inode contained an
		extended attribute.  This was actually caused by two bugs.
		The first bug is that if the inode has been fully fixed
		up, the code will attempt to remove the inode from the
		inode_bad_map without checking to see if this bitmap is
		present.  Since it is cleared at the end of pass 2, if
		e2fsck_process_bad_inode is called in pass 4 (as it is for
		disconnected inodes), this would result in a core dump.
		This bug was mostly hidden by a second bug, which caused
		e2fsck_process_bad_inode() to consider all inodes without
		an extended attribute to be not fixed.  (Addresses Debian
		Bug: #316736)

						- Ted
