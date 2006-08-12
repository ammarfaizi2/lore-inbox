Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWHLVEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWHLVEU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWHLVD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:03:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:17043 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422699AbWHLVCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:02:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LF2g4qODmOkBD/LBdCFUx0/9mzE3wO3vuaZIOCY/AHvdNUwLdcCx3exN1GORUjD10FNgLpPTQFuodtm9p6VkbHA5mjEM1LGRRQ/Xm5IueyB6PGofPW4KI9L24xHAjFmvtOUB50dqZbgy1ru4FDJ7cfpX/bn0kUR1gbKyy3WSXK8=
Message-ID: <44DE4211.2000802@gmail.com>
Date: Sat, 12 Aug 2006 23:03:13 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       GOTO Masanori <gotom@debian.or.jp>
Subject: Re: [RFC] [PATCH 8/9] drivers/scsi/nsp32.h Removal of old scsi code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/nsp32.h linux-work/drivers/scsi/nsp32.h
--- linux-work-clean/drivers/scsi/nsp32.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-work/drivers/scsi/nsp32.h	2006-08-12 20:40:00.000000000 +0200
@@ -619,47 +619,5 @@ typedef struct _nsp32_hw_data {
 #define REQSACK_TIMEOUT_TIME	10000	/* max wait time for REQ/SACK assertion
 					   or negation, 10000us == 10ms */

-/**************************************************************************
- * Compatibility functions
- */
-
-/* for Kernel 2.4 */
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0))
-# define scsi_register_host(template) 	scsi_register_module(MODULE_SCSI_HA, template)
-# define scsi_unregister_host(template) scsi_unregister_module(MODULE_SCSI_HA, template)
-# define scsi_host_put(host)            scsi_unregister(host)
-# define pci_name(pci_dev)              ((pci_dev)->slot_name)
-
-typedef void irqreturn_t;
-# define IRQ_NONE      /* */
-# define IRQ_HANDLED   /* */
-# define IRQ_RETVAL(x) /* */
-
-/* This is ad-hoc version of scsi_host_get_next() */
-static inline struct Scsi_Host *scsi_host_get_next(struct Scsi_Host *host)
-{
-	if (host == NULL) {
-		return scsi_hostlist;
-	} else {
-		return host->next;
-	}
-}
-
-/* This is ad-hoc version of scsi_host_hn_get() */
-static inline struct Scsi_Host *scsi_host_hn_get(unsigned short hostno)
-{
-	struct Scsi_Host *host;
-
-	for (host = scsi_host_get_next(NULL); host != NULL;
-	     host = scsi_host_get_next(host)) {
-		if (host->host_no == hostno) {
-			break;
-		}
-	}
-
-	return host;
-}
-#endif
-
 #endif /* _NSP32_H */
 /* end */

