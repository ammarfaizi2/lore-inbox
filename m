Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266005AbUFOWzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266005AbUFOWzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUFOWzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:55:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:59819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266005AbUFOWzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:55:43 -0400
Date: Tue, 15 Jun 2004 15:55:41 -0700
From: Chris Wright <chrisw@osdl.org>
To: jgarzik@pobox.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ethtool_get_regs copy right number of bytes to user
Message-ID: <20040615155541.Q21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If regs.len is smaller than reglen it's possible to copy more bytes out
than the user asked for.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== net/core/ethtool.c 1.14 vs edited =====
--- 1.14/net/core/ethtool.c	2004-06-02 14:54:28 -07:00
+++ edited/net/core/ethtool.c	2004-06-13 12:59:15 -07:00
@@ -157,7 +157,7 @@
 	if (copy_to_user(useraddr, &regs, sizeof(regs)))
 		goto out;
 	useraddr += offsetof(struct ethtool_regs, data);
-	if (copy_to_user(useraddr, regbuf, reglen))
+	if (copy_to_user(useraddr, regbuf, regs.len))
 		goto out;
 	ret = 0;
 
