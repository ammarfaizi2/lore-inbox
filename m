Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBHIMC>; Thu, 8 Feb 2001 03:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbRBHILw>; Thu, 8 Feb 2001 03:11:52 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19079 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129032AbRBHILo>;
	Thu, 8 Feb 2001 03:11:44 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14978.21605.98365.252519@pizda.ninka.net>
Date: Thu, 8 Feb 2001 00:10:13 -0800 (PST)
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: dentry cache order 7 is broken
In-Reply-To: <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dean gaudet writes:
 > also, for order > 7, was the real intention to use a shift of
 > (order*2)&31?

No, the whole thing is buggered.  How stupid, my fault.
It was the 64-bit platform fascist at work :-)

How does this work for you (against 2.4.x)?

--- fs/dcache.c.~1~	Tue Feb  6 23:00:58 2001
+++ fs/dcache.c	Thu Feb  8 00:09:10 2001
@@ -696,7 +696,8 @@
 static inline struct list_head * d_hash(struct dentry * parent, unsigned long hash)
 {
 	hash += (unsigned long) parent / L1_CACHE_BYTES;
-	hash = hash ^ (hash >> D_HASHBITS) ^ (hash >> D_HASHBITS*2);
+	hash = hash ^ (hash >> D_HASHBITS) ^
+		(hash >> (D_HASHBITS+(D_HASHBITS/2)));
 	return dentry_hashtable + (hash & D_HASHMASK);
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
