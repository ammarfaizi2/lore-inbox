Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWJ1Alw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWJ1Alw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 20:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWJ1Alw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 20:41:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:3581 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751317AbWJ1Alw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 20:41:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=D61JVPtNDwvile0f8D0XelJCAmNFL1Qct4x1oOvcxpbHcjqYMVwvooH9eRPokQTaMsATIlY4kn3xFkZUOzZp9wWPb+Wm1zN8kuD6glnpBa/0eCpQMRpdFB6VQDKyuQMyiRpJYNLMLOV+ya1sdAOxnSrmvJH1o/uc4ve2SAlZJ4c=
Date: Sat, 28 Oct 2006 04:41:47 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Blacklist hsfmodem module
Message-ID: <20061028004147.GB4902@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Google CodeSeacrh for

	MODULE_LICENSE.*0

and you'll see

   hsfmodem-7.47.00.03x86_64full/modules/cnxthwusb_common.c - 6 identical

    15: MODULE_DESCRIPTION("Conexant low-level hardware driver");
        MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only LICENSE file applies");
	MODULE_INFO(supported, "yes");
   gentoo.osuosl.org/.../hsfmodem-7.47.00.03x86_64full.tar.gz - Unknown License - C - More from hsfmodem-7.47.00.03x86_64full.tar.gz »

It seems, hcfpcimodem-1.10full.tar.gz from
http://www.linuxant.com/drivers/hcf/full/downloads.php
also uses GPL\0 trick.

Patch is obviously not tested (and I'm not sure name is right, got it from
Ubuntu forums and tarball filename),

Does someone know internal contact so we can weed out all names and
blacklist them in bulk?

P.S.: Curiously enough, binary parts are *.O , not *.o .
	Presumably, .o suffix scares their developers, while tainting
	messages are busy scaring their users.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/module.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1721,6 +1721,9 @@ #endif
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 	if (strcmp(mod->name, "driverloader") == 0)
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
+	/* LinuxAnt is politely asked to stop GPL\0 idiocy. */
+	if (strcmp(mod->name, "hsfmodem") == 0)
+		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 
 	/* Set up MODINFO_ATTR fields */
 	setup_modinfo(mod, sechdrs, infoindex);

