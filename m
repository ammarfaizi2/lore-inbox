Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSJKNum>; Fri, 11 Oct 2002 09:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSJKNum>; Fri, 11 Oct 2002 09:50:42 -0400
Received: from mx.creditonline.it ([62.110.207.178]:34066 "EHLO
	mx.creditonline.it") by vger.kernel.org with ESMTP
	id <S262452AbSJKNul>; Fri, 11 Oct 2002 09:50:41 -0400
Message-ID: <3DA6D88A.C5A16AEF@tiscalinet.it>
Date: Fri, 11 Oct 2002 15:56:26 +0200
From: Domenico Rotiroti <drotiro@tiscalinet.it>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Subject: PATCH unusual device: nec usb floppy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
with my compaq notebook I got an usb floppy (nec).
It works fine with usb-storage driver, but with all the
2.4 kernel I compiled it was found 8 times (LUNs 0 through 7)
as sda..sdh
Adding it to the list of unusual devices with the "SINGLE_LUN"
flag solves the problem.

Here's a small patch that do this:

--- unusual_devs.h_orig Fri Oct 11 13:05:38 2002
+++ unusual_devs.h Fri Oct 11 13:07:42 2002
@@ -65,6 +65,14 @@
   US_SC_8070, US_PR_SCM_ATAPI, init_8200e, 0),
 #endif

+/* Submitted by Domenico Rotiroti <drotiro@tiscali.it>
+ * This device needs the SINGLE_LUN flag */
+UNUSUAL_DEV(  0x0409, 0x0040, 0x0000, 0x9999,
+  "NEC",
+  "NEC USB UF000x",
+  US_SC_UFI, US_PR_CBI, NULL,
+  US_FL_SINGLE_LUN),
+
 #ifdef CONFIG_USB_STORAGE_DPCM
 UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
   "Microtech",


