Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317735AbSHMRs1>; Tue, 13 Aug 2002 13:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318984AbSHMRs1>; Tue, 13 Aug 2002 13:48:27 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:51723 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317735AbSHMRs0>; Tue, 13 Aug 2002 13:48:26 -0400
Date: Tue, 13 Aug 2002 18:52:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 2/21] reduced locking in buffer.c
Message-ID: <20020813185213.A17449@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@redhat.com>
References: <3D561473.40A53C0D@zip.com.au> <Pine.LNX.4.44.0208131032210.7411-100000@home.transmeta.com> <3D5947B7.EDE01C2E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D5947B7.EDE01C2E@zip.com.au>; from akpm@zip.com.au on Tue, Aug 13, 2002 at 10:53:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 10:53:59AM -0700, Andrew Morton wrote:
> I have discussed it with David - he said it's OK in 2.5, but
> not in 2.4, and he has eyeballed the diff.
> 
> However there's another thing to think about:
> 
> 	local_irq_disable();
> 	atomic_inc();
> 
> If the architecture implements atomic_inc with spinlocks, this will
> schedule with interrupts off with CONFIG_PREEMPT=y, I expect.
> 
> I can fix that with a preempt_disable() in there, but ick.

Is there a reason you can't just use brlocks?
