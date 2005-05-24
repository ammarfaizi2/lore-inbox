Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVEXLSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVEXLSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 07:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEXLSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 07:18:03 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:23493 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262005AbVEXJTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:19:36 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091932.BA088FA1A@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:19:32 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 81DEEF9F8

	for <buffer@sniffo.org>; Tue, 24 May 2005 08:13:15 +0200 (CEST)

Received: from oss (localhost [127.0.0.1])

	by oss.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id j4O68kF3022359;

	Mon, 23 May 2005 23:08:46 -0700

Received: with ECARTIS (v1.0.0; list netdev); Mon, 23 May 2005 23:07:10 -0700 (PDT)

Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])

	by oss.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id j4O676F3022037

	for <netdev@oss.sgi.com>; Mon, 23 May 2005 23:07:06 -0700

Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])

	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O66LjA023291

	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);

	Mon, 23 May 2005 23:06:21 -0700

Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])

	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O66KuD011104;

	Mon, 23 May 2005 23:06:20 -0700

Date: Mon, 23 May 2005 23:08:25 -0700 (PDT)

From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates

In-Reply-To: <4292BA66.8070806@pobox.com>

Message-ID: <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org>

References: <4292BA66.8070806@pobox.com>

MIME-Version: 1.0

Content-Type: TEXT/PLAIN; charset=US-ASCII

X-MIMEDefang-Filter: osdl$Revision: 1.109 $

X-Scanned-By: MIMEDefang 2.36

X-archive-position: 1545

X-ecartis-version: Ecartis v1.0.0

Sender: netdev-bounce@oss.sgi.com
Errors-To: netdev-bounce@oss.sgi.com
X-original-sender: torvalds@osdl.org

Precedence: bulk

X-list: netdev

X-Virus-Scanned: ClamAV 0.83/892/Mon May 23 10:52:19 2005 on oss.sgi.com

X-Virus-Status: Clean





On Tue, 24 May 2005, Jeff Garzik wrote:

> Please pull the 'for-linus' branch from
> 
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

Is this really what you meant to do? There's seven merges there, none of
which have _any_ information about _what_ you merged, because you've mixed
everything up in one tree, so that there's absolutely no record of the
fact that you actually had seven different repositories that you pulled..

That sucks, Jeff.

I don't understand why you don't use different trees, like you did with
BK. You can share the object directory with the different trees, but the
way you work now, it all looks like mush.

Even if you don't get confused youself, you sure are confusing everybody 
else with it..

Anyway, if you really want to work this way, with one big mushed-together
thing that has different heads that you keep track of, can you _please_ at
least make the commit message tell what you're doing. It's not a complex 
script, and you're definitely mis-using it as things stand now by 
switching heads around inside one repository, and not telling other people 
about it.

--- side note ---

Also, the way you work, I think you actually may want to do a multi-parent
merge. That is, you may want to merge multiple parents in _one_ commit,
rather than having seven commits for it.

The way to do that is to just do "git-read-tree -m" (and the subsequent 
merge) several times. You do not have to commit in between each step, you 
just need to remember the parents, and then you do the final commit with

	git-commit-tree $result_tree -p $head -p $p1 -p $p2 -p $p3 ...

ie you build up a commit command line that grows one more "-p xxxx" for 
each parent you have merged. That requires a bit more work, but as it is, 
your merges just look like crap.

--- end side note ----

Please?

		Linus

----
commit fd3fac6ffe20bc6ca75b3ad38be0a8be6666b5d3
tree 49b4cfa6c95094612438b1ddeb0c9511a19125fe
parent c97f5a778ed33aef8f62496d7b82ba3cb896a587
parent b3dd65f958354226275522b5a64157834bdc5415
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:47:58 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:47:58 -0400

    Automatic merge of /spare/repo/netdev-2.6/.git

commit c97f5a778ed33aef8f62496d7b82ba3cb896a587
tree c72dbed812b0ffa83700a1896895714248407daf
parent 09fc75b6757852798969e7585456499784a982e1
parent 1bcd315362e215a72b56d1330bbf32f1c74eefb5
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:47:43 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:47:43 -0400

    Automatic merge of /spare/repo/netdev-2.6/.git

commit 09fc75b6757852798969e7585456499784a982e1
tree 60a2d2893cb757307edf0a0c450689610644cac2
parent b5545f2a2d915f5b6d86fb57e6ccc96b3010259e
parent ac79c82e793bc2440c4765e5eb1b834d2c18edf2
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:47:28 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:47:28 -0400

    Automatic merge of /spare/repo/netdev-2.6/.git

commit b5545f2a2d915f5b6d86fb57e6ccc96b3010259e
tree 0ece2dd139d1fa4a6b0c5f61fc2be75692d0ea47
parent f180e742711ce512e62161436d166eb4df92b34d
parent 2648345fcbadfae8e7113112ff9402e465a184dc
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:47:20 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:47:20 -0400

    Automatic merge of /spare/repo/netdev-2.6/.git

commit f180e742711ce512e62161436d166eb4df92b34d
tree 21fcfc0ca4a47776bc1182898d9b394529aa1daf
parent 7b5c2db59567052805771e1de2ad4e089b88c847
parent 042e2fb70006f135469d546726451b7d14768980
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:47:12 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:47:12 -0400

    Automatic merge of /spare/repo/netdev-2.6/.git

commit 7b5c2db59567052805771e1de2ad4e089b88c847
tree d18dc44dcfd34a99ac11a83e6d324730784b7d81
parent 02dd6b49b3f75dacfa7eddf7f2faa8b810906e47
parent 9092f46b5aed4515d9a427d5dab3be1584851f07
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:45:05 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:45:05 -0400

    Merge of /spare/repo/netdev-2.6/.git

commit 02dd6b49b3f75dacfa7eddf7f2faa8b810906e47
tree 240cfa2396a6ed006ee28f3848b4cceebfc35b11
parent 187a1a94d629621d1471b42308e63573b1150773
parent dfa1b73ffb414b64dc0452260132a090eb25bf52
author <jgarzik@pretzel.yyz.us> Tue, 24 May 2005 00:44:49 -0400
committer Jeff Garzik <jgarzik@pobox.com> Tue, 24 May 2005 00:44:49 -0400

    Automatic merge of /spare/repo/netdev-2.6/.git




