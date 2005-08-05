Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVHEPDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVHEPDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVHEOxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:39 -0400
Received: from fep18.inet.fi ([194.251.242.243]:14783 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S262630AbVHEOvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:51:55 -0400
Subject: [PATCH 7/8] fs: convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7kg.6lzzr6.7ocpqo9oanclt926l5vz7gkyx.beaver@cs.helsinki.fi>
In-Reply-To: <ikr7k7.yd6x86.4tha6emvbijm9jwl3fjqhsrfy.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:51:53 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts kcalloc(1, ...) calls to use the new kzalloc() function.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 cifs/connect.c        |   82 +++++++++++++++++++++++++-------------------------
 freevxfs/vxfs_super.c |    2 -
 2 files changed, 42 insertions(+), 42 deletions(-)

Index: 2.6/fs/cifs/connect.c
===================================================================
--- 2.6.orig/fs/cifs/connect.c
+++ 2.6/fs/cifs/connect.c
@@ -836,7 +836,7 @@ cifs_parse_mount_options(char *options, 
 				/* go from value to value + temp_len condensing 
 				double commas to singles. Note that this ends up
 				allocating a few bytes too many, which is ok */
-				vol->password = kcalloc(1, temp_len, GFP_KERNEL);
+				vol->password = kzalloc(temp_len, GFP_KERNEL);
 				if(vol->password == NULL) {
 					printk("CIFS: no memory for pass\n");
 					return 1;
@@ -851,7 +851,7 @@ cifs_parse_mount_options(char *options, 
 				}
 				vol->password[j] = 0;
 			} else {
-				vol->password = kcalloc(1, temp_len+1, GFP_KERNEL);
+				vol->password = kzalloc(temp_len+1, GFP_KERNEL);
 				if(vol->password == NULL) {
 					printk("CIFS: no memory for pass\n");
 					return 1;
@@ -1317,7 +1317,7 @@ ipv4_connect(struct sockaddr_in *psin_se
 		sessinit is sent but no second negprot */
 		struct rfc1002_session_packet * ses_init_buf;
 		struct smb_hdr * smb_buf;
-		ses_init_buf = kcalloc(1, sizeof(struct rfc1002_session_packet), GFP_KERNEL);
+		ses_init_buf = kzalloc(sizeof(struct rfc1002_session_packet), GFP_KERNEL);
 		if(ses_init_buf) {
 			ses_init_buf->trailer.session_req.called_len = 32;
 			rfc1002mangle(ses_init_buf->trailer.session_req.called_name,
@@ -1964,7 +1964,7 @@ CIFSSessSetup(unsigned int xid, struct c
 /* We look for obvious messed up bcc or strings in response so we do not go off
    the end since (at least) WIN2K and Windows XP have a major bug in not null
    terminating last Unicode string in response  */
-				ses->serverOS = kcalloc(1, 2 * (len + 1), GFP_KERNEL);
+				ses->serverOS = kzalloc(2 * (len + 1), GFP_KERNEL);
 				if(ses->serverOS == NULL)
 					goto sesssetup_nomem;
 				cifs_strfromUCS_le(ses->serverOS,
@@ -1976,7 +1976,7 @@ CIFSSessSetup(unsigned int xid, struct c
 				if (remaining_words > 0) {
 					len = UniStrnlen((wchar_t *)bcc_ptr,
 							 remaining_words-1);
-					ses->serverNOS = kcalloc(1, 2 * (len + 1),GFP_KERNEL);
+					ses->serverNOS = kzalloc(2 * (len + 1),GFP_KERNEL);
 					if(ses->serverNOS == NULL)
 						goto sesssetup_nomem;
 					cifs_strfromUCS_le(ses->serverNOS,
@@ -1994,7 +1994,7 @@ CIFSSessSetup(unsigned int xid, struct c
 						len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);
           /* last string is not always null terminated (for e.g. for Windows XP & 2000) */
 						ses->serverDomain =
-						    kcalloc(1, 2*(len+1),GFP_KERNEL);
+						    kzalloc(2*(len+1),GFP_KERNEL);
 						if(ses->serverDomain == NULL)
 							goto sesssetup_nomem;
 						cifs_strfromUCS_le(ses->serverDomain,
@@ -2005,22 +2005,22 @@ CIFSSessSetup(unsigned int xid, struct c
 					} /* else no more room so create dummy domain string */
 					else
 						ses->serverDomain = 
-							kcalloc(1, 2, GFP_KERNEL);
+							kzalloc(2, GFP_KERNEL);
 				} else {	/* no room so create dummy domain and NOS string */
 					/* if these kcallocs fail not much we
 					   can do, but better to not fail the
 					   sesssetup itself */
 					ses->serverDomain =
-					    kcalloc(1, 2, GFP_KERNEL);
+					    kzalloc(2, GFP_KERNEL);
 					ses->serverNOS =
-					    kcalloc(1, 2, GFP_KERNEL);
+					    kzalloc(2, GFP_KERNEL);
 				}
 			} else {	/* ASCII */
 				len = strnlen(bcc_ptr, 1024);
 				if (((long) bcc_ptr + len) - (long)
 				    pByteArea(smb_buffer_response)
 					    <= BCC(smb_buffer_response)) {
-					ses->serverOS = kcalloc(1, len + 1,GFP_KERNEL);
+					ses->serverOS = kzalloc(len + 1,GFP_KERNEL);
 					if(ses->serverOS == NULL)
 						goto sesssetup_nomem;
 					strncpy(ses->serverOS,bcc_ptr, len);
@@ -2030,7 +2030,7 @@ CIFSSessSetup(unsigned int xid, struct c
 					bcc_ptr++;
 
 					len = strnlen(bcc_ptr, 1024);
-					ses->serverNOS = kcalloc(1, len + 1,GFP_KERNEL);
+					ses->serverNOS = kzalloc(len + 1,GFP_KERNEL);
 					if(ses->serverNOS == NULL)
 						goto sesssetup_nomem;
 					strncpy(ses->serverNOS, bcc_ptr, len);
@@ -2039,7 +2039,7 @@ CIFSSessSetup(unsigned int xid, struct c
 					bcc_ptr++;
 
 					len = strnlen(bcc_ptr, 1024);
-					ses->serverDomain = kcalloc(1, len + 1,GFP_KERNEL);
+					ses->serverDomain = kzalloc(len + 1,GFP_KERNEL);
 					if(ses->serverDomain == NULL)
 						goto sesssetup_nomem;
 					strncpy(ses->serverDomain, bcc_ptr, len);
@@ -2240,7 +2240,7 @@ CIFSSpnegoSessSetup(unsigned int xid, st
    the end since (at least) WIN2K and Windows XP have a major bug in not null
    terminating last Unicode string in response  */
 					ses->serverOS =
-					    kcalloc(1, 2 * (len + 1), GFP_KERNEL);
+					    kzalloc(2 * (len + 1), GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverOS,
 							   (wchar_t *)
 							   bcc_ptr, len,
@@ -2254,7 +2254,7 @@ CIFSSpnegoSessSetup(unsigned int xid, st
 								 remaining_words
 								 - 1);
 						ses->serverNOS =
-						    kcalloc(1, 2 * (len + 1),
+						    kzalloc(2 * (len + 1),
 							    GFP_KERNEL);
 						cifs_strfromUCS_le(ses->serverNOS,
 								   (wchar_t *)bcc_ptr,
@@ -2267,7 +2267,7 @@ CIFSSpnegoSessSetup(unsigned int xid, st
 						if (remaining_words > 0) {
 							len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
                             /* last string is not always null terminated (for e.g. for Windows XP & 2000) */
-							ses->serverDomain = kcalloc(1, 2*(len+1),GFP_KERNEL);
+							ses->serverDomain = kzalloc(2*(len+1),GFP_KERNEL);
 							cifs_strfromUCS_le(ses->serverDomain,
 							     (wchar_t *)bcc_ptr, 
                                  len,
@@ -2278,10 +2278,10 @@ CIFSSpnegoSessSetup(unsigned int xid, st
 						} /* else no more room so create dummy domain string */
 						else
 							ses->serverDomain =
-							    kcalloc(1, 2,GFP_KERNEL);
+							    kzalloc(2,GFP_KERNEL);
 					} else {	/* no room so create dummy domain and NOS string */
-						ses->serverDomain = kcalloc(1, 2, GFP_KERNEL);
-						ses->serverNOS = kcalloc(1, 2, GFP_KERNEL);
+						ses->serverDomain = kzalloc(2, GFP_KERNEL);
+						ses->serverNOS = kzalloc(2, GFP_KERNEL);
 					}
 				} else {	/* ASCII */
 
@@ -2289,7 +2289,7 @@ CIFSSpnegoSessSetup(unsigned int xid, st
 					if (((long) bcc_ptr + len) - (long)
 					    pByteArea(smb_buffer_response)
 					    <= BCC(smb_buffer_response)) {
-						ses->serverOS = kcalloc(1, len + 1, GFP_KERNEL);
+						ses->serverOS = kzalloc(len + 1, GFP_KERNEL);
 						strncpy(ses->serverOS, bcc_ptr, len);
 
 						bcc_ptr += len;
@@ -2297,14 +2297,14 @@ CIFSSpnegoSessSetup(unsigned int xid, st
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverNOS = kcalloc(1, len + 1,GFP_KERNEL);
+						ses->serverNOS = kzalloc(len + 1,GFP_KERNEL);
 						strncpy(ses->serverNOS, bcc_ptr, len);
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverDomain = kcalloc(1, len + 1, GFP_KERNEL);
+						ses->serverDomain = kzalloc(len + 1, GFP_KERNEL);
 						strncpy(ses->serverDomain, bcc_ptr, len);
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
@@ -2554,7 +2554,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
    the end since (at least) WIN2K and Windows XP have a major bug in not null
    terminating last Unicode string in response  */
 					ses->serverOS =
-					    kcalloc(1, 2 * (len + 1), GFP_KERNEL);
+					    kzalloc(2 * (len + 1), GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverOS,
 							   (wchar_t *)
 							   bcc_ptr, len,
@@ -2569,7 +2569,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 								 remaining_words
 								 - 1);
 						ses->serverNOS =
-						    kcalloc(1, 2 * (len + 1),
+						    kzalloc(2 * (len + 1),
 							    GFP_KERNEL);
 						cifs_strfromUCS_le(ses->
 								   serverNOS,
@@ -2586,7 +2586,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 							len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
            /* last string is not always null terminated (for e.g. for Windows XP & 2000) */
 							ses->serverDomain =
-							    kcalloc(1, 2 *
+							    kzalloc(2 *
 								    (len +
 								     1),
 								    GFP_KERNEL);
@@ -2612,13 +2612,13 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 						} /* else no more room so create dummy domain string */
 						else
 							ses->serverDomain =
-							    kcalloc(1, 2,
+							    kzalloc(2,
 								    GFP_KERNEL);
 					} else {	/* no room so create dummy domain and NOS string */
 						ses->serverDomain =
-						    kcalloc(1, 2, GFP_KERNEL);
+						    kzalloc(2, GFP_KERNEL);
 						ses->serverNOS =
-						    kcalloc(1, 2, GFP_KERNEL);
+						    kzalloc(2, GFP_KERNEL);
 					}
 				} else {	/* ASCII */
 					len = strnlen(bcc_ptr, 1024);
@@ -2626,7 +2626,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 					    pByteArea(smb_buffer_response)
 					    <= BCC(smb_buffer_response)) {
 						ses->serverOS =
-						    kcalloc(1, len + 1,
+						    kzalloc(len + 1,
 							    GFP_KERNEL);
 						strncpy(ses->serverOS,
 							bcc_ptr, len);
@@ -2637,7 +2637,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 
 						len = strnlen(bcc_ptr, 1024);
 						ses->serverNOS =
-						    kcalloc(1, len + 1,
+						    kzalloc(len + 1,
 							    GFP_KERNEL);
 						strncpy(ses->serverNOS, bcc_ptr, len);
 						bcc_ptr += len;
@@ -2646,7 +2646,7 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
 
 						len = strnlen(bcc_ptr, 1024);
 						ses->serverDomain =
-						    kcalloc(1, len + 1,
+						    kzalloc(len + 1,
 							    GFP_KERNEL);
 						strncpy(ses->serverDomain, bcc_ptr, len);	
 						bcc_ptr += len;
@@ -2948,7 +2948,7 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
   the end since (at least) WIN2K and Windows XP have a major bug in not null
   terminating last Unicode string in response  */
 					ses->serverOS =
-					    kcalloc(1, 2 * (len + 1), GFP_KERNEL);
+					    kzalloc(2 * (len + 1), GFP_KERNEL);
 					cifs_strfromUCS_le(ses->serverOS,
 							   (wchar_t *)
 							   bcc_ptr, len,
@@ -2963,7 +2963,7 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 								 remaining_words
 								 - 1);
 						ses->serverNOS =
-						    kcalloc(1, 2 * (len + 1),
+						    kzalloc(2 * (len + 1),
 							    GFP_KERNEL);
 						cifs_strfromUCS_le(ses->
 								   serverNOS,
@@ -2979,7 +2979,7 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 							len = UniStrnlen((wchar_t *) bcc_ptr, remaining_words);	
      /* last string not always null terminated (e.g. for Windows XP & 2000) */
 							ses->serverDomain =
-							    kcalloc(1, 2 *
+							    kzalloc(2 *
 								    (len +
 								     1),
 								    GFP_KERNEL);
@@ -3004,17 +3004,17 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 							    = 0;
 						} /* else no more room so create dummy domain string */
 						else
-							ses->serverDomain = kcalloc(1, 2,GFP_KERNEL);
+							ses->serverDomain = kzalloc(2,GFP_KERNEL);
 					} else {  /* no room so create dummy domain and NOS string */
-						ses->serverDomain = kcalloc(1, 2, GFP_KERNEL);
-						ses->serverNOS = kcalloc(1, 2, GFP_KERNEL);
+						ses->serverDomain = kzalloc(2, GFP_KERNEL);
+						ses->serverNOS = kzalloc(2, GFP_KERNEL);
 					}
 				} else {	/* ASCII */
 					len = strnlen(bcc_ptr, 1024);
 					if (((long) bcc_ptr + len) - 
                         (long) pByteArea(smb_buffer_response) 
                             <= BCC(smb_buffer_response)) {
-						ses->serverOS = kcalloc(1, len + 1,GFP_KERNEL);
+						ses->serverOS = kzalloc(len + 1,GFP_KERNEL);
 						strncpy(ses->serverOS,bcc_ptr, len);
 
 						bcc_ptr += len;
@@ -3022,14 +3022,14 @@ CIFSNTLMSSPAuthSessSetup(unsigned int xi
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverNOS = kcalloc(1, len+1,GFP_KERNEL);
+						ses->serverNOS = kzalloc(len+1,GFP_KERNEL);
 						strncpy(ses->serverNOS, bcc_ptr, len);	
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
 						bcc_ptr++;
 
 						len = strnlen(bcc_ptr, 1024);
-						ses->serverDomain = kcalloc(1, len+1,GFP_KERNEL);
+						ses->serverDomain = kzalloc(len+1,GFP_KERNEL);
 						strncpy(ses->serverDomain, bcc_ptr, len);
 						bcc_ptr += len;
 						bcc_ptr[0] = 0;
@@ -3141,7 +3141,7 @@ CIFSTCon(unsigned int xid, struct cifsSe
 				if(tcon->nativeFileSystem)
 					kfree(tcon->nativeFileSystem);
 				tcon->nativeFileSystem =
-				    kcalloc(1, length + 2, GFP_KERNEL);
+				    kzalloc(length + 2, GFP_KERNEL);
 				cifs_strfromUCS_le(tcon->nativeFileSystem,
 						   (wchar_t *) bcc_ptr,
 						   length, nls_codepage);
@@ -3159,7 +3159,7 @@ CIFSTCon(unsigned int xid, struct cifsSe
 				if(tcon->nativeFileSystem)
 					kfree(tcon->nativeFileSystem);
 				tcon->nativeFileSystem =
-				    kcalloc(1, length + 1, GFP_KERNEL);
+				    kzalloc(length + 1, GFP_KERNEL);
 				strncpy(tcon->nativeFileSystem, bcc_ptr,
 					length);
 			}
Index: 2.6/fs/freevxfs/vxfs_super.c
===================================================================
--- 2.6.orig/fs/freevxfs/vxfs_super.c
+++ 2.6/fs/freevxfs/vxfs_super.c
@@ -155,7 +155,7 @@ static int vxfs_fill_super(struct super_
 
 	sbp->s_flags |= MS_RDONLY;
 
-	infp = kcalloc(1, sizeof(*infp), GFP_KERNEL);
+	infp = kzalloc(sizeof(*infp), GFP_KERNEL);
 	if (!infp) {
 		printk(KERN_WARNING "vxfs: unable to allocate incore superblock\n");
 		return -ENOMEM;
