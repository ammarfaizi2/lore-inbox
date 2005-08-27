Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbVH0LrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVH0LrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 07:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVH0LrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 07:47:09 -0400
Received: from ns.suse.de ([195.135.220.2]:13459 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030362AbVH0LrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 07:47:08 -0400
Date: Sat, 27 Aug 2005 13:47:06 +0200
From: Karsten Keil <kkeil@suse.de>
To: James Morris <jmorris@namei.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       kai.germaschewski@gmx.de, akpm@osdl.org
Subject: Re: [PATCH ISDN] Fix capifs bug in initialization error path.
Message-ID: <20050827114706.GB860@pingi3.kke.suse.de>
Mail-Followup-To: James Morris <jmorris@namei.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	kai.germaschewski@gmx.de, akpm@osdl.org
References: <Pine.LNX.4.63.0508262339210.21123@excalibur.intercode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508262339210.21123@excalibur.intercode>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 11:56:56PM -0400, James Morris wrote:
> This patch fixes a bug in the capifs initialization code, where the 
> filesystem is not unregistered if kern_mount() fails.
> 
> Please apply.

looks OK for me.

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Karsten Keil <kkeil@suse.de>
---

 capifs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -purN -X dontdiff linux-2.6.13-mm2.o/drivers/isdn/capi/capifs.c linux-2.6.13-mm2.x/drivers/isdn/capi/capifs.c
--- linux-2.6.13-mm2.o/drivers/isdn/capi/capifs.c	2005-03-02 02:37:50.000000000 -0500
+++ linux-2.6.13-mm2.x/drivers/isdn/capi/capifs.c	2005-08-26 23:35:50.000000000 -0400
@@ -191,8 +191,10 @@ static int __init capifs_init(void)
 	err = register_filesystem(&capifs_fs_type);
 	if (!err) {
 		capifs_mnt = kern_mount(&capifs_fs_type);
-		if (IS_ERR(capifs_mnt))
+		if (IS_ERR(capifs_mnt)) {
 			err = PTR_ERR(capifs_mnt);
+			unregister_filesystem(&capifs_fs_type);
+		}
 	}
 	if (!err)
 		printk(KERN_NOTICE "capifs: Rev %s\n", rev);
-- 
Karsten Keil
SuSE Labs
ISDN development
