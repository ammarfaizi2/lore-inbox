Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSEaQdQ>; Fri, 31 May 2002 12:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSEaQdP>; Fri, 31 May 2002 12:33:15 -0400
Received: from pop.gmx.de ([213.165.64.20]:46512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315870AbSEaQdO>;
	Fri, 31 May 2002 12:33:14 -0400
Date: Fri, 31 May 2002 19:32:19 +0300
From: Dan Aloni <da-x@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [PATCH] fix NULL dereferencing in dcache.c
Message-ID: <20020531163219.GA27443@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unrelated to my first dcache patch, this is something more crucial
and should be applied first. 

fs/dcache.c:
 - handle d_alloc() returning NULL.

--- linux-2.5.19/fs/dcache.c	Thu May 30 22:35:37 2002
+++ linux-2.5.19/fs/dcache.c	Fri May 31 19:19:18 2002
@@ -755,6 +755,9 @@
 	}
 
 	tmp = d_alloc(NULL, &(const struct qstr) {"",0,0});
+	if (!tmp)
+		return NULL;
+
 	tmp->d_parent = tmp; /* make sure dput doesn't croak */
 	
 	spin_lock(&dcache_lock);


-- 
Dan Aloni
da-x@gmx.net
