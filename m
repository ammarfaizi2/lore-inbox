Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTDQS15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTDQS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:27:56 -0400
Received: from [12.47.58.203] ([12.47.58.203]:53436 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261866AbTDQS1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:27:53 -0400
Date: Thu, 17 Apr 2003 11:40:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Recent changes broke mkinitrd?
Message-Id: <20030417114016.6b7074f1.akpm@digeo.com>
In-Reply-To: <20030417111303.706d7246.shemminger@osdl.org>
References: <20030417111303.706d7246.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 18:39:39.0426 (UTC) FILETIME=[B403A820:01C30510]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:
>
> Recent (post 2.5.67) versions of the kernel break the creation
> of the initial ram disk.

hmm, so it did.  It'll be the ext2 changes.  mkinitrd works OK if you use
ext3:

--- mkinitrd.orig	2003-04-17 11:38:49.000000000 -0700
+++ mkinitrd	2003-04-17 11:39:01.000000000 -0700
@@ -473,7 +473,7 @@
 
 # We have to "echo y |" so that it doesn't complain about $IMAGE not
 # being a block device
-echo y | mke2fs $LODEV $IMAGESIZE >/dev/null 2>/dev/null
+echo y | mke2fs -j $LODEV $IMAGESIZE >/dev/null 2>/dev/null
 tune2fs -i0 $LODEV >/dev/null
 
 if [ -n "$verbose" ]; then
@@ -481,7 +481,7 @@
 fi
 
 mkdir -p $MNTPOINT
-mount -t ext2 $LODEV $MNTPOINT || {
+mount -t ext3 $LODEV $MNTPOINT || {
 	echo "Can't get a loopback device"
 	exit 1
 }

I'll take a look...
