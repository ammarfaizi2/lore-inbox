Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVC2QbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVC2QbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVC2QbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:31:09 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:62040 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261199AbVC2QbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:31:00 -0500
Message-ID: <424982C0.5000708@mesatop.com>
Date: Tue, 29 Mar 2005 09:30:56 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.6.12-rc1-mm3 Fix ver_linux script for no udev utils.
Content-Type: multipart/mixed;
 boundary="------------070907050505090807010102"
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070907050505090807010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Without the attached patch, the ver_linux script gives
the following if udev utils are not present.

./scripts/ver_linux: line 90: udevinfo: command not found

The patch causes ver_linux to be silent in the case of
no udevinfo command.

Steven
TSPA (Technical data or Software Publicly Available)





--------------070907050505090807010102
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="fix_ver_linux_for_no_udev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_ver_linux_for_no_udev.patch"

Signed-off-by: Steven Cole <elenstev@mesatop.com>

--- linux-2.6.12-rc1-mm3/scripts/ver_linux.orig	2005-03-29 08:52:35.000000000 -0700
+++ linux-2.6.12-rc1-mm3/scripts/ver_linux	2005-03-29 09:04:37.000000000 -0700
@@ -87,7 +87,7 @@
 
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
 
-udevinfo -V | awk '{print "udev                  ", $3}'
+udevinfo -V 2>&1 | grep version | awk '{print "udev                  ", $3}'
 
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`

--------------070907050505090807010102--
