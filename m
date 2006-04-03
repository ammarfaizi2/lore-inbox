Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWDCK15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWDCK15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 06:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWDCK14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 06:27:56 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:31492 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbWDCK14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 06:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=chdx4+khR1kyNpUWQPSitXM+gqt5L5sFPMzGB06LwkC5uPXy8NkIZFzRhJLFaqVp3BWIugvzWJ+KVaKbGGnB0uLGdq9cWiKpzK4BU0GHxTZqLEI2/UrxtA/BG7CbniUSOMFP7Ztn3YbDfa+ZzRfUantLHPnYrV24Pyk59vPkxac=
Subject: [KJ][Patch] fix kbuild warning in pm2fb.o
From: "Darren Jenkins\\" <darrenrjenkins@gmail.com>
To: kernel Janitors <kernel-janitors@lists.osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 20:27:36 +1000
Message-Id: <1144060056.7790.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day list

There are a couple of Section mismatch problems in drivers/video/pm2fb.o

WARNING: drivers/video/pm2fb.o - Section mismatch: reference
to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd5d)
WARNING: drivers/video/pm2fb.o - Section mismatch: reference
to .init.data: from .text after 'pm2fb_set_par' (at offset 0xd82)



They are caused because pm2fb_set_par() uses lowhsync and lowvsync which
are marked __devinitdata.


The patch below simply removes the __devinitdata annotations.


Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>

--- 2.6.16-git20/drivers/video/pm2fb.c.orig	2006-04-03 19:08:51.000000000 +1000
+++ 2.6.16-git20/drivers/video/pm2fb.c	2006-04-03 19:09:34.000000000 +1000
@@ -73,8 +73,8 @@ static char *mode __devinitdata = NULL;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync __devinitdata = 0;
-static int lowvsync __devinitdata = 0;
+static int lowhsync = 0;
+static int lowvsync = 0;
 
 /*
  * The hardware state of the graphics card that isn't part of the


