Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264495AbUEUXCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbUEUXCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUEUWty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:49:54 -0400
Received: from zeus.kernel.org ([204.152.189.113]:36774 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265100AbUEUWtW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:49:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] Kernel parameter parsing fix
Date: Fri, 21 May 2004 18:07:56 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD54A5@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Kernel parameter parsing fix
Thread-Index: AcQ/G+aQoEMbj7PMRO6j1cPsBevt1w==
From: "Zhu, Yi" <yi.zhu@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 21 May 2004 10:08:21.0738 (UTC) FILETIME=[8BEBF4A0:01C43F1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Must all the kernel parameters have trailing '=' at the end of the param
string?
If not, I think below patch is useful to avoid potential problems.

Thanks,

--- linux-2.6.6.orig/init/main.c	2004-05-14 13:38:31.000000000
+0800
+++ linux-2.6.6/init/main.c	2004-05-15 00:25:41.339261792 +0800
@@ -149,11 +149,15 @@ static int __init obsolete_checksetup(ch  {
 	struct obs_kernel_param *p;
 	extern struct obs_kernel_param __setup_start, __setup_end;
+	char *ptr;
+	int len = strlen(line);
 
+	if ((ptr = strchr(line, '=')))
+		len = ptr - line;
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line, p->str, n)) {
+		if (len <= n && !strncmp(line, p->str, n)) {
 			if (!p->setup_func) {
 				printk(KERN_WARNING "Parameter %s is
obsolete, ignored\n", p->str);
 				return 1;


-----------------------------------------------------------------
Opinions expressed are those of the author and do not represent Intel
Corp.

- Zhu Yi (Chuyee)

GnuPG v1.0.6 (GNU/Linux)
http://cn.geocities.com/chewie_chuyee/gpg.txt or
$ gpg --keyserver wwwkeys.pgp.net --recv-keys 71C34820
1024D/71C34820 C939 2B0B FBCE 1D51 109A  55E5 8650 DB90 71C3 4820 
