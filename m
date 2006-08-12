Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422695AbWHLVCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWHLVCM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWHLVCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:02:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:25238 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422694AbWHLVCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:02:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pqVdnzmJQxegnKAImwkNL5pn00t64OaRDYNmri2mJ9wG8eunqG0Q3HrIfi2ZreSfsR/oYNp46kIolYBHEc9XYQv7nO6JppgtE33lhjepords5mZp+QbWB6gzBc9+EIbneXGv+9t1NgnzqXM45HW7f+ab4J/VLOS8uJeE+cfV2n8=
Message-ID: <44DE41F3.3010604@gmail.com>
Date: Sat, 12 Aug 2006 23:02:43 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
       Achim Leubner <achim_leubner@adaptec.com>
Subject: Re: [RFC] [PATCH 4/9] drivers/scsi/gdth_proc.c Removal of old scsi
 code
References: <44DE3E5E.3020605@gmail.com>
In-Reply-To: <44DE3E5E.3020605@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/scsi/gdth_proc.c linux-work/drivers/scsi/gdth_proc.c
--- linux-work-clean/drivers/scsi/gdth_proc.c	2006-08-12 01:51:16.000000000 +0200
+++ linux-work/drivers/scsi/gdth_proc.c	2006-08-12 20:48:42.000000000 +0200
@@ -4,7 +4,6 @@

 #include <linux/completion.h>

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
 int gdth_proc_info(struct Scsi_Host *host, char *buffer,char **start,off_t offset,int length,
                    int inout)
 {
@@ -21,32 +20,6 @@ int gdth_proc_info(struct Scsi_Host *hos
     else
         return(gdth_get_info(buffer,start,offset,length,host,hanum,busnum));
 }
-#else
-int gdth_proc_info(char *buffer,char **start,off_t offset,int length,int hostno,
-                   int inout)
-{
-    int hanum,busnum,i;
-
-    TRACE2(("gdth_proc_info() length %d offs %d inout %d\n",
-            length,(int)offset,inout));
-
-    for (i = 0; i < gdth_ctr_vcount; ++i) {
-        if (gdth_ctr_vtab[i]->host_no == hostno)
-            break;
-    }
-    if (i == gdth_ctr_vcount)
-        return(-EINVAL);
-
-    hanum = NUMDATA(gdth_ctr_vtab[i])->hanum;
-    busnum= NUMDATA(gdth_ctr_vtab[i])->busnum;
-
-    if (inout)
-        return(gdth_set_info(buffer,length,gdth_ctr_vtab[i],hanum,busnum));
-    else
-        return(gdth_get_info(buffer,start,offset,length,
-                             gdth_ctr_vtab[i],hanum,busnum));
-}
-#endif

 static int gdth_set_info(char *buffer,int length,struct Scsi_Host *host,
                          int hanum,int busnum)

