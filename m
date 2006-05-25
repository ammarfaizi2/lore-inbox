Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWEYEOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWEYEOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWEYEOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:14:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:12527 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964963AbWEYEOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:14:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:x-google-sender-auth;
        b=FNLEzC7NHKXsaohJdXiXOKINio1hybfn52qIPaNauOCY/UnNKKm9bHW2mKgD/3g/5tVfgKEJQf4SghHi7r8MgYY6YeTpSZh7w8plLwfVJxx8zRgIuPnTw1KQiRMTgjowVJa+GStQBJ6ho2vmvsZOP+IvgWtnR85I7GnsROB5dGE=
Message-ID: <ed5aea430605242114g1e51e7e9nb124de50dbbf1e40@mail.gmail.com>
Date: Wed, 24 May 2006 22:14:13 -0600
From: "David Mosberger-Tang" <David.Mosberger@acm.org>
To: "Andrew Morton" <akpm@osdl.org>,
       "linux kernel" <linux-kernel@vger.kernel.org>
Subject: trivial videodev2.h patch
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22851_31516820.1148530453737"
X-Google-Sender-Auth: 35b201e54f5ba2dd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_22851_31516820.1148530453737
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andrew,

linux/videodev2.h uses types such as __u8 but it fails to include
<linux/types.h>.  Within the kernel, that's not a problem because
<linux/time.h> already includes <linux/types.h>.  However, there are
user apps that try to include videodev2.h (e.g., ekiga) and at least
on ia64, it causes compilation failures since <linux/types.h> doesn't
get included for any other reason, leaving __u8 etc. undefined.  The
attached patch fixes the problem for me.

Thanks,

  --david
-- 
Mosberger Consulting LLC, http://www.mosberger-consulting.com/

------=_Part_22851_31516820.1148530453737
Content-Type: text/x-patch; name=videodev2.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enmlcpru
Content-Disposition: attachment; filename="videodev2.diff"

diff --git a/include/linux/videodev2.h b/include/linux/videodev2.h
--- a/include/linux/videodev2.h
+++ b/include/linux/videodev2.h
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 #endif
+#include <linux/types.h>
 #include <linux/compiler.h> /* need __user */
 
 

------=_Part_22851_31516820.1148530453737--
