Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSLQKg7>; Tue, 17 Dec 2002 05:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbSLQKg7>; Tue, 17 Dec 2002 05:36:59 -0500
Received: from mail.hometree.net ([212.34.181.120]:47790 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S264903AbSLQKg6>; Tue, 17 Dec 2002 05:36:58 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [PATCH] fix for RPM build target under newer versions
Date: Tue, 17 Dec 2002 10:44:54 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <atmv76$20o$1@forge.intermeta.de>
References: <3DFEFF01.7040304@wnyip.net>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1040121894 10464 212.34.181.4 (17 Dec 2002 10:44:54 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 17 Dec 2002 10:44:54 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

peter <pvant67@wnyip.net> writes:

>--- /usr/src/linux-2.4.19/Makefile	2002-12-15 19:04:20.000000000 -0500
>+++ /home/pete/Makefile.new	2002-12-17 04:36:49.000000000 -0500
>@@ -567,5 +567,16 @@
> 	rm $(KERNELPATH) ; \
> 	cd $(TOPDIR) ; \
> 	. scripts/mkversion > .version ; \
>-	rpmbuild -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
>+
>+#	RedHat split the RPM build process into a separate
>+#	utility called "rpmbuild", leading to a broken 
>+#	"make rpm" target in the kernel Makefile;
>+#	this patch fixes that.
>+
>+	if [ `rpm --version | cut -b 12-15 | tr -d .` -ge '41' ] ;
>+		then
>+		rpmbuild -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \ 
>+		else
>+		rpm -ta $(TOPDIR)/../$(KERNELPATH).tar.gz ; \
>+	fi ; \

Ugh. How about

--- cut ---
RPM=`which rpmbuild`
if [ -z "$RPM" ]; then
  RPM=rpm
fi
$RPM -ta $(TOPDIR)/../$(KERNELPATH).tar.gz
--- cut ---

Looks less fragile. On RH 7.3 (and RH 6.x with upgrades) you also have
a rpmbuild binary (but rpm still does building, this got deprecated
and later removed on 8.0).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
