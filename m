Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264877AbUE0Qkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbUE0Qkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUE0Qkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 12:40:46 -0400
Received: from fmr12.intel.com ([134.134.136.15]:30189 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264877AbUE0Qko convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 12:40:44 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: idebus setup problem (2.6.7-rc1)
Date: Fri, 28 May 2004 00:38:08 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F842DB1E2@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: idebus setup problem (2.6.7-rc1)
Thread-Index: AcREAkZsEHP8WnQVRZqxb+9Wq1pZ/gAAoQOgAADQHsA=
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Auzanneau Gregory" <mls@reolight.net>,
       "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>
X-OriginalArrivalTime: 27 May 2004 16:38:08.0501 (UTC) FILETIME=[FDFF4A50:01C44408]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel-owner@vger.kernel.org wrote:
> Bartlomiej Zolnierkiewicz wrote:
>> 
>> It breaks all "idex=" and "hdx=" options.
>> Please take a look at how ide_setup().
> 
> Yes, thanks for pointing out. Maybe we need some wildcard
> support. If module_param() can do this, that's great.

Does below change acceptable to make module_param support 
wildcard '?' ?

--- linux-2.6.6.orig/kernel/params.c        2004-05-28
00:13:24.931368296 +0800
+++ linux-2.6.6/kernel/params.c     2004-05-28 00:16:04.406124448 +0800
@@ -37,7 +37,8 @@ static inline int dash2underscore(char c
 static inline int parameq(const char *input, const char *paramname)
 {
        unsigned int i;
-       for (i = 0; dash2underscore(input[i]) == paramname[i]; i++)
+       for (i = 0; paramname[i] == '?' ||
+            dash2underscore(input[i]) == paramname[i]; i++)
                if (input[i] == '\0')
                        return 1;
        return 0;


