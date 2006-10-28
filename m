Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWJ1Slo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWJ1Slo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWJ1Slo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:41:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:30510 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751351AbWJ1Sln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:41:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=Eac33+MUOPw2jkJdAtGvyaaJgcgBG0Dp/0y+yR/Q2L+KwFDbYA/0Opd2cvg5730QnIvnXlHrP478Nd1UITB7tG1Ry72JmhHOHchFTCazNylsn69FA3WRVkVqP9sUmsE8d4XBJwKDqcDWtm5C6F46A50PLrTCmPeAF+ecJd1/Nh8=
Date: Sun, 29 Oct 2006 03:42:02 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] lightning: return proper return code
Message-ID: <20061028184202.GC9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes module init return proper value instead of -1 (-EPERM).

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/input/gameport/lightning.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work-fault-inject/drivers/input/gameport/lightning.c
===================================================================
--- work-fault-inject.orig/drivers/input/gameport/lightning.c
+++ work-fault-inject/drivers/input/gameport/lightning.c
@@ -309,7 +309,7 @@ static int __init l4_init(void)
 	int i, cards = 0;
 
 	if (!request_region(L4_PORT, 1, "lightning"))
-		return -1;
+		return -EBUSY;
 
 	for (i = 0; i < 2; i++)
 		if (l4_add_card(i) == 0)
@@ -319,7 +319,7 @@ static int __init l4_init(void)
 
 	if (!cards) {
 		release_region(L4_PORT, 1);
-		return -1;
+		return -ENODEV;
 	}
 
 	return 0;
