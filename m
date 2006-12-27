Return-Path: <linux-kernel-owner+w=401wt.eu-S932885AbWL0Coc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932885AbWL0Coc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 21:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWL0Coc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 21:44:32 -0500
Received: from web38015.mail.mud.yahoo.com ([209.191.124.126]:24217 "HELO
	web38015.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932885AbWL0Cob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 21:44:31 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 21:44:31 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4f7FL4BAWEfz9f4RV2oUt1tqddSCglF0lnNVpXFgecDOXclyc8FrXCayk7ASqREeFpf+VB3asbfA5PzV8UXhsmrKdtikNhkAybChDVhvDcUITBoeCWwwrda/Le2AsdN3Q1vu13sABHht5CoAR3SaCO7fOhJbNTcEtU84WSfEKHY=  ;
Message-ID: <20061227023750.5300.qmail@web38015.mail.mud.yahoo.com>
X-YMail-OSG: DfeFhw8VM1nhuXAw7Au_qWfRpQJhQN7DMNaPVeZoXOP.XTJ66vqLbttfJZHpfXNJqqZmqSKggEWJywJbjPXL6yq62qdAsKafb1j16jN51xu4gqN8G_94PqLCTJCJReke4bzN5pFxxVRM7Sw-
Date: Tue, 26 Dec 2006 18:37:50 -0800 (PST)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: [PATCH] Buglet in vmscan.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-464885250-1167187070=:2630"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-464885250-1167187070=:2630
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

The attached patch fixes a rather obvious buglet. 
Noticed while instrumenting the VM using /proc/vmstat.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-464885250-1167187070=:2630
Content-Type: text/x-patch; name="vm-pgsteal-count-fix.patch"
Content-Description: 726233005-vm-pgsteal-count-fix.patch
Content-Disposition: inline; filename="vm-pgsteal-count-fix.patch"

--- .orig/mm/vmscan.c	2006-12-26 21:34:30.000000000 -0500
+++ 2.6.20-rc2-wb-fix/mm/vmscan.c	2006-12-26 21:32:17.000000000 -0500
@@ -692,7 +692,7 @@
 			__count_vm_events(KSWAPD_STEAL, nr_freed);
 		} else
 			__count_zone_vm_events(PGSCAN_DIRECT, zone, nr_scan);
-		__count_vm_events(PGACTIVATE, nr_freed);
+		__count_zone_vm_events(PGSTEAL, zone, nr_freed);
 
 		if (nr_taken == 0)
 			goto done;

--0-464885250-1167187070=:2630--
