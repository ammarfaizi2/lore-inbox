Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129990AbRAINSL>; Tue, 9 Jan 2001 08:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130748AbRAINSB>; Tue, 9 Jan 2001 08:18:01 -0500
Received: from slc35.modem.xmission.com ([166.70.9.35]:50186 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129990AbRAINR4>; Tue, 9 Jan 2001 08:17:56 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: zlatko@iskon.hr, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101082322030.1222-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Jan 2001 04:38:56 -0700
In-Reply-To: Linus Torvalds's message of "Mon, 8 Jan 2001 23:27:15 -0800 (PST)"
Message-ID: <m1snmtgdkf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 8 Jan 2001, Eric W. Biederman wrote:
> 
> > Zlatko Calusic <zlatko@iskon.hr> writes:> 
> > > 
> > > Yes, but a lot more data on the swap also means degraded performance,
> > > because the disk head has to seek around in the much bigger area. Are
> > > you sure this is all OK?
> > 
> > I don't think we have more data on the swap, just more data has an
> > allocated home on the swap.
> 
> I think Zlatko's point is that because of the extra allocations, we will
> have worse locality (more seeks etc). 
> 
> Clearly we should not actually do any more actual IO. But the sticky
> allocation _might_ make the IO we do be more spread out.

The tradeoff when implemented correctly is that writes will tend to be
more spread out and reads should be better clustered together. 

> To offset that, I think the sticky allocation makes us much better able to
> handle things like clustering etc more intelligently, which is why I think
> it's very much worth it.  But let's not close our eyes to potential
> downsides.

Certainly, keeping ours eyes open is a good a good thing.

But it has been apparent for a long time that by doing allocation as
we were doing it, that when it came to heavy swapping we were taking a
performance hit.  So I'm relieved that we are now being more aggressive.

>From the sounds of it what we are currently doing actually sucks worse
for some heavy loads.  But it still feels like the right direction.

It's been my impression that work loads where we are actively swapping
are a lot different from work loads where we really don't swap.  To
the extent that it might make sense to make the actively swapping case
a config option to get our attention in the code.  It would be nice
to have a linux kernel for once that handles heavy swapping (below
the level of thrashing) gracefully. :)

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
