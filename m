Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751677AbWGZPnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWGZPnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 11:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWGZPnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 11:43:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29323 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751677AbWGZPnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 11:43:21 -0400
Subject: Nasty git corruption problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 17:01:55 +0100
Message-Id: <1153929715.13509.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just hit a real nasty, although I suspect its not a common case but it
does seem to show a problem git has other version control systems don't
(so far anyway)

During a git rebase my machine crashed. Git claims that the rebase is
complete but contains none of the outstanding 30 odd patches. There is
no .dotest directory and git-fsck-objects produces some warnings about a
few dangling objects, but these objects aren't the relevant ones (at
least directly)

CVS and SVN in crashes don't lose old stuff, though they are pretty good
at losing the last commit or two. Git rebase appears to be able to lose
two weeks of old changes even though they were stable on disk, which is
not good at all.

Doing

for i in *; do (cd $i; for j in *; do git-unpack-file $i$j; done; );
done

shows that lots of the changes are still somewhere in the object tree
but there seems to be no tool for fixing rather than moaning about
objects dangling, and also no obvious way to fix it. Also curiously many
of the objects appear linked somewhere but don't show up in the git-log
for the afflicted branch at all.






