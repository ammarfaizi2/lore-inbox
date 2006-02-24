Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWBXUSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWBXUSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBXUSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:18:06 -0500
Received: from gold.veritas.com ([143.127.12.110]:35922 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932458AbWBXUSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:18:04 -0500
X-IronPort-AV: i="4.02,144,1139212800"; 
   d="scan'208"; a="56119691:sNHT29219604"
Date: Fri, 24 Feb 2006 20:18:49 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>, Brent Casavant <bcasavan@sgi.com>,
       Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs: recommend remount for mpol
Message-ID: <Pine.LNX.4.61.0602242015490.4431@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Feb 2006 20:17:59.0724 (UTC) FILETIME=[6820AEC0:01C6397F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm points out that switching to a non-NUMA kernel could be irritating
if mounting tmpfs fails on an mpol option: tmpfs.txt recommend remount.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 Documentation/filesystems/tmpfs.txt |    9 +++++++++
 1 files changed, 9 insertions(+)

--- 2.6.16-rc4-git7/Documentation/filesystems/tmpfs.txt	2006-02-24 19:56:07.000000000 +0000
+++ linux/Documentation/filesystems/tmpfs.txt	2006-02-24 19:56:45.000000000 +0000
@@ -92,6 +92,15 @@ NodeList format is a comma-separated lis
 a range being two hyphen-separated decimal numbers, the smallest and
 largest node numbers in the range.  For example, mpol=bind:0-3,5,7,9-15
 
+Note that trying to mount a tmpfs with an mpol option will fail if the
+running kernel does not support NUMA; and will fail if its nodelist
+specifies a node >= MAX_NUMNODES.  If your system relies on that tmpfs
+being mounted, but from time to time runs a kernel built without NUMA
+capability (perhaps a safe recovery kernel), or configured to support
+fewer nodes, then it is advisable to omit the mpol option from automatic
+mount options.  It can be added later, when the tmpfs is already mounted
+on MountPoint, by 'mount -o remount,mpol=Policy:NodeList MountPoint'.
+
 
 To specify the initial root directory you can use the following mount
 options:
