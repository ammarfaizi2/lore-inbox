Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWHHElt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWHHElt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWHHElt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:41:49 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:48171 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932479AbWHHEls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:41:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=D8wrwSntkcv+NKXtuFsDHqr1vIugoCO7S+fMGu0RZhwp5xf/u5hKtoAspfMf+EzLRyiWjNuFvfs84A8Ft0CKZlLchCRF+EAvdl/6L5IQv5XLTkMJWLAh3ekhRZWjI6nTB05eCBBpZR7zlBlsyOLksywjH26iUeB+UIJLyTodf58=
Message-ID: <bde732200608072141g747bd814mb16b0a172738329d@mail.gmail.com>
Date: Tue, 8 Aug 2006 12:41:48 +0800
From: "cjacker huang" <cjacker@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH]Amoi laptop touchpad detection problem, should be in i8042 NOMUX blacklist.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I had test Red Flag Linux on an AMOI laptop(AMOI is PC
vendor in China), found that the alps touchpad on this laptop can not
be recognized automatically. after added the i8042.nomux to the kernel
options, the touchpad works.

So I made this patch, maybe somebody need this.

The VENDOR and PRODUCT_NAME is dumped from dmidecode.



--- linux-2.6.17.8.i686/drivers/input/serio/i8042-x86ia64io.h
2006-08-07 00:18:54.000000000 -0400
+++ linux-2.6.17.8.i686n/drivers/input/serio/i8042-x86ia64io.h
2006-08-08 00:09:50.882912192 -0400
@@ -180,6 +180,13 @@
            DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
        },
    },
+   {
+        .ident = "Amoi M636/A737",
+        .matches = {
+            DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
+            DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
+        },
+    },
    { }
 };
