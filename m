Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbSI0OMW>; Fri, 27 Sep 2002 10:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbSI0OMW>; Fri, 27 Sep 2002 10:12:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58384 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261699AbSI0OMW>;
	Fri, 27 Sep 2002 10:12:22 -0400
Date: Fri, 27 Sep 2002 15:17:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix file_lock_cache leak
Message-ID: <20020927151741.D27592@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Always free the request, not just on error.

diff -urpNX dontdiff linux-2.5.38/fs/locks.c linux-2.5.38-flock/fs/locks.c
--- linux-2.5.38/fs/locks.c	2002-09-21 18:47:00.000000000 -0700
+++ linux-2.5.38-flock/fs/locks.c	2002-09-26 10:36:16.000000000 -0700
@@ -1459,10 +1470,8 @@ int fcntl_setlk(struct file *filp, unsig
 		break;
 	}
 
-out:
-	if (error) {
-		locks_free_lock(file_lock);
-	}
+ out:
+	locks_free_lock(file_lock);
 	return error;
 }
 
@@ -1601,11 +1614,8 @@ int fcntl_setlk64(struct file *filp, uns
 		break;
 	}
 
-
 out:
-	if (error) {
-		locks_free_lock(file_lock);
-	}
+	locks_free_lock(file_lock);
 	return error;
 }
 #endif /* BITS_PER_LONG == 32 */

-- 
Revolutions do not require corporate support.
