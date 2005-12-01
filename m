Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVLAX1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVLAX1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 18:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVLAX1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 18:27:41 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:21553 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932562AbVLAX1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 18:27:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Hslt63mZT7t9gNNl0K4EWGIezklwucflWm1H7y85a3VUwRq6RolHB5Wv4GUS8m5nSMnfnigvoEjgBxqoYGANKuJH3OSaP6QuA2MNeGW/HL16wx3xclYnO6vO++NYSqrfEcS1tKZwPcDwBMjvHy0zr+0y8Cx464y/wPtg62uaqDo=
Message-ID: <a762e240512011527s69053b8eg13ec4674c3e36b07@mail.gmail.com>
Date: Thu, 1 Dec 2005 15:27:40 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Bharath Ramesh <krosswindz@gmail.com>
Subject: Re: Only one processor detected in 8-Way opteron in 32-bit mode
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_18719_26783564.1133479660137"
References: <c775eb9b0512011315y40bdbf30w172583cd85e92fa6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_18719_26783564.1133479660137
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Looks like something odd is going on with your processor apic id's.

Lines like
Processor #20 INVALID. (Max ID: 256)
are bad...

Could you try the following patch with i386?  It seems suspect to me
and could help identify the problem.

Your box has high processor apic ids and looks to be in flat apic mode
(versus clustered).  I think the code is assuming the box is in
clustered apic mode?

Thanks,
Keith

------=_Part_18719_26783564.1133479660137
Content-Type: application/octet-stream; name=apicid.fix
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="apicid.fix"

--- arch/i386/kernel/mpparse.c.orig	2005-12-01 15:20:51.000000000 -0800
+++ arch/i386/kernel/mpparse.c	2005-12-01 15:21:19.000000000 -0800
@@ -112,9 +112,10 @@
 #else
 static int MP_valid_apicid(int apicid, int version)
 {
-	if (version >= 0x14)
+/*	if (version >= 0x14)
 		return apicid < 0xff;
 	else
+*/
 		return apicid < 0xf;
 }
 #endif



------=_Part_18719_26783564.1133479660137--
