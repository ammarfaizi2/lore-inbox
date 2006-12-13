Return-Path: <linux-kernel-owner+w=401wt.eu-S964940AbWLMFyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWLMFyx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 00:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWLMFyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 00:54:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:18073 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964940AbWLMFyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 00:54:52 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 00:54:52 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,160,1165219200"; 
   d="scan'208"; a="176735662:sNHT17818451"
Subject: Parse boot parameter error?
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 13:44:24 +0800
Message-Id: <1165988664.29498.10.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Say a boot parameter is "xxx", if you give a string "xxxy", then the
boot parameter's corresponding function is executed. Is this intended?
If not, below patch fixes it.

diff --git a/init/main.c b/init/main.c
index 036f97c..d56940c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -193,7 +193,8 @@ static int __init obsolete_checksetup(ch
 	p = __setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line, p->str, n)) {
+		if (((!strncmp(line, p->str, n)) && (p->str[n-1] == '='))
+				|| !strcmp(line, p->str)) {
 			if (p->early) {
 				/* Already done in parse_early_param?
 				 * (Needs exact match on param part).
