Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287582AbSAEHys>; Sat, 5 Jan 2002 02:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287595AbSAEHyj>; Sat, 5 Jan 2002 02:54:39 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:28380 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S287593AbSAEHyb>; Sat, 5 Jan 2002 02:54:31 -0500
Date: Fri, 4 Jan 2002 23:54:26 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: kkeil@suse.de, linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de,
        torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre8/drivers/isdn/sc/commands.c bug exposed by kdev_t changes
Message-ID: <20020104235426.A17712@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


	The kdev_t changes have exposed an amusing bug in
linux-2.5.2-pre8/drivers/isdn/sc/command.c.  A routine that
was intended to return the error "-ENODEV" was actually
returning "-NODEV" (prevously zero, now a compilation error).
Here is the fix.

	I have already checked to see that '-NODEV' and '- NODEV' do
not appear anywhere else in the kernel sources.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sc.diff"

--- linux-2.5.2-pre8/drivers/isdn/sc/command.c	Sun Sep 30 12:26:06 2001
+++ linux/drivers/isdn/sc/command.c	Fri Jan  4 23:47:36 2002
@@ -95,7 +95,7 @@
 		if(adapter[i]->driverId == driver)
 			return i;
 	}
-	return -NODEV;
+	return -ENODEV;
 }
 
 /* 

--ReaqsoxgOBHFXBhH--
