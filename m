Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVIOUai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVIOUai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVIOUah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 16:30:37 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37813
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751183AbVIOUah convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 16:30:37 -0400
Date: Thu, 15 Sep 2005 13:30:26 -0700 (PDT)
Message-Id: <20050915.133026.21581824.davem@davemloft.net>
To: kloczek@rudy.mif.pg.gda.pl
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       aurora-sparc-devel@lists.auroralinux.org, davem@redhat.com
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Thu, 15 Sep 2005 19:40:27 +0200 (CEST)

> I'm just catch series of kernel messages with soft lockup detected reports 
> (in attachment).
> It occures during store big amout of data on NFS volume.
> 
> As NIC I use now Sun Swift gigabit eth (cassini driver). Probably this is 
> NFS related because I'm just browse yesterday logs and simillar was also 
> on Sun Happy Meal.

Interesting.  Can you reproduce this with SLAB poisioning disabled?
That debugging feature is extremely expensive, although it shouldn't
make the CPU stop scheduling processes for more than 10 seconds.

I wonder if the NFS daemon code needs to have some limits put on
how much cpu it consumes handling requests before it gives up the
cpu.  Perhaps, it has such throttling already, I don't know.

I'll also try to see if there can be some kind of sparc64 specific
issue which would cause this.

Where did you get that Cassini driver btw?  It's not upstream,
although if it exists it should be.
