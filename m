Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbTENANd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTENANd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:13:33 -0400
Received: from mxzilla1.xs4all.nl ([194.109.6.54]:8968 "EHLO
	mxzilla1.xs4all.nl") by vger.kernel.org with ESMTP id S263742AbTENANb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:13:31 -0400
Date: Wed, 14 May 2003 02:26:18 +0200
From: dvorak <dvorak@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc2 and rc1 compile problem in fs/exec.c + PATCH
Message-ID: <20030514002618.GA3745@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

while compiling a 2.4.21-rc2 kernel i noticed the following
compile problem:

exec.c: In function `format_corename':
exec.c:1084: `uts_sem' undeclared (first use in this function)
exec.c:1084: (Each undeclared identifier is reported only once
exec.c:1084: for each function it appears in.)
exec.c:1086: `system_utsname' undeclared (first use in this function)

reverting back to 2.4.21-rc1 shows the same problem, solution
seems to add #include <linux/utsname.h> to the list of included
files in fs/exec.c couldn't find anything in the mailing lists
(searched for uts_sem at theaimsgroup) hope this patch helps,

gtx.
  dvorak

P.S. i am not subscribed but i'll follow the archives the coming
time, Cc if possible.


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rc2-exec-patch.diff"

--- fs/exec.c.orig	2003-05-14 02:23:56.000000000 +0200
+++ fs/exec.c	2003-05-14 02:26:09.000000000 +0200
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/utsname.h>
 #define __NO_VERSION__
 #include <linux/module.h>
 

--45Z9DzgjV8m4Oswq--
