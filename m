Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVJQMAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVJQMAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVJQMAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:00:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39562 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932284AbVJQMAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:00:09 -0400
Date: Mon, 17 Oct 2005 17:24:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Serge Belyshev <belyshev@depni.sinp.msu.ru>, linux-kernel@vger.kernel.org,
       khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017115400.GC6257@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <87fyr2ape5.fsf@foo.vault.bofh.ru> <87slv23bw5.fsf@foo.vault.bofh.ru> <20051016162306.GA10410@in.ibm.com> <Pine.LNX.4.64.0510161919450.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510161919450.23590@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2005 at 07:34:24PM -0700, Linus Torvalds wrote:
> On Sun, 16 Oct 2005, Dipankar Sarma wrote:
> > 
> > Linus, I don't think this has anything to do with RCU grace periods
> > like we discussed previously. I measured on my 3.6GHz x86_64 and
> > found that open()/close() pair on /dev/null takes about 45500
> > cycles or 12 microseconds. [Does that sound resonable?].
> 
> That sounds very slow. I can do a million open/close pairs in 4 seconds on 
> a 2.5GHz G5. Maybe you tested a cold-cache case?

I measured after warming up for about a 100 times or so. It is
not a cold-cache case. I think we have a bigger problem in hand
here. I measured this with 2.6.13 and saw that I could do the
same in ~3 microseconds per iteration. It balloons to 12 microseconds
in 2.6.14-rc1. I am looking at this right now apart from the other
problems.


> I suspect this patch is worth it for the 2.6.14 timeframe, but I'll wait 
> for confirmation.
> 
> In fact, for 2.6.14, I'd almost do an even more minimal one. I agree with 
> your changing the file counter to an atomic, but I'd rather keep that 
> change for later.

Even beyond the file counter issue, we do need to address the DoS
and the open/close slowdown issue.

Thanks
Dipankar
