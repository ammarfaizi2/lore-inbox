Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292972AbSB1Qf7>; Thu, 28 Feb 2002 11:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293468AbSB1QdH>; Thu, 28 Feb 2002 11:33:07 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:18671 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293465AbSB1Qb3>; Thu, 28 Feb 2002 11:31:29 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: torvalds@transmeta.com, davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: recalc_sigpending() / recalc_sigpending_tsk() ?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Feb 2002 16:31:25 +0000
Message-ID: <22659.1014913885@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at merging the changes made to JFFS2 in 2.5, with the intention 
of again having a single codebase that compiles in both 2.5 and 2.4.

I'm a little confused by the changes to recalc_sigpending().

It seems that the name of the function was changed to recalc_sigpending_tsk()
and a new function called recalc_sigpending() was added.

Was there a reason for doing this, rather than just introducing the new 
function with a different name, such as recalc_sigpending_cur()? It breaks 
2.4 source compatibility in a way that seems entirely gratuitous.

Before I have to go and do something evil in my compatmac.h to work round 
this, is there any chance of putting the original recalc_sigpending() back?

Linus, would you accept such a patch?

--
dwmw2

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,5)
#include <linux/sched.h>
/* Grrr. Gratuitous breakage */
#define recalc_sigpending() recalc_sigpending(current)
/* Unfortunately this one can't work, because of the above
#define recalc_sigpending_tsk(t) recalc_sigpending(t)
 */
#endif



