Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUI0u>; Wed, 21 Feb 2001 03:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129592AbRBUI0k>; Wed, 21 Feb 2001 03:26:40 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:3332 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129051AbRBUI0Y>; Wed, 21 Feb 2001 03:26:24 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200102210826.AAA00948@cx518206-b.irvn1.occa.home.com>
Subject: [PATCH] 2.4.2pre4 make loopback root work again
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2001 00:26:12 -0800 (PST)
Cc: axboe@suse.de, alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Reply-To: barryn@pobox.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending because I accidentally sent the original to vger.rutgers.edu.)

The following patch allows (at least, when combined with loop-5B) loopback
root mounting to work again. Without it, the boot process ends with
something along the lines of "kernel panic: I have no root and I want to
scream" (those may not be the exact words), or on ancient 2.3.xx kernels,
an inability to mount root device 00:00.

This bug has kept me from trying Linux 2.4 on my Dell Inspiron 5000e
(which is running a partitionless Red Hat 7 install that I've mutated into
using separate loopback files for /, /usr, etc.). I haven't tried booting
my Inspiron with it yet (I want to back up its hard drive first), but
(with 2.4.2-pre4 and loop-5B) it successfully boots a test-case floppy.
(I can post on the web a .tar.gz with the image, example .config files
for kernel compiles, and usage instructions, probably around 400K total,
if anyone wants me to do that.)

This patch is a merge of a bug fix from 2.2.10-ac11. This fix was merged
into 2.2.11pre2, but it doesn't seem to have been merged into 2.3 or 2.4
at all...

-Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.2-pre4/init/main.c linux-2.4.2-pre4-bkn1/init/main.c
--- linux-2.4.2-pre4/init/main.c	Wed Jan  3 20:45:26 2001
+++ linux-2.4.2-pre4-bkn1/init/main.c	Mon Feb 19 23:05:01 2001
@@ -149,6 +149,7 @@
 	const int num;
 } root_dev_names[] __initdata = {
 	{ "nfs",     0x00ff },
+	{ "loop",    0x0700 },
 	{ "hda",     0x0300 },
 	{ "hdb",     0x0340 },
 	{ "hdc",     0x1600 },


