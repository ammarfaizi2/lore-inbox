Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbUDBQQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbUDBQQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:16:54 -0500
Received: from mail.shareable.org ([81.29.64.88]:62357 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263361AbUDBQQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:16:32 -0500
Date: Fri, 2 Apr 2004 17:11:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040402161149.GA32483@mail.shareable.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328173623.GA1087@mail.shareable.org> <20040402101108.GA752170@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402101108.GA752170@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Higdon wrote:
> > This is what I mean: turn off write cacheing, and performance on PATA
> > drops because of the serialisation and lost inter-command time.
> 
> Since you have to write the sectors in order (well, you don't have
> to, but the drives all do this), you lose a rev between each write
> when you don't queue commands or have write cacheing.

I don't see how the driver can write the sectors out of order, if
there is no TCQ (we're talking PATA) and every write must be committed
before it's acknowledged (write cache disabled).

> > With TCQ-on-write, you can turn off write cacheing and in theory
> > performance doesn't have to drop, is that right?
> 
> Correct.  I have proven this to my satisfaction.

Are you refuting the following assertion by Eric D. Mudama's, based on
your measurements?  In other words, are ATA's 32 TCQ slots enough to
eliminate the performance advantage of write cacheing?

Eric D. Mudama <edmudama@mail.bounceswoosh.org> wrote:
> However, cached writes (queued or unqueued), especially small ones,
> will have WAY higher ops/sec.  ATA TCQ is limited to 32 choices for
> the next best operation, but an 8MB buffer doing 4K random-ops could
> potentially have ~2000 choices for the next thing to do. (assuming
> perfect cache granularity, etc, etc)
>
> At 32 choices, the seek and rotate are still somewhat significant,
> though way better than unqueued.  With 2000 things to choose from, the
> drive is never, ever idle.  Seek, land just-in-time, read/write,
> rinse/repeat.

Thanks,
-- Jamie
