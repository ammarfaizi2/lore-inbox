Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266808AbUHMTAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266808AbUHMTAY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUHMTAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:00:04 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:13277 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266808AbUHMS5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:57:38 -0400
Message-ID: <411D0EEC.2080003@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:56:44 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] af_irda.c comparison fix
Content-Type: multipart/mixed;
	boundary="------------080004070107050001000304"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080004070107050001000304
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

 From 2.6, cures compiler warnings.

=D6zkan Sezer


--------------080004070107050001000304
Content-Type: text/plain;
	name="af_irda.c-2.6-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="af_irda.c-2.6-fix.diff"

--- 27rc5~/net/irda/af_irda.c	2003-11-28 20:26:21.000000000 +0200
+++ 27rc5/net/irda/af_irda.c	2004-08-07 14:09:39.000000000 +0300
@@ -1900,11 +1900,10 @@
 		case IAS_STRING:
 			/* Should check charset & co */
 			/* Check length */
-			if(ias_opt->attribute.irda_attrib_string.len >
-			   IAS_MAX_STRING) {
-				kfree(ias_opt);
-				return -EINVAL;
-			}
+			/* The length is encoded in a __u8, and
+			 * IAS_MAX_STRING == 256, so there is no way
+			 * userspace can pass us a string too large.
+			 * Jean II */
 			/* NULL terminate the string (avoid troubles) */
 			ias_opt->attribute.irda_attrib_string.string[ias_opt->attribute.irda_attrib_string.len] = '\0';
 			/* Add a string attribute */


--------------080004070107050001000304--
