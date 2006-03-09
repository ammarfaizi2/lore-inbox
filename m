Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbWCIDFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbWCIDFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWCIDFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:05:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32947 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932735AbWCIDFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:05:51 -0500
Date: Wed, 8 Mar 2006 22:05:42 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: raven@themaw.net
Subject: Remove redundant check from autofs4_put_super
Message-ID: <20060309030542.GA17851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, raven@themaw.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have to have a valid sbi here, or we'd have oopsed already.
(There's a dereference of sbi->catatonic a few lines above)

Coverity #740
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/fs/autofs4/inode.c~	2006-03-08 22:02:53.000000000 -0500
+++ linux-2.6/fs/autofs4/inode.c	2006-03-08 22:03:47.000000000 -0500
@@ -145,8 +145,7 @@ static void autofs4_put_super(struct sup
 		autofs4_catatonic_mode(sbi); /* Free wait queues, close pipe */
 
 	/* Clean up and release dangling references */
-	if (sbi)
-		autofs4_force_release(sbi);
+	autofs4_force_release(sbi);
 
 	kfree(sbi);
 

-- 
http://www.codemonkey.org.uk
