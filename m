Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWERIwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWERIwq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWERIwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:52:46 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:45240 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751183AbWERIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:52:45 -0400
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
Subject: [WARNING] Please be careful when using "git add" from "next" branch
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
	<7v64k3698l.fsf@assigned-by-dhcp.cox.net>
	<7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
cc: linux-kernel@vger.kernel.org
Date: Thu, 18 May 2006 01:52:44 -0700
In-Reply-To: <7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 18 May 2006 01:34:45 -0700")
Message-ID: <7vsln74sv7.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is still a small breakage in the built-in "git add" on the
"next" branch that ends up creating nonsense tree objects.

        $ mkdir foo
        $ date >bar
        $ git-add foo/../bar
        $ git ls-files
        foo/../bar
        $ git ls-tree -r -t $(git-write-tree)
        040000 tree ef5562cd3a9bf66d41a8d4f42f159e8c694ce7e3	foo
        040000 tree 6e1612248e8da43fc5f91592e559da1ad5f9a852	foo/..
        100644 blob 53ab446c3f4e42ce9bb728a0ccb283a101be4979	foo/../bar

If you do not do funky things like foo/../bar, I do not think
you have to worry, but scripted use might break.  It used to
warn and ignore such bogus input, but now it happily accepts it
and produces bogus index which results in bogus trees.

"git update-index --add" is not affected by this breakage.

