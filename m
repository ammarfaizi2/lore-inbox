Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbUKOE2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUKOE2W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 23:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUKOE2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 23:28:21 -0500
Received: from siaag2ad.compuserve.com ([149.174.40.134]:59821 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261426AbUKOE2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 23:28:16 -0500
Date: Sun, 14 Nov 2004 23:24:43 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Futex queue_me/get_user ordering (was: 2.6.10-rc1-mm5
  [u])
To: Emergency Services Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411142327_MC3-1-8EB1-E27D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004 at 09:00:23 +0000 Emergency Services Jamie Lokier wrote:

>+       * The basic logical guarantee of a futex is that it blocks ONLY
>+       * if cond(var) is known to be true at the time of blocking, for
>+       * any cond.  If we queued after testing *uaddr, that would open
>+       * a race condition where we could block indefinitely with
>+       * cond(var) false, which would violate the guarantee.
>+       *
>+       * A consequence is that futex_wait() can return zero and absorb
>+       * a wakeup when *uaddr != val on entry to the syscall.  This is
>+       * rare, but normal.


   Why can't it absorb a wakeup and still return -EAGAIN when this happens?

   IOW why not apply this patch to the original code?

================================================================================
        return -EINTR;
 
  out_unqueue:
-       /* If we were woken (and unqueued), we succeeded, whatever. */
-       if (!unqueue_me(&q))
-               ret = 0;
+       unqueue_me(&q); /* ignore result from unqueue */
  out_release_sem:
        up_read(&current->mm->mmap_sem);
        return ret;
================================================================================

   ...and what is "Emergency Services", BTW?

--Chuck Ebbert  14-Nov-04  21:28:56
