Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTEVJtX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTEVJtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:49:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:49323 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262656AbTEVJtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:49:21 -0400
Date: Thu, 22 May 2003 19:02:43 +0900 (JST)
Message-Id: <20030522.190243.36013922.yoshfuji@linux-ipv6.org>
To: kde@myrealbox.com
Cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: bk15 build fails with modular apm (undefined reference to
 MODULE_OWNER)
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1053592419.b2fa6d60kde@myrealbox.com>
References: <1053592419.b2fa6d60kde@myrealbox.com>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 90 22 65 EB 1E CF 3A D1 0B DF 80 D8 48 07 F8 94 E0 62 0E EA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1053592419.b2fa6d60kde@myrealbox.com> (at Thu, 22 May 2003 02:33:39 -0600), "ismail donmez" <kde@myrealbox.com> says:

> Adding 
> #define SET_MODULE_OWNER(apm_proc) do { } while (0) 
> to arch/i386/kernel/apm.c fixes this.

:

> > arch/i386/kernel/built-in.o(.init.text+0x5744): In function `apm_init':
> > : undefined reference to `SET_MODULE_OWNER'
> > make: *** [.tmp_vmlinux1] Error 1
> > :
> > 
> > Is SET_MODULE_OWNER needed or not?

I believe we should set apm_proc->owner here.

Index: linux25-LINUS/arch/i386/kernel/apm.c
===================================================================
RCS file: /cvsroot/usagi/usagi-backport/linux25/arch/i386/kernel/apm.c,v
retrieving revision 1.1.1.12
diff -u -r1.1.1.12 apm.c
--- linux25-LINUS/arch/i386/kernel/apm.c	15 May 2003 07:52:06 -0000	1.1.1.12
+++ linux25-LINUS/arch/i386/kernel/apm.c	22 May 2003 09:22:04 -0000
@@ -2013,7 +2013,7 @@
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
-		SET_MODULE_OWNER(apm_proc);
+		apm_proc->owner = THIS_MODULE;
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 

-- 
Hideaki YOSHIFUJI @ USAGI Project <yoshfuji@linux-ipv6.org>
GPG FP: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
