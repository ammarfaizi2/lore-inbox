Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVJaOiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVJaOiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVJaOiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:38:52 -0500
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:50097 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932280AbVJaOiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:38:51 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:38:48 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 14/17] NTFS: Fix serious data corruption issue when writing.
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311438160.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix serious data corruption issue when writing.
      Many thanks to Alberto Patino for testing and reporting the data
      corruption.  And many apologies for corrupting his partition.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 66bd4d6307a81ae65a01acace5fd8ae6f5a30032
d5aeaef37dc9cb009ab5cb8abf325338d21d2b1a
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 5fb341a..a142bf3 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -787,6 +787,7 @@ retry_remap:
 				vcn_len = rl[1].vcn - vcn;
 				lcn_block = lcn << (vol->cluster_size_bits -
 						blocksize_bits);
+				cdelta = 0;
 				/*
 				 * If the number of remaining clusters in the
 				 * @pages is smaller or equal to the number of
---
0.99.9
