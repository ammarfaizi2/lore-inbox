Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbVCCVT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbVCCVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVCCVTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:19:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:28152 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262585AbVCCVRV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:17:21 -0500
Date: Thu, 3 Mar 2005 16:16:41 -0500
From: "George G. Davis" <gdavis@mvista.com>
To: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix scripts/mkuboot.sh to return status
Message-ID: <20050303211640.GB20870@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

If `mkimage` is either not found in search path or returns non-zero status,
`make uImage` succeeds when it should fail. This changes scripts/mkuboot.sh
to return status so build succeeds or fails as appropriate.

Source: MontaVista Software, Inc.
MR: 10761
Type: Defect Fix
Disposition: submitted to linux-kernel@vger.kernel.org
Keywords:
Description:
Fix scripts/mkuboot.sh to return non-zero status to indicate
build failure when uImage target is not created.

Signed-off-by: George G. Davis <gdavis@mvista.com>

Index: linux-2.6.11-bk/scripts/mkuboot.sh
===================================================================
--- linux-2.6.11-bk.orig/scripts/mkuboot.sh
+++ linux-2.6.11-bk/scripts/mkuboot.sh
@@ -9,8 +9,10 @@
 if [ -z "${MKIMAGE}" ]; then
 	# Doesn't exist
 	echo '"mkimage" command not found - U-Boot images will not be built' >&2
-	exit 0;
+	exit -1
 fi
 
 # Call "mkimage" to create U-Boot image
 ${MKIMAGE} "$@"
+
+exit $?

--
Regards,
George
