Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWBCJZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWBCJZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBCJZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:25:35 -0500
Received: from science.horizon.com ([192.35.100.1]:24650 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932185AbWBCJZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:25:34 -0500
Date: 3 Feb 2006 04:25:33 -0500
Message-ID: <20060203092533.13547.qmail@science.horizon.com>
From: linux@horizon.com
To: davej@redhat.com
Subject: Re: discriminate single bit error hardware failure from slab corruption.
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um... case values are allowed to be expressions.

Isn't
+	switch (total) {
+		case SLAB_POISON ^ 0x01:
+		case SLAB_POISON ^ 0x02:
+		case SLAB_POISON ^ 0x04:
+		case SLAB_POISON ^ 0x08:
+		case SLAB_POISON ^ 0x10:
+		case SLAB_POISON ^ 0x20:
+		case SLAB_POISON ^ 0x40:
+		case SLAB_POISON ^ 0x80:
+			printk (KERN_ERR "Single bit error detected. Possibly bad RAM\n"

Infinitely clearer, even without the comments?  Or, if you want to
be cleverer:

	total ^= SLAB_POISON;
	if ((total & (total-1)) == 0) {
		printk (KERN_ERR "Single bit error detected. Possibly bad RAM\n"
	}


If you wanted to get the bit-counting exactly accurate, you'd do:

	unsigned char total = 0, total2 = 0;

 	for (i = 0; i < limit; i++) {
		unsigned char delta = data[offset+i];
 		printk(" %02x", delta;
		delta ^= POISON_FREE;
		total2 |= total & delta;
		total |= delta;
 	}
 	printk("\n");

	/* If total2 has 0 bits set and total1 has at most 1 bit set... */
	if (!total2 && !(total1 & (total1 - 1)) {
		printk (KERN_ERR "Single bit error detected. Possibly bad RAM\n"
		
	}
