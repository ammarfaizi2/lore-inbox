Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVCQOpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVCQOpg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVCQOpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:45:36 -0500
Received: from gw.alcove.fr ([81.80.245.157]:64746 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262161AbVCQOpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:45:24 -0500
Date: Thu, 17 Mar 2005 15:45:22 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Larry McVoy <lm@bitmover.com>
Subject: BKCVS broken ?
Message-ID: <20050317144522.GK22936@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current bkcvs export is broken, several recent changesets are
missing from it.

This occurs at least in the mm/ directory, but I haven't verified
if other directories are not affected. I detected this problem
because the head of bkcvs doesn't compile anymore and shows errors
in mm/* missing symbols.

One example:

Take this changeset from Changeset,v:
-------------------------------------------------------------
1.27702
log
@[PATCH] orphaned pagecache memleak fix

Chris found that with data journaling a reiserfs pagecache may be truncate
while still pinned.  The truncation removes the page->mapping, but the page
is still listed in the VM queues because it still has buffers.  Then during
the journaling process, a buffer is marked dirty and that sets the PG_dirty
bitflag as well (in mark_buffer_dirty).  After that the page is leaked
because it's both dirty and without a mapping.

So we must allow pages without mapping and dirty to reach the PagePrivate
check.  The page->mapping will be checked again right after the PagePrivate
check.

Signed-off-by: Andrea Arcangeli <andrea@@suse.de>
Signed-off-by: Andrew Morton <akpm@@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@@osdl.org>

BKrev: 4234d7beMW4wcFI6ltxdMMhApwDmuA
-------------------------------------------------------------

Looking at
http://linux.bkbits.net:8080/linux-2.6/gnupatch@4234d7beMW4wcFI6ltxdMMhApwDmuA
shows this changeset should contain a delta for mm/vmscan.c

However, mm/vmscan.c,v contains:
-------------------------------------------------------------
head    1.238;  
access;
symbols;
locks; strict; 
comment @ * @;
expand  @o@;


1.238
date    2005.03.10.17.06.39;    author pj;      state Exp;
branches;
next    1.237;  
....
1.238
log
@cpusets - big numa cpu and memory placement

(Logical change 1.27465)
@
-------------------------------------------------------------

The 'Logical change 1.27702' is missing from the file...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
