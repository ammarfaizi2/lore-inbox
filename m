Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313280AbSC1WzW>; Thu, 28 Mar 2002 17:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313278AbSC1WzM>; Thu, 28 Mar 2002 17:55:12 -0500
Received: from gear.torque.net ([204.138.244.1]:50697 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S313277AbSC1WzF>;
	Thu, 28 Mar 2002 17:55:05 -0500
Message-ID: <3CA39FAB.C1D2034D@torque.net>
Date: Thu, 28 Mar 2002 17:56:43 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.7-dj2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.7-dj2
Content-Type: multipart/mixed;
 boundary="------------F8F9DAE8D8A7A23F0287236C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F8F9DAE8D8A7A23F0287236C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

For anyone having compile problems with kernel/acct.c
then the attachment fixed it for me (at least I running
2.5.7-dj2 now).

This system is Athlon based with a dc-390u3w and an
advansys scsi controller. "dj1" has been quite stable
for the last week and "dj2" is looking ok so far.
My IntelliMouse (PS/2) wheel still scrolls backwards.

Doug Gilbert
--------------F8F9DAE8D8A7A23F0287236C
Content-Type: text/plain; charset=us-ascii;
 name="acct257dj2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acct257dj2.diff"

--- linux/kernel/acct.c257dj2	Wed Mar 27 23:52:37 2002
+++ linux/kernel/acct.c	Thu Mar 28 17:04:49 2002
@@ -232,6 +232,7 @@
  * If the accouting is turned on for a file in the filesystem pointed
  * to by sb, turn accouting off.
  */
+#ifdef CONFIG_BSD_PROCESS_ACCT
 void acct_auto_close(struct super_block *sb)
 {
 	spin_lock(&acct_globals.lock);
@@ -241,6 +242,7 @@
 	}
 	spin_unlock(&acct_globals.lock);
 }
+#endif
 
 /*
  *  encode an unsigned long into a comp_t
@@ -375,6 +377,7 @@
 /*
  * acct_process - now just a wrapper around do_acct_process
  */
+#ifdef CONFIG_BSD_PROCESS_ACCT
 int acct_process(long exitcode)
 {
 	struct file *file = NULL;
@@ -389,3 +392,4 @@
 		spin_unlock(&acct_globals.lock);
 	return 0;
 }
+#endif

--------------F8F9DAE8D8A7A23F0287236C--

