Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135212AbRDLQBN>; Thu, 12 Apr 2001 12:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135214AbRDLQBE>; Thu, 12 Apr 2001 12:01:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48389 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135212AbRDLQAw>; Thu, 12 Apr 2001 12:00:52 -0400
Subject: Re: scheduler went mad?
To: hugh@veritas.com (Hugh Dickins)
Date: Thu, 12 Apr 2001 17:02:52 +0100 (BST)
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0104121622520.1638-100000@localhost.localdomain> from "Hugh Dickins" at Apr 12, 2001 04:43:10 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14njYc-0000vA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.3-pre6 quietly made a very significant change there:
> it used to say "if (!order) goto try_again;" and now just
> says "goto try_again;".  Which seems very sensible since
> __GFP_WAIT is set, but I do wonder if it was a safe change.
> We have mechanisms for freeing pages (order 0), but whether
> any higher orders come out of that is a matter of chance.

The fundamental problem is that it should say

	wait_for_mm_progress();
	goto try_again;

and we dont have that facility right now. At that point the looping on
failed allocations problem is ok as we will allow someone to make progress.
That leaves the bounce buffers for > 800Mb RAM which currently are seriously
horked and will loop and may even stack overflow by inspection

