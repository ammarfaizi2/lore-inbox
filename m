Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUJUMrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUJUMrC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 08:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUJUMpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 08:45:17 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:28396 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S268722AbUJUMkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 08:40:09 -0400
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Thu, 21 Oct 2004 14:38:55 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6 current] Fix building with separate object directories
Message-ID: <20041021123855.GA11161@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.6+20040722i
X-Smurf-Spam-Score: -2.8 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-supplied initramfs list needs to be copied to the
build directory. Otherwise the generator won't find it.

Signed-off-by: Matthias Urlichs <smurf@smurf.noris.de>

===== usr/Makefile 1.12 vs edited =====
--- 1.12/usr/Makefile	2004-10-20 10:37:03 +02:00
+++ edited/usr/Makefile	2004-10-21 14:33:20 +02:00
@@ -29,12 +29,14 @@
 	  if [ $(CONFIG_INITRAMFS_SOURCE) != $@ ]; then \
 	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
 	  else \
-	    echo 'echo Using shipped $@'; \
+	    echo 'echo Using shipped $@; \
+	    cp -f $(srctree)/$@ $@'; \
 	  fi; \
 	elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
 	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
 	else \
-	  echo 'echo Using shipped $@'; \
+	  echo 'echo Using shipped $@; \
+	  cp -f $(srctree)/$@ $@'; \
 	fi)
 
 
