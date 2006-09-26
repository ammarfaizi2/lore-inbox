Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWIZRyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWIZRyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWIZRyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:54:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932214AbWIZRyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:54:20 -0400
Date: Tue, 26 Sep 2006 10:54:09 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, tytso@mit.edu
Subject: 2.6.18-mm1 inode_diet fix
Message-ID: <20060926175409.GA26041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In OSDL's automated cross-compiles, I see an error for powerpc allmodconfig in 2.6.18-mm1:

arch/powerpc/platforms/pseries/hvCall_inst.c: In function 'hcall_inst_seq_open':
arch/powerpc/platforms/pseries/hvCall_inst.c:88: error: 'struct inode' has no member named 'u'
make[2]: [arch/powerpc/platforms/pseries/hvCall_inst.o] Error 1 (ignored)
powerpc64-unknown-linux-gnu-ld: arch/powerpc/platforms/pseries/hvCall_inst.o: No such file: No such file or directory
make[2]: [arch/powerpc/platforms/pseries/built-in.o] Error 1 (ignored)
powerpc64-unknown-linux-gnu-ld: arch/powerpc/platforms/pseries/built-in.o: No such file: No such file or directory
make[1]: [arch/powerpc/platforms/built-in.o] Error 1 (ignored)


This seems to be an oversight in patch:
inode_diet-replace-inodeugeneric_ip-with-inodei_private.patch

Here is a patch that removes the error.

Signed-off-by: Judith Lebzelter <judith@osdl.org>


--- linux/arch/powerpc/platforms/pseries/hvCall_inst.c.orig	2006-09-26 09:52:19.701978352 -0700
+++ linux/arch/powerpc/platforms/pseries/hvCall_inst.c	2006-09-26 09:52:33.971809008 -0700
@@ -85,7 +85,7 @@
 
 	rc = seq_open(file, &hcall_inst_seq_ops);
 	seq = file->private_data;
-	seq->private = file->f_dentry->d_inode->u.generic_ip;
+	seq->private = file->f_dentry->d_inode->i_private;
 
 	return rc;
 }

