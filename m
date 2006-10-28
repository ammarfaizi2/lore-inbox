Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWJ1Ssa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWJ1Ssa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWJ1Ss3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:48:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:8774 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932080AbWJ1Ss3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:48:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=Tl+5LqKva1S/R8SS0e1pho/PV+ucWuIyMnkYaXF1JFNRA+/2560fCEDKE/i6PoVpc7lpLuoJLVcF0bZMNI6bAF5z035q6B3kwelLr1MZtaxIQkgjSU2vtHnzNi5RUf4Ve2tIeMCfgoA1Fmd75rzlIn/UOMk2/sTfT3+AcdqqbVs=
Date: Sun, 29 Oct 2006 03:48:48 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kai Germaschewski <kai.germaschewski@gmx.de>, Karsten Keil <kkeil@suse.de>
Subject: [PATCH] isdn: fix missing unregister_capi_driver
Message-ID: <20061028184848.GH9973@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	Karsten Keil <kkeil@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unregister_capi_driver() needs to be called in module cleanup.
(It fixes data corruption by reloading t1isa driver)

Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
Cc: Karsten Keil <kkeil@suse.de>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/isdn/hardware/avm/t1isa.c |    1 +
 1 file changed, 1 insertion(+)

Index: work-fault-inject/drivers/isdn/hardware/avm/t1isa.c
===================================================================
--- work-fault-inject.orig/drivers/isdn/hardware/avm/t1isa.c
+++ work-fault-inject/drivers/isdn/hardware/avm/t1isa.c
@@ -584,6 +584,7 @@ static void __exit t1isa_exit(void)
 {
 	int i;
 
+	unregister_capi_driver(&capi_driver_t1isa);
 	for (i = 0; i < MAX_CARDS; i++) {
 		if (!io[i])
 			break;
