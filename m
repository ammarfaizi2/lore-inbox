Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUCSASA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUCRXzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:55:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54492 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263338AbUCRXvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:51:38 -0500
Date: Thu, 18 Mar 2004 23:51:37 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>,
       Greg KH <greg@kroah.com>, David Mosberger <davidm@hpl.hp.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [1/3] insert_resource can succeed and return an error
Message-ID: <20040318235137.GI25059@parcelfarce.linux.theplanet.co.uk>
References: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318235024.GH25059@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If we start again, we can return an error even if we were successful.
Reset the result to 0 before beginning again.  Why don't we use a
tailcall here?

Index: kernel/resource.c
===================================================================
RCS file: /var/cvs/linux-2.6/kernel/resource.c,v
retrieving revision 1.12
diff -u -p -r1.12 resource.c
--- a/kernel/resource.c	28 Feb 2004 01:51:35 -0000	1.12
+++ b/kernel/resource.c	18 Mar 2004 23:41:01 -0000
@@ -337,6 +337,7 @@ int insert_resource(struct resource *par
 	/* existing resource overlaps end of new resource */
 	if (next->end > new->end) {
 		parent = next;
+		result = 0;
 		goto begin;
 	}
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
