Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVBWVoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVBWVoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVBWVoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:44:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261617AbVBWVmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:42:52 -0500
Date: Wed, 23 Feb 2005 13:42:41 -0800
Message-Id: <200502232142.j1NLgfQZ030024@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] process-wide itimer typo fixes
In-Reply-To: Benoit Boissinot's message of  Wednesday, 23 February 2005 22:05:52 +0100 <20050223210552.GA14583@ens-lyon.fr>
X-Zippy-Says: Yow!!  It's LIBERACE and TUESDAY WELD!!  High on a HILL... driving
   a LITTLE CAR...  I wanna be in that LITTLE CAR, too!!  I wanna
   drive off with LIBBY and TUESDAY!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for finding that.

Ack!  I did a quick merge of my well-tested patches with the cputime_t
stuff, and apparently didn't do quite as much testing as I thought I did.
There was a little query/replace error in my per-process-itimer-cpu patch
now in -mm.  Your patch is necessary but not sufficient.  This patch fixes
all the errors.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/itimer.c
+++ linux-2.6/kernel/itimer.c
@@ -56,9 +56,9 @@ int do_getitimer(int which, struct itime
 				t = next_thread(t);
 			} while (t != tsk);
 			if (cputime_le(cval, utime)) { /* about to fire */
-				val = jiffies_to_cputime(1);
+				cval = jiffies_to_cputime(1);
 			} else {
-				val = cputime_sub(val, utime);
+				cval = cputime_sub(cval, utime);
 			}
 		}
 		spin_unlock_irq(&tsk->sighand->siglock);
@@ -82,9 +82,9 @@ int do_getitimer(int which, struct itime
 				t = next_thread(t);
 			} while (t != tsk);
 			if (cputime_le(cval, ptime)) { /* about to fire */
-				val = jiffies_to_cputime(1);
+				cval = jiffies_to_cputime(1);
 			} else {
-				val = cputime_sub(val, ptime);
+				cval = cputime_sub(cval, ptime);
 			}
 		}
 		spin_unlock_irq(&tsk->sighand->siglock);

