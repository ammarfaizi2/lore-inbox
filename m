Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVDMLDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVDMLDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDMLDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:03:31 -0400
Received: from scrat.cs.umu.se ([130.239.40.18]:41689 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261305AbVDMLDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:03:25 -0400
Date: Wed, 13 Apr 2005 13:03:21 +0200
From: Peter Hagervall <hager@cs.umu.se>
To: torvalds@osdl.org, pasky@ucw.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Possible fix for git
Message-ID: <20050413110320.GF4849@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed earlier today that I ran out of file descriptors when doing a
'git commit'. As far as I can see the following patch ought to take
care of the problem.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>

---


--- read-cache.c
+++ read-cache.c        2005-04-13 12:51:52.000000000 +0200
@@ -257,6 +257,7 @@
                        return error("SHA1 collision detected!"
                                        " This is bad, bad, BAD!\a\n");
 #endif
+               close(fd);
                return 0;
        }
        write(fd, buf, size);
