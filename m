Return-Path: <linux-kernel-owner+w=401wt.eu-S1761255AbWLHXHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761255AbWLHXHE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761243AbWLHXHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:07:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:9009 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761255AbWLHXHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:07:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=dqNG35nDlrkP8J7ML3Oc7ZbScyE6LNDjJFywDJrP1PFtbANDoJWVoLd+HVxgV8z4O6uH2awDLcUSkLbLptvFyBwG5J+pL1rb5fLplAAPU0pzNl4E6aoFixGevvIw8zi0I43+U7z0lSwA2kW5pKhdZGbynsXk/1ABg6GKJ6k12o0=
Date: Sat, 9 Dec 2006 02:06:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: remove some OPs
Message-ID: <20061208230657.GA5109@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.cap-bound uses only OP_SET and OP_AND

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/sysctl.c |   10 ----------
 1 file changed, 10 deletions(-)

--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1931,9 +1931,6 @@ int proc_dointvec(ctl_table *table, int 
 
 #define OP_SET	0
 #define OP_AND	1
-#define OP_OR	2
-#define OP_MAX	3
-#define OP_MIN	4
 
 static int do_proc_dointvec_bset_conv(int *negp, unsigned long *lvalp,
 				      int *valp,
@@ -1945,13 +1942,6 @@ static int do_proc_dointvec_bset_conv(in
 		switch(op) {
 		case OP_SET:	*valp = val; break;
 		case OP_AND:	*valp &= val; break;
-		case OP_OR:	*valp |= val; break;
-		case OP_MAX:	if(*valp < val)
-					*valp = val;
-				break;
-		case OP_MIN:	if(*valp > val)
-				*valp = val;
-				break;
 		}
 	} else {
 		int val = *valp;

