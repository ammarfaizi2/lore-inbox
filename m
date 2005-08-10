Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbVHJAJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbVHJAJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVHJAJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:09:50 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:28811 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S1750985AbVHJAJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:09:45 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Christoph Hellwig <hch@lst.de>
Date: Wed, 10 Aug 2005 10:09:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17145.17859.563739.562389@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use kthread infrastructure in md
In-Reply-To: message from Christoph Hellwig on Tuesday August 9
References: <20050809210446.GA29308@lst.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 9, hch@lst.de wrote:
> Switch MD to use the kthread infrastructure, to simplify the code and
> get rid of tasklist_lock abuse in md_unregister_thread.  Long-term I
> wonder whether workqueues wouldn't be a better choice than the
> MD-specific thread wrappers for the lowlevel drivers.
> 

Thanks.  This is definitely a step in the right direction.   However
I think it still needs a bit of work.
The old md_unregister_thread sent a signal to the thread so that if it
was in 'wait_event_interruptible_timeout', that call would complete.
However I cannot see how the new md_unregister_thread will interrupt
the wait_event_interruptible_timeout.
I'll look into it..


Thanks,
NeilBrown
