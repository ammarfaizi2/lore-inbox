Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUDSKSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 06:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbUDSKSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 06:18:11 -0400
Received: from mail.shareable.org ([81.29.64.88]:5540 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264367AbUDSKRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 06:17:38 -0400
Date: Mon, 19 Apr 2004 11:17:31 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chris@scary.beasts.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Use get_user for 64-bit read in sendfile64
Message-ID: <20040419101731.GD13007@mail.shareable.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com> <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org> <20040419004657.GD11064@mail.shareable.org> <Pine.LNX.4.58.0404182220470.2808@ppc970.osdl.org> <20040419094408.GA13007@mail.shareable.org> <20040419101446.GC13007@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419101446.GC13007@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch: sendfile64_get_user-2.6.5
Requires: uaccess64-2.6.5-jl2

Use get_user instead of copy_from_user to read a loff_t.
Compiled output is identical on i386.

--- orig-2.6.5/fs/read_write.c	2004-04-14 08:29:43.000000000 +0100
+++ uaccess64-2.6.5/fs/read_write.c	2004-04-19 10:35:35.000000000 +0100
@@ -644,7 +644,7 @@
 	ssize_t ret;
 
 	if (offset) {
-		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
+		if (unlikely(get_user(pos, offset)))
 			return -EFAULT;
 		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
 		if (unlikely(put_user(pos, offset)))
