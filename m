Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRJXOeD>; Wed, 24 Oct 2001 10:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274809AbRJXOdx>; Wed, 24 Oct 2001 10:33:53 -0400
Received: from cs.utexas.edu ([128.83.139.9]:31641 "EHLO cs.utexas.edu")
	by vger.kernel.org with ESMTP id <S274544AbRJXOds>;
	Wed, 24 Oct 2001 10:33:48 -0400
Date: Wed, 24 Oct 2001 09:34:20 -0500
From: Kjohn Sasitorn <kjohn@cs.utexas.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: patch to exec_domain
Message-ID: <20011024093420.A6686@vampire.cs.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Organization: (University of Texas at Austin)
X-URL: http://www.cs.utexas.edu/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the personality(2) system call always returns the previous
persona. However, according to the manpage, it should return the previous
persona when successful and -1 otherwise. The following patch to
lookup_exec_domain() should remedy this behavior:

--- kernel-source-2.4.12.orig/kernel/exec_domain.c      Thu Oct 18 09:12:47
2001
+++ kernel-source-2.4.12/kernel/exec_domain.c      Thu Oct 18 09:23:59 2001
@@ -100,7 +100,7 @@
     }
 #endif

-    ep = &default_exec_domain;
+    ep = NULL;
 out:
     read_unlock(&exec_domains_lock);
     return (ep);


Kjohn Sasitorn
kjohn@cs.utexas.edu
