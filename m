Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTFDIWi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 04:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFDIWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 04:22:37 -0400
Received: from zeus.kernel.org ([204.152.189.113]:5097 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263171AbTFDIWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 04:22:30 -0400
Date: Tue, 3 Jun 2003 21:01:00 +1000
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix ide-mod unload crash
Message-ID: <20030603110100.GA29025@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch fixes an unload crash when no PCI drivers are loaded.

It's scary that people writing code like this is hacking on the
driver where all my data is stored on! Time to make more backups :)
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: drivers/ide/ide-proc.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/ide/ide-proc.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 ide-proc.c
--- drivers/ide/ide-proc.c	1 Jun 2003 03:06:25 -0000	1.1.1.6
+++ drivers/ide/ide-proc.c	3 Jun 2003 10:54:58 -0000
@@ -982,16 +982,11 @@
 void proc_ide_destroy(void)
 {
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	ide_pci_host_proc_t *p = ide_pci_host_proc_list;
-	char name[32];
+	ide_pci_host_proc_t *p;
 
-	while ((p->name != NULL) && (p->set) && (p->get_info != NULL)) {
-		name[0] = '\0';
-		sprintf(name, "ide/%s", p->name);
+	for (p = ide_pci_host_proc_list; p; p = p->next) {
 		if (p->set == 2)
 			remove_proc_entry(p->name, p->parent);
-		if (p->next == NULL) break;
-		p = p->next;
 	}
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 	remove_proc_entry("ide/drivers", proc_ide_root);

--SUOF0GtieIMvvwua--
