Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291916AbSBAS6b>; Fri, 1 Feb 2002 13:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291913AbSBAS6M>; Fri, 1 Feb 2002 13:58:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39438 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S291914AbSBAS6H>;
	Fri, 1 Feb 2002 13:58:07 -0500
Date: Fri, 1 Feb 2002 19:57:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Roger Larsson <roger.larsson@norran.net>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Errors in the VM - detailed
Message-ID: <20020201195743.J12156@suse.de>
In-Reply-To: <Pine.LNX.4.30.0202011708460.29576-100000@mustard.heime.net> <200202011847.g11Ilwa14845@maila.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202011847.g11Ilwa14845@maila.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01 2002, Roger Larsson wrote:
> On Fridayen den 1 February 2002 17.11, Roy Sigurd Karlsbakk wrote:
> > It does not seem to be possible to reproduce the error with apache2. But
> > this may be because Apache2's i/o handling doesn't impress much. With Tux,
> > I keep getting up to 40 megs per sec, but with Apache the average is
> > ~15MB/s.
> >
> > Btw ... It looks like your patch (against rmap12a) gave me an extra
> > performance kick. 12c gave me a max of ~32MB/s, whereas your patch
> > highered this to ~41.
> >
> 
> Hmm.. suppose this is the problem anyway and that Jens patch was not enough.
> How do the disk drive sound during the test?
> 
> Does it start to sound more when performance goes down?

Yes that would be interesting to know, if the disk becomes seek bound.

> About Jens patch:
> 
> My feeling is that there should be (a lot) more  READA than READ.
> since sequential READ really only NEEDS one at a time.

Probably, my patch was really just a quick try to see if it changed
anything.

> Number of READ limits the number of concurrent streams.
> And READA limits the maximum total read ahead.

Correct, Roy you could try and change the READA balance by allocating
lots more READA requests. Simply play around with the
queue_nr_requests / 4 setting. Try something "absurd" like
queue_nr_requests << 2 or even bigger.

-- 
Jens Axboe

