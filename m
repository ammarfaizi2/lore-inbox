Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVCUI5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVCUI5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 03:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVCUI5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 03:57:32 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:37969 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261701AbVCUI5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 03:57:25 -0500
Message-ID: <423E8C78.5040405@yahoo.com>
Date: Mon, 21 Mar 2005 03:57:28 -0500
From: Daniel Dickman <didickman@yahoo.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about build.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64 checks if we're building a big kernel to make sure that it's <= 4MB. Should we be doing something similar for i386? Or perhaps we shouldn't be 
imposing this limit on x86_64?

Below is the relevant code diff that I'm asking about.

Thanks,
Daniel

--- linux-2.6.12-rc1-bk1/arch/i386/boot/tools/build.c   2005-03-02 02:38:09.000000000 -0500
+++ linux-2.6.12-rc1-bk1/arch/x86_64/boot/tools/build.c 2005-03-02 02:38:37.000000000 -0500
@@ -150,8 +150,10 @@
         sz = sb.st_size;
         fprintf (stderr, "System is %d kB\n", sz/1024);
         sys_size = (sz + 15) / 16;
-       if (!is_big_kernel && sys_size > DEF_SYSSIZE)
-               die("System is too big. Try using bzImage or modules.");
+       /* 0x40000*16 = 4.0 MB, reasonable estimate for the current maximum */
+       if (sys_size > (is_big_kernel ? 0x40000 : DEF_SYSSIZE))
+               die("System is too big. Try using %smodules.",
+                       is_big_kernel ? "" : "bzImage or ");
         while (sz > 0) {
                 int l, n;

