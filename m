Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWEJC6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWEJC6w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWEJC51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:27 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:7486 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932439AbWEJC4w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:52 -0400
Date: Tue, 9 May 2006 19:55:58 -0700
Message-Id: <200605100255.k4A2twOE031688@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] idetape gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_from_user’:
drivers/ide/ide-tape.c:2662: warning: ignoring return value of ‘copy_from_user’, declared with attribute warn_unused_result
drivers/ide/ide-tape.c: In function ‘idetape_copy_stage_to_user’:
drivers/ide/ide-tape.c:2689: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/ide/ide-tape.c
===================================================================
--- linux-2.6.16.orig/drivers/ide/ide-tape.c
+++ linux-2.6.16/drivers/ide/ide-tape.c
@@ -2659,7 +2659,7 @@ static void idetape_copy_stage_from_user
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
+		WARN_ON(copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count));
 		n -= count;
 		atomic_add(count, &bh->b_count);
 		buf += count;
@@ -2686,7 +2686,7 @@ static void idetape_copy_stage_to_user (
 		}
 #endif /* IDETAPE_DEBUG_BUGS */
 		count = min(tape->b_count, n);
-		copy_to_user(buf, tape->b_data, count);
+		WARN_ON(copy_to_user(buf, tape->b_data, count));
 		n -= count;
 		tape->b_data += count;
 		tape->b_count -= count;
