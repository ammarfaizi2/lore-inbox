Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbTAJWES>; Fri, 10 Jan 2003 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbTAJWES>; Fri, 10 Jan 2003 17:04:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40967 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266425AbTAJWER>; Fri, 10 Jan 2003 17:04:17 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
Date: Fri, 10 Jan 2003 22:11:59 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <avngff$1l4$1@penguin.transmeta.com>
References: <sjmlm1t5489.fsf@kikki.mit.edu>
X-Trace: palladium.transmeta.com 1042236771 17990 127.0.0.1 (10 Jan 2003 22:12:51 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Jan 2003 22:12:51 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <sjmlm1t5489.fsf@kikki.mit.edu>,
>
>I've been trying to get a current 2.5 kernel up and running but I've
>hit a wall.  When I run my machine with a current kernel I get the
>following message to my terminal, repeated ad nausium:
>
>  PANIC: INIT: segmentation violation at 0x804a08c (code)! sleeping for 30 seconds!

Hmm.. Can you try to pinpoint more exactly the change that caused it? 

>In case anyone cares, the most recent ChangeSet from my
>confirmed-working (2.5.53+) tree is labeled:
>
>  1.1004 02/12/30 13:47:09 torvalds@home.transmeta.com +2 -0
>  Make x86 platform choice strings more easily selectable
>
>However I have not guaranteed that this is the Changeset just before
>it failed (I'm not enough of a bk guru to figure out how to pull down
>one changeset at a time).

Don't pull one at a time - instead just get my latest BK tree, and then
you can do

	bk clone -ql -rXXXX linus-BK test-tree

to get a tree with the top-of-tree being XXXX.

Together with "bk revtool" you can traverse the merge tree to decide on
interesting points you want to back up further with. If, for example,
the kernel still doesn't work at XXXX, you can then do a 

	cd test-tree
	bk revtool 
	.. find an interesting spot YYYY ...
	bk undo -aYYYY

to clip some changes from the test-tree to see if that helps.

		Linus
