Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263405AbREXHgo>; Thu, 24 May 2001 03:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbREXHge>; Thu, 24 May 2001 03:36:34 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:54500 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263402AbREXHgW>; Thu, 24 May 2001 03:36:22 -0400
Message-Id: <200105240736.f4O7aK404397@smtp1.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@transmeta.com
Subject: [PATCH] sd.c - null ptr fixes for 2.4.4
Date: Thu, 24 May 2001 00:37:30 -0700
X-Mailer: KMail [version 1.2.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
        linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
This patch fixes a couple of errors in the scsi driver code (sd.c).

Praveen Srinivasan and Frederick Akalin

--- ../linux/./drivers/scsi/sd.c	Sat Feb  3 11:45:55 2001
+++ ./drivers/scsi/sd.c	Mon May  7 22:09:58 2001
@@ -734,8 +734,15 @@
 	 */
 
 	SRpnt = scsi_allocate_request(rscsi_disks[i].device);
+	if(SRpnt == NULL) {
+	  return i;
+	}
 
 	buffer = (unsigned char *) scsi_malloc(512);
+       
+	if(buffer == NULL) {
+	  return i;
+	}
 
 	spintime = 0;
 
