Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLEXjZ>; Tue, 5 Dec 2000 18:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLEXjP>; Tue, 5 Dec 2000 18:39:15 -0500
Received: from cr630205-a.crdva1.bc.wave.home.com ([24.113.89.232]:6139 "EHLO
	ryan") by vger.kernel.org with ESMTP id <S129183AbQLEXjD>;
	Tue, 5 Dec 2000 18:39:03 -0500
Message-ID: <3A2D7505.2BB48C48@javien.com>
Date: Tue, 05 Dec 2000 15:06:45 -0800
From: ryan <ryan@javien.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Change of /proc/cpuinfo format
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There was a minor change to the format of /proc/cpuinfo which hoses
several programs.  Most notably is vmware. 

The details are the field formerly known as 'flags' is now known as
'features' which breaks any programs attempting to parse /proc/cpuinfo
and making decisions about what feature set the cpu supports.  

I'm not quite sure why the name change is necessary, and even if one
wants to keep the name change there is a discontunity of cpuinfo formats
and programs which intend to run on kernels 2.2 and 2.4 needs to know
this...

Here is a small patch to save your typing fingers:
--- setup.c.old	Tue Dec  5 15:01:21 2000
+++ setup.c	Tue Dec  5 14:53:52 2000
@@ -2131,7 +2131,7 @@
 			        "fpu_exception\t: %s\n"
 			        "cpuid level\t: %d\n"
 			        "wp\t\t: %s\n"
-			        "features\t:",
+			        "flags\t:",
 			     c->fdiv_bug ? "yes" : "no",
 			     c->hlt_works_ok ? "no" : "yes",
 			     c->f00f_bug ? "yes" : "no",


in linux/arch/i386/kernel

-ryan

--
Ryan Rawson 
Software Designer
ryan@javien.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
