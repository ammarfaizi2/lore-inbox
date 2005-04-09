Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVDJMAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDJMAr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDJMAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:00:46 -0400
Received: from fmr22.intel.com ([143.183.121.14]:30098 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261480AbVDJMAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:00:39 -0400
From: tony.luck@intel.com
Message-Id: <200504101200.j3AC0Mu13146@unix-os.sc.intel.com>
Date: Sat, 9 Apr 2005 14:00:09 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
cc: Petr Baudis <pasky@ucw.cz>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
In-Reply-To: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org>
 <20050409200709.GC3451@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>In other words, each "commit" file is very small and cheap, but since 
>almost every commit will also imply a totally new tree-file, "git" is 
>going to have an overhead of half a megabyte per commit. Oops.
>
>Damn, that's painful. I suspect I will have to change the format somehow.

Having dodged that bullet with the change to make tree files point at
other tree files ... here's another (potential) issue.

A changeset that touches just one file a few levels down from the top
of the tree (say arch/i386/kernel/setup.c) will make six new files in
the git repository (one for the changeset, four tree files, and a new
blob for the new version of the file). More complex changes make more
files ... but say the average is ten new files per changeset since most
changes touch few files.  With 60,000 changesets in the current tree, we
will start out our git repository with about 600,000 files.  Assuming
the first byte of the SHA1 hash is random, that means an average of 2343
files in each of the objects/xx directories.  Give it a few more years at
the current pace, and we'll have over 10,000 files per directory.  This
sounds like a lot to me ... but perhaps filesystems now handle large
directories enough better than they used to for this to not be a problem?

Or maybe the files should be named objects/xx/yy/zzzzzzzzzzzzzzzz?

-Tony
