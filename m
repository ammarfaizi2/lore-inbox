Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289239AbSBSBov>; Mon, 18 Feb 2002 20:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289234AbSBSBol>; Mon, 18 Feb 2002 20:44:41 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:21267 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289210AbSBSBoi>;
	Mon, 18 Feb 2002 20:44:38 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15473.44458.756040.513997@argo.ozlabs.ibm.com>
Date: Tue, 19 Feb 2002 12:43:06 +1100 (EST)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
        trini@kernel.crashing.org
Subject: Re: Linux 2.4.18-rc2
In-Reply-To: <Pine.LNX.4.21.0202181815480.25479-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0202181815480.25479-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

> Well hopefully have a 2.4.18 pretty soon..

The fix to drivers/sound/dmasound/tas3001c.c, to export
tumbler_enter_sleep and tumbler_leave_sleep, is still not included.
Could we have that one in before 2.4.18 final is released, please?
Otherwise compiling a kernel for a powermac will fail.

Regards,
Paul.

diff -urN linux-2.4.18-rc2/drivers/sound/dmasound/tas3001c.c pmac/drivers/sound/dmasound/tas3001c.c
--- linux-2.4.18-rc2/drivers/sound/dmasound/tas3001c.c	Tue Feb 19 12:37:37 2002
+++ pmac/drivers/sound/dmasound/tas3001c.c	Thu Jan 24 15:12:10 2002
@@ -67,8 +67,8 @@
 
 static struct i2c_client * tumbler_client = NULL;
 
-static int tumbler_enter_sleep(void);
-static int tumbler_leave_sleep(void);
+int tumbler_enter_sleep(void);
+int tumbler_leave_sleep(void);
 
 static int tas_attach_adapter(struct i2c_adapter *adapter);
 static int tas_detect_client(struct i2c_adapter *adapter, int address);
@@ -298,7 +298,7 @@
 	return 0;
 }
 
-static int
+int
 tumbler_leave_sleep(void)
 {
 	/* Stub for now, but I have the details on low-power mode */
@@ -308,7 +308,7 @@
 	return 0;
 }
 
-static int
+int
 tumbler_enter_sleep(void)
 {
 	/* Stub for now, but I have the details on low-power mode */
