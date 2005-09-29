Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVI2Tdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVI2Tdh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVI2Td2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:33:28 -0400
Received: from ppp-62-11-74-97.dialup.tiscali.it ([62.11.74.97]:53917 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S964793AbVI2TdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:33:01 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Fix dm-snapshot tutorial in Documentation
Date: Thu, 29 Sep 2005 20:42:43 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050929184243.12900.47864.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

I've recently added this documentation, Alasdair gave some corrections, and here
are some further corrections on top of his work (partly style issue, partly a
technical error due to different past experience, partly a note which I've
added - i.e. transient snapshots are lighter).

Cc: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 Documentation/device-mapper/snapshot.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/device-mapper/snapshot.txt b/Documentation/device-mapper/snapshot.txt
--- a/Documentation/device-mapper/snapshot.txt
+++ b/Documentation/device-mapper/snapshot.txt
@@ -19,7 +19,6 @@ There are two dm targets available: snap
 *) snapshot-origin <origin>
 
 which will normally have one or more snapshots based on it.
-You must create the snapshot-origin device before you can create snapshots.
 Reads will be mapped directly to the backing device. For each write, the
 original data will be saved in the <COW device> of each snapshot to keep
 its visible content unchanged, at least until the <COW device> fills up.
@@ -27,7 +26,7 @@ its visible content unchanged, at least 
 
 *) snapshot <origin> <COW device> <persistent?> <chunksize>
 
-A snapshot is created of the <origin> block device. Changed chunks of
+A snapshot of the <origin> block device is created. Changed chunks of
 <chunksize> sectors will be stored on the <COW device>.  Writes will
 only go to the <COW device>.  Reads will come from the <COW device> or
 from <origin> for unchanged data.  <COW device> will often be
@@ -37,6 +36,8 @@ the amount of free space and expand the 
 
 <persistent?> is P (Persistent) or N (Not persistent - will not survive
 after reboot).
+The difference is that for transient snapshots less metadata must be
+saved on disk - they can be kept in memory by the kernel.
 
 
 How this is used by LVM2

