Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135675AbRDSNyv>; Thu, 19 Apr 2001 09:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135673AbRDSNyl>; Thu, 19 Apr 2001 09:54:41 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:38415 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135700AbRDSNyY>;
	Thu, 19 Apr 2001 09:54:24 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104191354.f3JDs7C27006@oboe.it.uc3m.es>
Subject: Re: block devices don't work without plugging in 2.4.3
In-Reply-To: <20010419152443.B22517@suse.de> from "Jens Axboe" at "Apr 19, 2001
 03:24:43 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Thu, 19 Apr 2001 15:54:07 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK - agreed. But while I have your attention...

"Jens Axboe wrote:"
> On the contrary, you are now given an exceptional opportunity to clean
> up your code and get rid of blk_queue_pluggable and your noop plugging
> function.

In summary: blk_queue_pluggable can be removed for all driver codes
aimed at all 2.4.* kernels, because the intended effect can be obtained
through merge_reqeusts function controls.

My unease derives, I think, from the fact that I have occasionally used
plugging for other purposes. Namely for throttling the device. These
uses have always been experimental and uniformly unsuccessful, because
throttling that way backs up the VFS with dirty buffers and provokes
precisely the deadlock against VFS that I was trying to avoid. So ..

 ... how can I tell when VFS is nearly full?  In those circumstances I
want to sync every _other_ device, thus giving me enough buffers at
least to flush something to the net with, thus freeing a request of
mine, plus its buffers.

Peter
