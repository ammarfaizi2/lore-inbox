Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTKSW3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 17:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTKSW3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 17:29:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:17878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264153AbTKSW3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 17:29:33 -0500
Date: Wed, 19 Nov 2003 14:30:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: leif <leif@gci.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error in Sparc64 rwlock.S
Message-Id: <20031119143000.7815cb9d.akpm@osdl.org>
In-Reply-To: <014401c3aee5$587aea20$31828ad0@internet.gci.net>
References: <20031118130956.1edd4a24.akpm@osdl.org>
	<014401c3aee5$587aea20$31828ad0@internet.gci.net>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

leif <leif@gci.net> wrote:
>
> Now there's a different problem...
> 
> Error: local label '"100" (instance number 1 of a fb label)'
>   is not defined

Ah, sorry.   This incremental patch should fix that up.

--- 25/arch/sparc64/lib/rwlock.S~lockmeter-sparc64-fix-fix	Wed Nov 19 14:29:11 2003
+++ 25-akpm/arch/sparc64/lib/rwlock.S	Wed Nov 19 14:29:18 2003
@@ -90,13 +90,15 @@ __write_trylock_fail:
 __read_trylock: /* %o0 = lock_ptr */
 	ldsw		[%o0], %g5
 	brlz,pn		%g5, 100f
-	 add		%g5, 1, %g7
+	add		%g5, 1, %g7
 	cas		[%o0], %g5, %g7
 	cmp		%g5, %g7
 	bne,pn		%icc, __read_trylock
 	 membar		#StoreLoad | #StoreStore
 	retl
-	 mov		1, %o0
+	mov		1, %o0
+100:	retl
+	mov		0, %o0
 
 rwlock_impl_end:
 

_

