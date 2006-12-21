Return-Path: <linux-kernel-owner+w=401wt.eu-S1423062AbWLUTq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423062AbWLUTq4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423063AbWLUTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:46:56 -0500
Received: from tomts40.bellnexxia.net ([209.226.175.97]:58034 "EHLO
	tomts40-srv.bellnexxia.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1423062AbWLUTqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:46:55 -0500
Date: Thu, 21 Dec 2006 14:46:52 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, ltt-dev@shafik.org,
       Thomas Gleixner <tglx@linutronix.de>, systemtap@sources.redhat.com
Subject: Re: [Ltt-dev] [PATCH 10/10] local_t : x86_64 : local_add_return
Message-ID: <20061221194652.GC25249@Krystal>
References: <20061221001545.GP28643@Krystal> <20061221002944.GZ28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221002944.GZ28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:44:46 up 120 days, 16:52,  5 users,  load average: 0.55, 0.56, 0.58
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local_add_return should also deal with the removed volatile from local_t.

Inspired from atomic_t modifications : it must use the local_t both as input and
output.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/include/asm-x86_64/local.h
+++ b/include/asm-x86_64/local.h
@@ -136,8 +136,8 @@ static __inline__ long local_add_return(
 	long __i = i;
 	__asm__ __volatile__(
 		"xaddq %0, %1;"
-		:"=r"(i)
-		:"m"(l->a.counter), "0"(i));
+		:"+r" (i), "+m" (l->a.counter)
+		: : "memory");
 	return i + __i;
 }
 
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
