Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVHZVgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVHZVgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 17:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHZVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 17:36:47 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:42122 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965172AbVHZVgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 17:36:46 -0400
Subject: Re: 2.6.13-rc7-rt3 compile fix
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <430F86E7.9020605@cybsft.com>
References: <430F86E7.9020605@cybsft.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 26 Aug 2005 17:36:37 -0400
Message-Id: <1125092197.5365.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 16:17 -0500, K.R. Foley wrote:
> 2.6.13-rc7-rt3 won't compile without the simple patch below.
>  
-       __raw_spin_lock(old_owner->task->pi_lock);
+       __raw_spin_lock(&old_owner->task->pi_lock);
        TRACE_WARN_ON_LOCKED(plist_empty(&waiter->pi_list));
        TRACE_WARN_ON_LOCKED(lock_owner(lock));
 
@@ -683,7 +683,7 @@
        }
        TRACE_WARN_ON_LOCKED(1);
 ok:
-       __raw_spin_unlock(old_owner->task->pi_lock);
+       __raw_spin_unlock(&old_owner->task->pi_lock);
        return;


Oops! my bad.  I saw that needed locking, but I didn't have the tracing
on (I was trying for internal deadlocks), so that part of the code
wasn't compiling.  If you turn off tracing it would compile :-)

Anyway, the next time I modify code that's protected by ifdefs, I'll
change my config and see at least the code compiles.

Thanks,

-- Steve


