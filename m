Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbUCEJHw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCEJHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:07:52 -0500
Received: from mailint.compaq.com ([161.114.1.206]:2575 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262271AbUCEJHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:07:07 -0500
Message-ID: <404843B5.1010409@toughguy.net>
Date: Fri, 05 Mar 2004 14:39:09 +0530
From: Raj <obelix123@toughguy.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: okir@monad.swb.de
Subject: [TRIVIAL][PATCH]:/proc/fs/nfsd/
Content-Type: multipart/mixed;
 boundary="------------090509050709070802080901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090509050709070802080901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Kernel Version: 2.6.3
Even if NFSD is not selected, the proc entry /proc/fs/nfsd is getting 
created.

The following patch fixes it.

Pls apply.

/Raj

--------------090509050709070802080901
Content-Type: text/plain;
 name="nfsd-proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nfsd-proc.patch"

--- linux-2.6.3/fs/proc/root.c	2004-02-19 09:52:32.000000000 +0530
+++ linux-2.6.3-fixed/fs/proc/root.c	2004-03-05 13:48:28.448516568 +0530
@@ -65,7 +65,11 @@ void __init proc_root_init(void)
 #endif
 	proc_root_fs = proc_mkdir("fs", 0);
 	proc_root_driver = proc_mkdir("driver", 0);
+
+#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
 	proc_mkdir("fs/nfsd", 0); /* somewhere for the nfsd filesystem to be mounted */
+#endif
+
 #if defined(CONFIG_SUN_OPENPROMFS) || defined(CONFIG_SUN_OPENPROMFS_MODULE)
 	/* just give it a mountpoint */
 	proc_mkdir("openprom", 0);

--------------090509050709070802080901--

