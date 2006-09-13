Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751604AbWIMG0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbWIMG0l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWIMG0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:26:41 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:37300 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751587AbWIMG0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:26:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 06:26:23 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ee88af$fgo$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <20060913043319.GH541@1wt.eu> <ee8589$e70$1@taverner.cs.berkeley.edu> <1BB4231A-7D69-4A77-A050-1C633BDFA545@mac.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158128783 15896 128.32.168.222 (13 Sep 2006 06:26:23 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 13 Sep 2006 06:26:23 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett  wrote:
>On Sep 13, 2006, at 01:34:01, David Wagner wrote:
>> So it sounds like git-tar-tree has a bug; its default isn't setting
>> meaningful permissions on the files that it puts into the tar archive.
>> I hope the maintainers of git-tar-tree will consider fixing this bug.
>
>Let me reiterate:  This is not a bug!

I think it is a bug.  It sounds like git-tar-tree is storing the wrong
set of permissions in the tar archive.  When I run "tar cf foo.tar
bar", and bar has permissions 0644, then tar inserts an entry into the
archive for "bar" with its permissions listed as 0644 (*not* 0666).
If "tar cf foo.tar bar" just ignored the permissions on bar and always
used a default of 0666 out of laziness, that would be a bug in "tar cf".
The same goes for git-tar-tree.  It seems to me that git-tar-tree ought
to behave the same as "tar cf".

In any case, regardless of whether this is by design or not, it is not
courteous to your users to distribute tar files where all the files have
permissions 0666.  That's not a user-friendly to do.
