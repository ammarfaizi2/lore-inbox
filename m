Return-Path: <linux-kernel-owner+w=401wt.eu-S1423031AbWLUToj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423031AbWLUToj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 14:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423061AbWLUToj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 14:44:39 -0500
Received: from tomts22-srv.bellnexxia.net ([209.226.175.184]:62468 "EHLO
	tomts22-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423031AbWLUToi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 14:44:38 -0500
Date: Thu, 21 Dec 2006 14:44:36 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>, ltt-dev@shafik.org,
       Thomas Gleixner <tglx@linutronix.de>, systemtap@sources.redhat.com
Subject: Re: [Ltt-dev] [PATCH 3/10] local_t : i386, local_add_return fix
Message-ID: <20061221194436.GB25249@Krystal>
References: <20061221001545.GP28643@Krystal> <20061221002242.GS28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061221002242.GS28643@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:42:21 up 120 days, 16:49,  5 users,  load average: 0.14, 0.43, 0.55
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

local_add_return fix for non volatile local_t on i386.

local_add_return should act like the new atomic_add_return considering the
removal of volatile from atomic_t.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-i386/local.h
+++ b/include/asm-i386/local.h
@@ -142,8 +142,8 @@ #endif
 	__i = i;
 	__asm__ __volatile__(
 		"xaddl %0, %1;"
-		:"=r"(i)
-		:"m"(l->a.counter), "0"(i));
+		:"+r" (i), "+m" (l->a.counter)
+		: : "memory");
 	return i + __i;
 
 #ifdef CONFIG_M386
-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
