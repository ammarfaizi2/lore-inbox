Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316721AbSE0Lew>; Mon, 27 May 2002 07:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316722AbSE0Lev>; Mon, 27 May 2002 07:34:51 -0400
Received: from pc-80-195-34-129-ed.blueyonder.co.uk ([80.195.34.129]:7553 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316721AbSE0Leu>; Mon, 27 May 2002 07:34:50 -0400
Date: Mon, 27 May 2002 12:34:38 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
Message-ID: <20020527123438.A2583@redhat.com>
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au> <20020516161749.D2410@redhat.com> <E17Btad-0003sq-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 26, 2002 at 10:41:22AM +0200, Daniel Phillips wrote:
> On Thursday 16 May 2002 17:17, Stephen C. Tweedie wrote:
> > Most applications are not all that bound by write latency.
> 
> But some are.  Transaction processing applications, where each transaction 
> has to be safely on disk before it can be acknowledged, care about write 
> latency a lot, since it translates more or less directly into throughput.

Not really.  They care about throughput, and will happily sacrifice
latency for that.  The postmark stuff showed that very clearly --- by
yielding in transaction commit and allowing multiple transactions to
batch up, Andrew saw an instant improvement of about 3000% in postmark
figures, despite the fact that the yield is obviously only going to
increase the latency of each individual transaction.  Pretty much all
TP benchmarks focus on throughput, not latency.

So while latency is important, if we have to tradeoff against
throughput, that is normally the right tradeoff on synchronous write
traffic.  For reads, latency is obviously critical in nearly all
cases.

Cheers,
 Stephen
