Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTH2Jyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 05:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTH2Jye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 05:54:34 -0400
Received: from catv-50624ad9.szolcatv.broadband.hu ([80.98.74.217]:11919 "EHLO
	boszi-lnx.localdomain") by vger.kernel.org with ESMTP
	id S264498AbTH2Jya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 05:54:30 -0400
Message-ID: <3F4F22D3.9080104@freemail.hu>
Date: Fri, 29 Aug 2003 11:54:27 +0200
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm3
Content-Type: multipart/mixed;
 boundary="------------080701050009060506050705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701050009060506050705
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I tried to "make modules_install" on the compiled tree.
It says:

# make modules_install
Install a current version of module-init-tools
See http://www.codemonkey.org.uk/post-halloween-2.5.txt
make: *** [_modinst_] Error 1

But I have installed it! It's called modutils-2.4.25-8
(was -5 previously) from RH rawhide, it works on older
(2.6.0-test4-mm1) kernels.
This modutils is united with module-init-tools-0.9.12,
it reports version 2.4.25 but detects newer kernels and uses
the new module interface.

I looked the kernel Makefile and found that it greps the version
it gets from depmod -V and wants module-init-tools.
My fix against the rawhide modutils is attached.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

--------------080701050009060506050705
Content-Type: text/plain;
 name="modutils.spec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modutils.spec.diff"

--- modutils.spec.old	2003-08-29 11:43:10.000000000 +0200
+++ modutils.spec	2003-08-29 11:45:06.000000000 +0200
@@ -4,7 +4,7 @@
 Summary: Kernel module management utilities.
 Name: modutils
 Version: 2.4.25
-Release: 8
+Release: 8.1
 Copyright: GPL
 Group: System Environment/Kernel
 Source: ftp://ftp.kernel.org/pub/linux/utils/kernel/modutils/v2.4/modutils-%{version}.tar.bz2
@@ -23,6 +23,7 @@
 Patch13: module-init-tools-0.9.12-depmod-leak.patch
 Patch101: modutils-2.4.18-small.patch
 Patch1000: modutils-module-init-tools.patch
+Patch1001: module-init-tools-version-hack.patch
 Exclusiveos: Linux
 Prereq: /sbin/chkconfig sh-utils
 Obsoletes: modules
@@ -58,6 +59,7 @@
 %patch12 -p1 -b .updates
 ln -s module-init-tools-%{mitver} module-init-tools
 %patch13 -p1 -b .leak
+%patch1001 -p1 -b .version
 
 %build
 autoconf-2.13

--------------080701050009060506050705
Content-Type: text/plain;
 name="module-init-tools-version-hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-init-tools-version-hack.patch"

--- modutils-2.4.25/include/version.h.old	2003-08-29 11:41:54.000000000 +0200
+++ modutils-2.4.25/include/version.h	2003-08-29 11:41:54.000000000 +0200
@@ -1 +1 @@
-#define MODUTILS_VERSION "2.4.25"
+#define MODUTILS_VERSION "2.4.25 + module-init-tools-0.9.12 RedHat unified version"

--------------080701050009060506050705--

