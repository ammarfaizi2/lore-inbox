Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbTBPWEH>; Sun, 16 Feb 2003 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265936AbTBPWEH>; Sun, 16 Feb 2003 17:04:07 -0500
Received: from mailhost1-chcgil.chcgil.ameritech.net ([206.141.192.67]:5363
	"EHLO mailhost.chi1.ameritech.net") by vger.kernel.org with ESMTP
	id <S265275AbTBPWEH>; Sun, 16 Feb 2003 17:04:07 -0500
Date: Sun, 16 Feb 2003 16:16:16 -0600
From: Mark J Roberts <mjr@znex.org>
To: linux-kernel@vger.kernel.org
Subject: Annoying /proc/net/dev rollovers.
Message-ID: <20030216221616.GA246@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The rolling-over of /proc/net/dev fields annoys me.

I read a couple threads about the issue and saw a lot of whimpering
about how locking would be such a pain to implement in lieu of
32-bit atomicity.

Alan Cox pointed out in one of them that accurate info could be
collected through "the firewalling facilities", which I take to mean
the ipt_counters structure. The caveat is that it only provides
packet and byte counts.

One alternative to throwing locks around everything accessing those
fields is to update a 64-bit counter asynchronously. Has this been
considered? It would entail atomically executing

	total_rx_bytes += rx_bytes;
	rx_bytes = 0;

and merely ensuring that rx_bytes does not roll over between calls.
