Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUBJRxZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUBJRDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:03:34 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:14097 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266029AbUBJRBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:33 -0500
Date: Tue, 10 Feb 2004 17:03:15 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 10/10] dm: drop BIO_SEG_VALID bit
Message-ID: <20040210170315.GP27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that bio_clone copies the BIO_SEG_VALID bit from the
original bio when it was set. When we modify bi_idx or bi_vcnt
afterwards the segment counts are invalid and the bit must be dropped
(though it is fairly unlikely that it has already been set).
[Christophe Saout]
--- diff/drivers/md/dm.c	2004-02-10 16:12:10.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:12:17.000000000 +0000
@@ -338,6 +338,7 @@
 	clone->bi_idx = idx;
 	clone->bi_vcnt = idx + bv_count;
 	clone->bi_size = to_bytes(len);
+	clone->bi_flags &= ~(1 << BIO_SEG_VALID);
 
 	return clone;
 }
