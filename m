Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272899AbRIPWqu>; Sun, 16 Sep 2001 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272898AbRIPWqj>; Sun, 16 Sep 2001 18:46:39 -0400
Received: from alb-66-24-179-104.nycap.rr.com ([66.24.179.104]:12036 "EHLO
	incandescent") by vger.kernel.org with ESMTP id <S272899AbRIPWqb>;
	Sun, 16 Sep 2001 18:46:31 -0400
Date: Sun, 16 Sep 2001 18:46:51 -0400
From: Andres Salomon <saloma@rpi.edu>
To: linux-kernel@vger.kernel.org
Subject: [patch] 3c515 warnings
Message-ID: <20010916184651.A703@mp3revolution.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux incandescent 2.4.10-pre9 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm not sure what happened to the full_duplex variable in 3c515.c, but
it was ignored by the driver anyways.  The attached patch removes the
MODULE_PARM references to the variable (which would cause a warning
to be spewed when you tried to modprobe the driver).  Diff'd against
2.4.10-pre9, please apply.

BTW, does anyone actually use this driver?  I'm cleaning it up a bit,
and possibly (if I have the time) syncing w/ becker's latest; 
if anyone's interested in testing it out, let me know.

-- 
"Any OS is only as good as its admin, and you obviously suck."
	-- Ian Gulliver, http://orbz.org/mail/mansunix.txt

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="duplex_arg.diff"

--- linux/drivers/net/3c515.c	Sun Sep 16 00:11:42 2001
+++ linux.dilinger/drivers/net/3c515.c	Sun Sep 16 12:49:56 2001
@@ -84,12 +84,10 @@
 MODULE_DESCRIPTION("3Com 3c515 Corkscrew driver");
 MODULE_PARM(debug, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(8) "i");
-MODULE_PARM(full_duplex, "1-" __MODULE_STRING(8) "i");
 MODULE_PARM(rx_copybreak, "i");
 MODULE_PARM(max_interrupt_work, "i");
 MODULE_PARM_DESC(debug, "3c515 debug level (0-6)");
 MODULE_PARM_DESC(options, "3c515: Bits 0-2: media type, bit 3: full duplex, bit 4: bus mastering");
-MODULE_PARM_DESC(full_duplex, "(ignored)");
 MODULE_PARM_DESC(rx_copybreak, "3c515 copy breakpoint for copy-only-tiny-frames");
 MODULE_PARM_DESC(max_interrupt_work, "3c515 maximum events handled per interrupt");
 

--C7zPtVaVf+AK4Oqc--
