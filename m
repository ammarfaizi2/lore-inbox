Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWHUSuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWHUSuj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWHUSuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:50:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:26045 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWHUStz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:49:55 -0400
Date: Mon, 21 Aug 2006 11:48:14 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl, hugh@veritas.com,
       pavel@suse.cz, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/20] swsusp: Fix swap_type_of
Message-ID: <20060821184814.GT21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="swsusp-fix-swap_type_of.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: "Rafael J. Wysocki" <rjw@sisk.pl>

There is a bug in mm/swapfile.c#swap_type_of() that makes swsusp only be
able to use the first active swap partition as the resume device.  Fix it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Hugh Dickins <hugh@veritas.com>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 mm/swapfile.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.9.orig/mm/swapfile.c
+++ linux-2.6.17.9/mm/swapfile.c
@@ -440,11 +440,12 @@ int swap_type_of(dev_t device)
 
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
+
 		if (!device) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
-		inode = swap_info->swap_file->f_dentry->d_inode;
+		inode = swap_info[i].swap_file->f_dentry->d_inode;
 		if (S_ISBLK(inode->i_mode) &&
 		    device == MKDEV(imajor(inode), iminor(inode))) {
 			spin_unlock(&swap_lock);

--
