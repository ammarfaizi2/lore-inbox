Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbTFEL7H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFEL7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:59:07 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:54538 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264637AbTFEL7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:59:04 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Thomas Kaeding <kaeding@kaeding.homelinux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: more info for last message (bug at page_alloc.c:102)
Date: Thu, 5 Jun 2003 14:12:16 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0306050801200.854-100000@kaeding.localdomain>
In-Reply-To: <Pine.LNX.4.44.0306050801200.854-100000@kaeding.localdomain>
MIME-Version: 1.0
Message-Id: <200306051410.32138.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gOz3+4EwRr9BxFy"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gOz3+4EwRr9BxFy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 05 June 2003 14:04, Thomas Kaeding wrote:

Hi Thomas.

> Here is more info that you might need.  The problem occurred overnight.
> In the morning, the mouse worked until I tried to start an app
> in KDE, then everything froze.  Ctl-alt-bkspc gave only a black screen.
> I had to hit restart.
> NVdriver             1065216  10
well, this won't help you right now, but you know how to proceed if you read 
the attached patch. It fits your situation ;)

ciao, Marc



--Boundary-00=_gOz3+4EwRr9BxFy
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nvidia-bug-explaination.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nvidia-bug-explaination.patch"

diff -urN a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Sat Aug  3 17:08:40 2002
+++ b/mm/page_alloc.c	Thu Oct 17 16:42:24 2002
@@ -98,8 +98,12 @@
 
 	if (page->buffers)
 		BUG();
-	if (page->mapping)
-		BUG();
+	if (page->mapping) {
+		printk(KERN_CRIT "Page has mapping still set. This is a serious situation. However if you\n");
+		printk(KERN_CRIT "are using the NVidia binary only module please report this bug to\n");
+		printk(KERN_CRIT "NVidia and not to the Linux Kernel Mailinglist!\n");
+ 		BUG();
+	}
 	if (!VALID_PAGE(page))
 		BUG();
 	if (PageLocked(page))

--Boundary-00=_gOz3+4EwRr9BxFy--

