Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945945AbWBCUWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbWBCUWH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945948AbWBCUWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:22:07 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:28579 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1945945AbWBCUWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:22:05 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Phillip Susi <psusi@cfl.rr.com>
Subject: [PATCH 5/5] pktcdvd: Allow larger packets
References: <m3bqxoci5g.fsf@telia.com> <m37j8cci2r.fsf@telia.com>
	<m33bj0ci0b.fsf_-_@telia.com> <m3y80sb3dy.fsf_-_@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Feb 2006 21:21:55 +0100
In-Reply-To: <m3y80sb3dy.fsf_-_@telia.com>
Message-ID: <m3u0bgb3bw.fsf_-_@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phillip Susi <psusi@cfl.rr.com>

The pktcdvd driver uses a compile time macro constant to define the
maximum supported packet length.  I changed this from 32 sectors to
128 sectors because that allows over 100 MB of additional usable space
on a 700 MB cdrw, and increases throughput.

Note that you need a modified cdrwtool program that can format a CDRW
disc with larger packets to benefit from this change.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 include/linux/pktcdvd.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 1623da8..8a94c71 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -169,7 +169,7 @@ struct packet_iosched
 #if (PAGE_SIZE % CD_FRAMESIZE) != 0
 #error "PAGE_SIZE must be a multiple of CD_FRAMESIZE"
 #endif
-#define PACKET_MAX_SIZE		32
+#define PACKET_MAX_SIZE		128
 #define FRAMES_PER_PAGE		(PAGE_SIZE / CD_FRAMESIZE)
 #define PACKET_MAX_SECTORS	(PACKET_MAX_SIZE * CD_FRAMESIZE >> 9)
 

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
