Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbTFOIJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 04:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTFOIJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 04:09:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32964 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262011AbTFOIJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 04:09:29 -0400
Date: Sun, 15 Jun 2003 01:18:12 -0700 (PDT)
Message-Id: <20030615.011812.10301547.davem@redhat.com>
To: anton@samba.org
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, manfred@colorfullife.com,
       axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030615080442.GF31148@krispykreme>
References: <20030615070611.GE31148@krispykreme>
	<20030615.001107.88478922.davem@redhat.com>
	<20030615080442.GF31148@krispykreme>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Anton Blanchard <anton@samba.org>
   Date: Sun, 15 Jun 2003 18:04:42 +1000
   
   To make the best use of the IOMMU we would want to have it filled with
   addresses (to have the best chance that we will find an existing
   mapping). And for zero copy stuff it could be all over RAM. 
   In effect we are looking at a mapping from 512GB -> 3GB. (assuming the
   top 1GB of PCI addresses are for PCI IO and memory)

We have this same problem with huge files in the page cache.
Maybe you should use a trie.

Because that data structure will expand wrt. actual use.

I bet the management (especially the shared memory refcount bump)
will outweight the costs saved unless your hardware is really stupid.
But judging by the e1000/ppc64 issue, your hardware is stupid and thus
maybe it's worthwhile for you to continue to pursue this idea :)
