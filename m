Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWG2TGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWG2TGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWG2TGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:06:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:37410 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751414AbWG2TGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:06:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=pDQveUMFKO3A4XqTPjSMUpftu4q56Vql86cLxeTOAhNx3OZtNlEg72flfCK7BcAK7NEfIQ19d4HgIWf8jJTKxOg/MjVwEEIblcae7yjPau4FiHklZpx5ogv6VxilUOiG0KVUOl+uuq454pBATabTiOf4evqKwmP0NSp/pZ8Bp8Y=
Message-ID: <35fb2e590607291206o2c25d3el704942e77ca98f62@mail.gmail.com>
Date: Sat, 29 Jul 2006 20:06:14 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] MODULE_FIRMWARE for binary firmware(s)
In-Reply-To: <20060418234156.GA28346@apogee.jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060418234156.GA28346@apogee.jonmasters.org>
X-Google-Sender-Auth: e0dae55e02afa3b4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: Jon Masters <jonathan@jonmasters.org>
Date: Apr 19, 2006 12:41 AM
Subject: [PATCH] MODULE_FIRMWARE for binary firmware(s)
To: akpm@osdl.org, linux-kernel@vger.kernel.org


From: Jon Masters <jcm@redhat.com>

Right now, various kernel modules are being migrated over to use
request_firmware in order to pull in binary firmware blobs from userland
when the module is loaded. This makes sense.

However, there is right now little mechanism in place to automatically
determine which binary firmware blobs must be included with a kernel in
order to satisfy the prerequisites of these drivers. This affects
vendors, but also regular users to a certain extent too.

The attached patch introduces MODULE_FIRMWARE as a mechanism for
advertising that a particular firmware file is to be loaded - it will
then show up via modinfo and could be used e.g. when packaging a kernel.

Signed-off-by: Jon Masters <jcm@redhat.com>

diff -urN linux-2.6.16.2_orig/include/linux/module.h
linux-2.6.16.2_dev/include/linux/module.h
--- linux-2.6.16.2_orig/include/linux/module.h  2006-04-07
17:56:47.000000000 +0100
+++ linux-2.6.16.2_dev/include/linux/module.h   2006-04-12
13:51:56.000000000 +0100
@@ -155,6 +155,8 @@
 */
 #define MODULE_VERSION(_version) MODULE_INFO(version, _version)

+#define MODULE_FIRMWARE(_firmware) MODULE_INFO(firmware, _firmware)
+
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
