Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVD1I76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVD1I76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVD1I7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:59:43 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53204 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261948AbVD1I5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:57:17 -0400
Date: Thu, 28 Apr 2005 10:56:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: pasky@ucw.cz, torvalds@osdl.org, Greg KH <greg@kroah.com>
Subject: kernel hacker's git howto
Message-ID: <20050428085657.GA30800@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's my current version of git HOWTO. I'd like your comments...

	Kernel hacker's guide to git
	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      2005 Pavel Machek <pavel@suse.cz>

You can get cogito at http://www.kernel.org/pub/software/scm/cogito/
. Compile it, and place it somewhere in $PATH. Then you can get kernel
by running

mkdir clean-cg; cd clean-cg
cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

... Do cg-update origin to pickup latest changes from Linus. You can
do cg-diff to see what changes you done in your local tree. cg-cancel
will kill any such changes, and cg-commit will make them permanent.

To get diff between your working tree and "next tree up", do cg-diff
-r origin: . If you want to get the same diff but separated
patch-by-patch, do cg-mkpatch origin: . If you want to pull changes
from the "up" tree to your working tree, do cg-pull origin followed by
cg-merge origin.


How to set up your trees so that you can cooperate with linus
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

What I did:

Created clean-cg. Initialized straight from Linus (as above). Then I
created "nice" tree, good for Linus to pull from 

mkdir /data/l/linux-good; cd /data/l/linux-good
cg-init /data/l/clean-cg

and then my working tree, based on linux-good

mkdir /data/l/linux-cg; cd /data/l/linux-cg
cg-init /data/l/linux-good

. I do my work in linux-cg. If someone sends me nice patch I should
pass up, I apply it to linux-good with nice message and do

cd /data/l/linux-cg; cg-pull origin; cg-merge origin

-- 
Boycott Kodak -- for their patent abuse against Java.
