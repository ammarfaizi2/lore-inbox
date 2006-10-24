Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160994AbWJXMGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160994AbWJXMGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 08:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWJXMGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 08:06:41 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:712 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1160994AbWJXMGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 08:06:41 -0400
Date: Tue, 24 Oct 2006 14:04:47 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: torvalds@osdl.org, ctpm@ist.utl.pt, linux-kernel@vger.kernel.org
Subject: Re: Unintended commit?
In-Reply-To: <20061023.141040.59654407.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0610241402430.11608@yvahk01.tjqt.qr>
References: <200610231809.09238.ctpm@ist.utl.pt> <Pine.LNX.4.64.0610231013340.3962@g5.osdl.org>
 <20061023.141040.59654407.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I should make some modifications to my workflow so that I don't do
>this again when I need to make local unrelated changes in order to
>test the current tree.
>
>When I'm grinding out a patch actively in my tree I go "git diff >diff"
>and then I use a script called "mkcf" which runs diffstat on the
>diff and gives me a file list, it's ugly, but here it is:
>
>#!/bin/sh
>diffstat -p 1 $* | grep -v changed | awk ' { print $1 } '
>
>So I end up going:
>
>1) edit files
>2) git diff >diff
>3) read diff
>4) git commit $(mkcf diff)
>
>Usually step #3 catches local changes I'm not intending to commit
>and I just edit those out, and therefore they never end up being
>committed.
>
>Perhaps it would be cool if you could tell GIT "Look, I know I have
>a change to foo.c, but it's a local hack and please act like it's
>not there unless I try to do an operation where ignoring that change
>is impossible, such as a merge."

I prefer to explicitly commit all changes, i.e.:

  edit files
  `svn diff` or `svn diff | lsdiff` or both
  `svn ci -m foo a/b.c c/d.c` etc.

might be a little lot to type, but it usually helps committing the right stuff.

(Yes, it is intentional that I wrote svn instead of git.)


	-`J'
-- 
