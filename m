Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWJXIyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWJXIyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWJXIyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:54:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:48208 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030224AbWJXIyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:54:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=CKByo7Y5G2+v6fVzqA7j3AmJtz067nPgxA/L27PmRV+pAd1HZIjWUgKz/X9mTIDOf+JK/PjU8vEVnG+t4RHs0fp5iEwdyVGE4ZTne6ZY2o4zZOt7SmBwGgn8QL+AC3t7TNrMU/bIU0Cuf7YLNCmdyu09o54iZfDF2hUGsLt2mfQ=
Date: Tue, 24 Oct 2006 17:53:57 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: [PATCH] appletalk: prevent unregister_sysctl_table() with a NULL argument
Message-ID: <20061024085357.GB7703@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If register_sysctl_table() fails during module initalization,
NULL pointer dereference will happen in the module cleanup.

Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 net/appletalk/sysctl_net_atalk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: work-fault-inject/net/appletalk/sysctl_net_atalk.c
===================================================================
--- work-fault-inject.orig/net/appletalk/sysctl_net_atalk.c
+++ work-fault-inject/net/appletalk/sysctl_net_atalk.c
@@ -78,5 +78,6 @@ void atalk_register_sysctl(void)
 
 void atalk_unregister_sysctl(void)
 {
-	unregister_sysctl_table(atalk_table_header);
+	if (atalk_table_header)
+		unregister_sysctl_table(atalk_table_header);
 }
