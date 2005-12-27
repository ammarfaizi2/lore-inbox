Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVL0ItU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVL0ItU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 03:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVL0ItT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 03:49:19 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46785 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932269AbVL0ItT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 03:49:19 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] GIT preformatted documentation available.
cc: Willy Tarreau <willy@w.ods.org>
Date: Tue, 27 Dec 2005 00:49:17 -0800
Message-ID: <7vu0cuc4c2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was asked to provide pre-formatted man pages (and perhaps html
pages), since the time of kernel developers are better spent on
what they do best, rather than preparing the xmlto toolchain.

I was planning to do a tarball every time I do a "release", but
that would mean it is no better than the current way --- you
could extract manpages out of rpm anyway.

So instead, I'll do independent branches "html" and "man" in
git.git repository to keep the preformatted documentation.

	$ mkdir git.man ; cd git.man
	$ git init-db
        $ ID=$(git fetch-pack -k git://git.kernel.org/pub/scm/git/git man)
        $ expr "$ID" : '\(.*\) .*' >.git/refs/heads/master
        $ cat .git/refs/heads/master >.git/refs/heads/origin
	$ git checkout; /bin/ls -aF
	./  ../  .git/	man1/  man7/
        $ echo >.git/remotes/origin <<\EOF
        URL: git://git.kernel.org/pub/scm/git/git
        Pull: man:origin
        EOF

Would set you up, and you can
to keep them up-to-date, and install them like so:

	$ cd git.man
	$ git pull
	$ cp -a man1 man7 /usr/local/man/

The "html" branch is similar; it is a copy of what is shown at
http://www.kernel.org/pub/software/scm/git/docs/.

This means if you clone from git.git repository, you would end
up with something like this in .git/remotes/origin file:

	URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: master:origin
        Pull: todo:todo
        Pull: html:html
        Pull: man:man
        Pull: pu:pu
        Pull: maint:maint

Typically, for the repository to track GIT itself, you would
want to trim them like this:

	URL: git://git.kernel.org/pub/scm/git/git.git
        Pull: master:origin
        Pull: maint:maint
        Pull: +pu:pu



