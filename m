Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVCHR4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVCHR4e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVCHR4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:56:34 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:27233 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVCHR42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:56:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=F+nl13+0vmiwbXvDjB6ShHCg7i+QqET1DcgpqJoUB3tTt7EL7k4vKd6AQJABnmRyMwviJnD+GmDZ+NhYBxemwniO1iKOKnHzs1WrJATIaLAhLCyZx7NmffjsXac+uwCVe11l7Fx9kIw5KCapxnAfLLQa4b9wL+Hg7v5MnqPg3xY=
Message-ID: <2cd57c9005030809564ee1d487@mail.gmail.com>
Date: Wed, 9 Mar 2005 01:56:27 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: akpm@osdl.org
Subject: [patch] remove barrier() in software_resume()
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch removes the redundant compiler barrier. As Linus ever said 
"The mb() should make sure that gcc cannot move things around...".

--coywolf

Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>

diff -Nrup 2.6.11/kernel/power/disk.c 2.6.11-cy/kernel/power/disk.c
--- 2.6.11/kernel/power/disk.c	2005-03-03 17:12:17.000000000 +0800
+++ 2.6.11-cy/kernel/power/disk.c	2005-03-09 01:47:10.000000000 +0800
@@ -233,7 +233,6 @@ static int software_resume(void)
 	if ((error = prepare()))
 		goto Free;
 
-	barrier();
 	mb();
 
 	pr_debug("PM: Restoring saved image.\n");

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/
