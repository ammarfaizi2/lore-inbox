Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbULaA3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbULaA3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 19:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbULaA3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 19:29:52 -0500
Received: from mail.dif.dk ([193.138.115.101]:8390 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261733AbULaA3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 19:29:45 -0500
Date: Fri, 31 Dec 2004 01:40:54 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: make mandocs fails in 2.6.10-bk2
Message-ID: <Pine.LNX.4.61.0412310135290.4725@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


make mandocs fails with these errors in 2.6.10-bk2 : 

juhl@dragon:~/download/kernel/linux-2.6.10-bk2$ make mandocs
  DOCPROC Documentation/DocBook/kernel-api.sgml
docproc: /home/juhl/download/kernel/linux-2.6.10-bk2/drivers/net/net_init.c: No such file or directory
/bin/sh: line 1:  4845 Segmentation fault      
SRCTREE=/home/juhl/download/kernel/linux-2.6.10-bk2/ scripts/basic/docproc doc Documentation/DocBook/kernel-api.tmpl >Documentation/DocBook/kernel-api.sgml
make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 139
make: *** [mandocs] Error 2

removing the reference to net_init.c makes it continue a bit further but 
it still ends up failing with these errors : 

make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 1
make: *** [mandocs] Error 2

This is what I did :

diff -u linux-2.6.10-bk2-orig/Documentation/DocBook/kernel-api.tmpl linux-2.6.10-bk2/Documentation/DocBook/kernel-api.tmpl
--- linux-2.6.10-bk2-orig/Documentation/DocBook/kernel-api.tmpl	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.10-bk2/Documentation/DocBook/kernel-api.tmpl	2004-12-31 01:33:53.000000000 +0100
@@ -143,7 +143,6 @@
   <chapter id="netdev">
      <title>Network device support</title>
      <sect1><title>Driver Support</title>
-!Edrivers/net/net_init.c
 !Enet/core/dev.c
      </sect1>
      <sect1><title>8390 Based Network Cards</title>


Since I have very little knowledge about SGML or the building of these 
docs in general, I'd appreciate some help from someone more knowledgable 
than me. Having to live without mandocs would be sad...


-- 
Jesper Juhl


