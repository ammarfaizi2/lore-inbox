Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWHCP0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWHCP0b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWHCP0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:26:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29157 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964787AbWHCP0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:26:30 -0400
To: torvalds@osdl.org
Subject: [git pull] misc audit fixes
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Message-Id: <E1G8f5h-00040R-PT@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 03 Aug 2006 16:26:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Audit fixes: a bunch of bug fixes from Amy + overhead reduction for
case when no rules are loaded (lazy-audit) from me.  The latter speeds
"audit enabled, no rules present" to the level of "audit disabled".  The
current tree has about 15--20% overhead for that case on loads like "do a lot
of access(2)"; that gets killed by these patches.

Please, pull from
git://git.kernel.org/pub/scm/linux/kernel/git/viro/audit-current.git/ audit.b25

diffstat:
 fs/namei.c               |    8 ++-
 include/linux/audit.h    |   43 +++++++++++------
 include/linux/fsnotify.h |    6 +-
 kernel/audit.c           |    4 -
 kernel/auditfilter.c     |   26 ++++++++++
 kernel/auditsc.c         |  117 ++++++++++++++++++++++++++++++-----------------
 6 files changed, 140 insertions(+), 64 deletions(-)

Al Viro:
      introduce audit rules counter
      mark context of syscall entered with no rules as dummy
      don't bother with aux entires for dummy context
      take filling ->pid, etc. out of audit_get_context()

Amy Griffis:
      fix faulty inode data collection for open() with O_CREAT
      fix missed create event for directory audit
      fix oops with CONFIG_AUDIT and !CONFIG_AUDITSYSCALL
      fix audit oops with invalid operator
