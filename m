Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVKNVys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVKNVys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVKNVyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:54:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751274AbVKNVyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:54:46 -0500
Date: Mon, 14 Nov 2005 21:54:37 GMT
Message-Id: <200511142154.jAELsb7T007515@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 1/12] FS-Cache: Handle -Wsign-compare in i386 bitops
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes i386's find_first_bit() use an unsigned integer as a
counter to avoid getting warnings when -Wsign-compare is given.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 asm-i386-bitops-2614mm2.diff
 include/asm-i386/bitops.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -uNrp linux-2.6.14-mm2/include/asm-i386/bitops.h linux-2.6.14-mm2-cachefs/include/asm-i386/bitops.h
--- linux-2.6.14-mm2/include/asm-i386/bitops.h	2005-08-30 13:56:33.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/include/asm-i386/bitops.h	2005-11-14 16:23:38.000000000 +0000
@@ -332,9 +332,9 @@ static inline unsigned long __ffs(unsign
  * Returns the bit-number of the first set bit, not the number of the byte
  * containing a bit.
  */
-static inline int find_first_bit(const unsigned long *addr, unsigned size)
+static inline unsigned find_first_bit(const unsigned long *addr, unsigned size)
 {
-	int x = 0;
+	unsigned x = 0;
 
 	while (x < size) {
 		unsigned long val = *addr++;
