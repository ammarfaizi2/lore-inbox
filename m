Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263621AbTDDLKI (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTDDLKG (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:10:06 -0500
Received: from 213-84-116-84.adsl.xs4all.nl ([213.84.116.84]:40792 "HELO
	213-84-116-84.adsl.xs4all.nl") by vger.kernel.org with SMTP
	id S263621AbTDDLFg (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 06:05:36 -0500
From: David Jander <david.jander@protonic.nl>
Organization: Protonic Holland
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ncpfs, kernel 2.4.18
Date: Fri, 4 Apr 2003 13:24:23 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ntWj+8X8fHDcYiT"
Message-Id: <200304041324.23882.david.jander@protonic.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ntWj+8X8fHDcYiT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


This fixes a bug with Novell Netware Servers (in my case 3.12) sending error 
messages (and annoying beeps) to the console each time a linux client 
accesses de root directory of a volume. Please comment !
Please send replies with CC to me, since I am not subscribed to lkml.

-- 
David Jander
Protonic Holland.
e-mail: david.jander@protonic.nl

--Boundary-00=_ntWj+8X8fHDcYiT
Content-Type: text/plain;
  charset="us-ascii";
  name="linux-2.4.18-ncpfix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4.18-ncpfix.patch"

--- linux-2.4.18/fs/ncpfs/ncplib_kernel.c	Fri Dec 21 18:41:55 2001
+++ linux-2.4.18-ncpfix/fs/ncpfs/ncplib_kernel.c	Fri Apr  4 13:12:03 2003
@@ -272,6 +272,12 @@
 	__u32 dirent = NCP_FINFO(dir)->dirEntNum;
 	int result;
 
+	DPRINTK("NCPFS : ncp_optain_info for: %s\n",path);
+	if(path==NULL)
+	{
+		printk(KERN_ERR "ncp_obtain_info: Invalid path %s!\n",path);
+		return -EINVAL;
+	}
 	if (target == NULL) {
 		printk(KERN_ERR "ncp_obtain_info: invalid call\n");
 		return -EINVAL;

--Boundary-00=_ntWj+8X8fHDcYiT--

