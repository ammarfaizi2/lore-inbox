Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUBFJEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUBFJEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:04:00 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:62125 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S265201AbUBFJD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:03:57 -0500
Date: Fri, 06 Feb 2004 18:03:38 +0900 (JST)
Message-Id: <20040206.180338.640917915.nomura@linux.bs1.fc.nec.co.jp>
To: hugh@veritas.com
Cc: j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: [2.4] heavy-load under swap space shortage
From: j-nomura@ce.jp.nec.com
In-Reply-To: <Pine.LNX.4.44.0402051834070.1396-100000@localhost.localdomain>
References: <20040204.204058.1025214600.nomura@linux.bs1.fc.nec.co.jp>
	<Pine.LNX.4.44.0402051834070.1396-100000@localhost.localdomain>
X-Mailer: Mew version 3.3 on XEmacs 21.4.14 (Reasonable Discussion)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > With slight modification (please see the patch below), it's really helpful.
> > I hope you push it again to the mainline.
> 
> Okay, glad to hear it, I'll try pushing to Marcelo in 2.4.26-pre.

Thank you.

> Can you describe the benefit you see?

OK.
The benefit is simple.

Before applying your patch, the system became hardly responsive
under a certain situation (that is no free swap space, running page cache
intensive applications).
The system time went up 80-100% for long time (30 minutes to hours).

After applying your patch, under the same situation, the responsiveness
of the system does not get worse.
The system time goes up high for a few seconds, but it goes down soon.

> > I added the check for 'mm == swap_mm'. It might be necessary to avoid
> > the corner case where mmlist_lock being held too long.
> 
> Oh, good point.  But I'm uneasy about treating a trip round the mmlist
> failing to get a lock as the same thing as finding no pages to free,
> your "goto empty": drop lock and come around again instead, as below?

I feel your approach is better than mine to keep the current semantics.

Best regards.
--
NOMURA, Jun'ichi <j-nomura@ce.jp.nec.com>
