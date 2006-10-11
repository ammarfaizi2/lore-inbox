Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWJKCIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWJKCIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 22:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWJKCIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 22:08:20 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:14564 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750710AbWJKCIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 22:08:19 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Dave Kleikamp <shaggy@austin.ibm.com>, Olof Johansson <olof@lixom.net>,
       Linas Vepstas <linas@austin.ibm.com>, Bryce Harrington <bryce@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Potential fix for fdtable badness.
Date: Tue, 10 Oct 2006 19:08:18 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610101908.18442.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Sorry about the recent fdtable badness that you all encountered. I'm working
on getting a fix out there.

Dave, Olof, Linas, Bryce,

Could you please test the patch at the bottom of the email to see if it makes
your computers happy again, if you have the time and inclination to do so?

Andrew,

Would you prefer me to resend a fixed patch #4, or a new fix (#5) on top of
what's in your tree?

diff -Npru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-10-10 18:58:21.000000000 -0700
+++ new/fs/file.c	2006-10-10 19:01:03.000000000 -0700
@@ -164,9 +164,8 @@ static struct fdtable * alloc_fdtable(un
 	 * the fdarray into page-sized chunks: starting at a quarter of a page,
 	 * and growing in powers of two from there on.
 	 */
-	nr++;
 	nr /= (PAGE_SIZE / 4 / sizeof(struct file *));
-	nr = roundup_pow_of_two(nr);
+	nr = roundup_pow_of_two(nr + 1);
 	nr *= (PAGE_SIZE / 4 / sizeof(struct file *));
 	if (nr > NR_OPEN)
 		nr = NR_OPEN;
