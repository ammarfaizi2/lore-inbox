Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbUJ1Oj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUJ1Oj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbUJ1Ohq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:37:46 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:26031 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261680AbUJ1Of4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:35:56 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, rusty@rustcorp.com.au, james4765@verizon.net
Message-Id: <20041028143555.2667.21190.14557@localhost.localdomain>
In-Reply-To: <20041028143548.2667.72439.46892@localhost.localdomain>
References: <20041028143548.2667.72439.46892@localhost.localdomain>
Subject: [PATCH 2/2] to Documentation/mkdev.ida
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 09:35:55 -0500
Date: Thu, 28 Oct 2004 09:35:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This file is no longer reqired - the MAKEDEV program makes the ida/ nodes automatically.

Apply against 2.6.9.

Description: To remove an obsolete script from the Documentation directory.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/mkdev.ida linux-2.6.9/Documentation/mkdev.ida
--- linux-2.6.9-original/Documentation/mkdev.ida	2004-10-18 17:53:44.000000000 -0400
+++ linux-2.6.9/Documentation/mkdev.ida	1969-12-31 19:00:00.000000000 -0500
@@ -1,40 +0,0 @@
-#!/bin/sh
-# Script to create device nodes for SMART array controllers
-# Usage:
-#	mkdev.ida [num controllers] [num log volumes] [num partitions]
-#
-# With no arguments, the script assumes 1 controller, 16 logical volumes,
-# and 16 partitions/volume, which is adequate for most configurations.
-#
-# If you had 5 controllers and were planning on no more than 4 logical volumes
-# each, using a maximum of 8 partitions per volume, you could say:
-#
-# mkdev.ida 5 4 8
-#
-# Of course, this has no real benefit over "mkdev.ida 5" except that it
-# doesn't create so many device nodes in /dev/ida.
-
-NR_CTLR=${1-1}
-NR_VOL=${2-16}
-NR_PART=${3-16}
-
-if [ ! -d /dev/ida ]; then
-	mkdir -p /dev/ida
-fi
-
-C=0; while [ $C -lt $NR_CTLR ]; do
-	MAJ=`expr $C + 72`
-	D=0; while [ $D -lt $NR_VOL ]; do
-		P=0; while [ $P -lt $NR_PART ]; do
-			MIN=`expr $D \* 16 + $P`
-			if [ $P -eq 0 ]; then
-				mknod /dev/ida/c${C}d${D} b $MAJ $MIN
-			else
-				mknod /dev/ida/c${C}d${D}p${P} b $MAJ $MIN
-			fi
-			P=`expr $P + 1`
-		done
-		D=`expr $D + 1`
-	done
-	C=`expr $C + 1`
-done
