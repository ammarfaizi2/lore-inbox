Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbUKXP34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUKXP34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 10:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbUKXN1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:27:08 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:63380 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262658AbUKXNDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:03:20 -0500
Subject: Suspend 2 merge: 29/51: Clear swapfile bdev in swapoff.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297169.5805.306.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:41 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend uses the bdev field as its means of telling which swap devices
are in use. (This info needs to be used at resume time without actually
doing the swapon[s] again). In order to avoid an oops in the suspend
code if the user turns off a swap device, this small addition is
necessary. (If you want the long explanation, feel free to ask!)

diff -ruN 816-clear-swapfile-bdev-in-swapoff-old/mm/swapfile.c 816-clear-swapfile-bdev-in-swapoff-new/mm/swapfile.c
--- 816-clear-swapfile-bdev-in-swapoff-old/mm/swapfile.c	2004-11-06 09:26:59.372699648 +1100
+++ 816-clear-swapfile-bdev-in-swapoff-new/mm/swapfile.c	2004-11-04 16:27:41.000000000 +1100
@@ -1179,6 +1179,7 @@
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
 	p->max = 0;
+	p->bdev = NULL;
 	swap_map = p->swap_map;
 	p->swap_map = NULL;
 	p->flags = 0;


