Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUKBXhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUKBXhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUKBX2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:28:45 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:62603 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262746AbUKBXXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:23:19 -0500
Date: Wed, 3 Nov 2004 00:23:18 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor fix of RCU documentation
Message-ID: <20041102232317.GD13012@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, all!

the attached patch fixes an incorrect example in Documentation/RCU/listRCU.txt
- the "original" lock-based code should not call RCU functions, of course.

-Yenya

Signed-Off-By: Jan "Yenya" Kasprzak <kas@fi.muni.cz>

--- linux-2.6.9/Documentation/RCU/listRCU.txt.orig	2004-10-18 23:53:44.000000000 +0200
+++ linux-2.6.9/Documentation/RCU/listRCU.txt	2004-10-30 14:49:42.706526360 +0200
@@ -82,7 +82,7 @@
 		list_for_each_entry(e, list, list) {
 			if (!audit_compare_rule(rule, &e->rule)) {
 				list_del(&e->list);
-				call_rcu(&e->rcu, audit_free_rule, e);
+				write_unlock(&auditsc_lock);
 				return 0;
 			}
 		}

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
