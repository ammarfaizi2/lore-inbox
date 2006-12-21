Return-Path: <linux-kernel-owner+w=401wt.eu-S1423059AbWLUTmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423059AbWLUTmM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423061AbWLUTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:42:12 -0500
Received: from tomts5-srv.bellnexxia.net ([209.226.175.25]:34298 "EHLO
	tomts5-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423059AbWLUTmL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:42:11 -0500
Date: Thu, 21 Dec 2006 14:42:08 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, ltt-dev@shafik.org,
       Thomas Gleixner <tglx@linutronix.de>, systemtap@sources.redhat.com
Subject: [PATCH] atomic.h : x86_64 atomic64_add_return
Message-ID: <20061221194208.GA25249@Krystal>
References: <20061221000351.GF28643@Krystal> <20061221001405.GO28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221001405.GO28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:37:31 up 120 days, 16:45,  4 users,  load average: 0.78, 0.66, 0.63
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

atomic64_add_return fix for volatile removal

atomic64_add_return should follow the change done to atomic.h following the
removal of "volatile" in the atomic_t type, just like atomic_add_return.

It applies cleanly on top of my "atomic.h : x86_64" patch posted in this
thread.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

diff --git a/include/asm-x86_64/atomic.h b/include/asm-x86_64/atomic.h
index e9922ae..3e9f838 100644
--- a/include/asm-x86_64/atomic.h
+++ b/include/asm-x86_64/atomic.h
@@ -375,8 +375,8 @@ static __inline__ long atomic64_add_retu
 	long __i = i;
 	__asm__ __volatile__(
 		LOCK_PREFIX "xaddq %0, %1;"
-		:"=r"(i)
-		:"m"(v->counter), "0"(i));
+		:"+r" (i), "+m" (v->counter)
+		: : "memory");
 	return i + __i;
 }
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
