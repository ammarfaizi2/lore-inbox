Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWBDTfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWBDTfx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWBDTfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 14:35:52 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:38879 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932548AbWBDTfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 14:35:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TyUJdCwqPpRqnLy7DZnki4U61NYDDZj5K+TrHB9h2Tkr0sIyIvggqzr3aBauvZXRbNhZZYEAHLV4cGaRZas6ZcHodxQOuy5Zpe6Bv1TWWyNnMwKgfjKuBrQ/RRvQUt9NoO2To03TsUOHRA4nRk1wH7Sv19sTW7OXWh+tySWIi+I=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Don't check pointer for NULL before passing it to kfree   [arch/powerpc/kernel/rtas_flash.c]
Date: Sat, 4 Feb 2006 20:35:59 +0100
User-Agent: KMail/1.9
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602042035.59216.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Checking a pointer for NULL before passing it to kfree is pointless, kfree
does its own NULL checking of input.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/powerpc/kernel/rtas_flash.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.16-rc2-git1-orig/arch/powerpc/kernel/rtas_flash.c	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.16-rc2-git1/arch/powerpc/kernel/rtas_flash.c	2006-02-04 20:30:21.000000000 +0100
@@ -672,8 +672,7 @@ static void rtas_flash_firmware(int rebo
 static void remove_flash_pde(struct proc_dir_entry *dp)
 {
 	if (dp) {
-		if (dp->data != NULL)
-			kfree(dp->data);
+		kfree(dp->data);
 		dp->owner = NULL;
 		remove_proc_entry(dp->name, dp->parent);
 	}


