Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272129AbTGYOdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272131AbTGYOdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:33:32 -0400
Received: from monarch.prairienet.org ([192.17.3.5]:32743 "HELO
	mail.prairienet.org") by vger.kernel.org with SMTP id S272129AbTGYOd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:33:29 -0400
Message-ID: <3F2142CE.4090608@prairienet.org>
Date: Fri, 25 Jul 2003 10:46:38 -0400
From: John Belmonte <jvb@prairienet.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: "Ben Collins" <bcollins@debian.org>, "Linus Torvalds" <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       "Michael Wawrzyniak" <gan@planetlaz.com>
Subject: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please revert the following item from Ben Collins' "drivers/* strlcpy 
conversions" patch dated 2003-May-26.

The strlcpy function requires a zero-terminated string, which is not a 
valid assumption for the code in question.  I suggest that Ben review 
all such modifications he made to the kernel for similar errors.  It's 
quite annoying to have someone add bugs to your driver while you're not 
looking.  Either notify the maintainer of your patch or don't make mistakes.

Another gripe I have is that bitkeeper user "bcollins" does not have a 
valid email address.

-John Belmonte


Item to be REVERTED:

--- 1.9/drivers/acpi/toshiba_acpi.c	Mon May 19 10:57:16 2003
+++ 1.10/drivers/acpi/toshiba_acpi.c	Sun May 25 17:00:00 2003
@@ -108,8 +108,7 @@
  	int result;
  	char* str2 = kmalloc(n + 1, GFP_KERNEL);
  	if (str2 == 0) return 0;
-	strncpy(str2, str, n);
-	str2[n] = 0;
+	strlcpy(str2, str, n);
  	va_start(args, format);
  	result = vsscanf(str2, format, args);
  	va_end(args);


References:

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/0267.html
http://linux-acpi.bkbits.net:8080/linux-acpi/diffs/drivers/acpi/toshiba_acpi.c@1.10?nav=index.html|src/|src/drivers|src/drivers/acpi|hist/drivers/acpi/toshiba_acpi.c


-- 
http:// if   l .o  /

