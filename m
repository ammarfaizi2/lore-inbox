Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSKUWVi>; Thu, 21 Nov 2002 17:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264944AbSKUWVi>; Thu, 21 Nov 2002 17:21:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10112 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264940AbSKUWVg>;
	Thu, 21 Nov 2002 17:21:36 -0500
Date: Thu, 21 Nov 2002 14:28:38 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Use min_t() instead of min() in fs/cifs/cifssmb.c
Message-ID: <20021121222838.GA1431@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change removes "duplicate 'const'" compiler warnings.

diff -Nru a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
--- a/fs/cifs/cifssmb.c	Thu Nov 21 13:51:25 2002
+++ b/fs/cifs/cifssmb.c	Thu Nov 21 13:51:26 2002
@@ -483,9 +483,10 @@
 	pSMB->OffsetLow = cpu_to_le32(lseek & 0xFFFFFFFF);
 	pSMB->OffsetHigh = cpu_to_le32(lseek >> 32);
 	pSMB->Remaining = 0;
-	pSMB->MaxCount = cpu_to_le16(min(count,
-					 (tcon->ses->maxBuf -
-					  MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));
+	pSMB->MaxCount = cpu_to_le16(min_t(const unsigned int,
+					   count,
+					   (tcon->ses->maxBuf -
+					    MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));
 	pSMB->MaxCountHigh = 0;
 	pSMB->ByteCount = 0;  /* no need to do le conversion since it is 0 */
 
@@ -1023,9 +1024,10 @@
 								   Protocol +
 								   pSMBr->
 								   DataOffset),
-						      min(buflen,
-							  (int) pSMBr->
-							  DataCount) / 2);
+						      min_t(const int,
+							    buflen,
+							    (int) pSMBr->
+							    DataCount) / 2);
 				cifs_strfromUCS_le(symlinkinfo,
 						   (wchar_t *) ((char *)
 								&pSMBr->
@@ -1037,9 +1039,10 @@
 			} else {
 				strncpy(symlinkinfo,
 					(char *) &pSMBr->hdr.Protocol +
-					pSMBr->DataOffset, min(buflen, (int)
-							       pSMBr->
-							       DataCount));
+					pSMBr->DataOffset, min_t(const int,
+								 buflen,
+								 pSMBr->
+								 DataCount));
 			}
 			symlinkinfo[buflen] = 0;	/* just in case so the calling code does not go off the end of the buffer */
 		}
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
