Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWA1Moi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWA1Moi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 07:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWA1Moi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 07:44:38 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:61656 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751390AbWA1Moh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 07:44:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=nCcYYuOgo578tfLIVkx1OLhW6S/3qVZXUoLksr0wKeYYK/ZEkg/L3hswryvGf1++nIKdOZ5surIj7+G9PeFIeItt95cdFCfUA00w+8x8ujzS0W7Wg7h6wkNcN6iVNw85Zcs31Q4h7jTwhStDfnkhL//rDqph9fNxQzsRnpTR4dA=
Message-ID: <81083a450601280444y683a3899h12054edfe610a51f@mail.gmail.com>
Date: Sat, 28 Jan 2006 18:14:37 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-kernel@vger.kernel.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       Andrew Morton <akpm@osdl.org>, linux-net@vger.kernel.org
Subject: [PATCH] net/core/flow.c CONFIG_SMP Fix in flow_cache_flush(void)
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4357_15118372.1138452277024"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_4357_15118372.1138452277024
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch fixes a warning in the function flow_cache_flush(), where
the the function smp_call_function is entered even when CONFIG_SMP is
not defined

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_4357_15118372.1138452277024
Content-Type: text/plain; name=patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.txt"

--- /usr/src/linux-2.6.16-rc1/net/core/flow.c.orig	2006-01-28 18:00:48.000000000 +0530
+++ /usr/src/linux-2.6.16-rc1/net/core/flow.c	2006-01-28 18:02:16.000000000 +0530
@@ -296,7 +296,9 @@ void flow_cache_flush(void)
 	init_completion(&info.completion);
 
 	local_bh_disable();
+#ifdef CONFIG_SMP
 	smp_call_function(flow_cache_flush_per_cpu, &info, 1, 0);
+#endif /* CONFIG_SMP */
 	flow_cache_flush_tasklet((unsigned long)&info);
 	local_bh_enable();
 


------=_Part_4357_15118372.1138452277024--
