Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131048AbRBTXsm>; Tue, 20 Feb 2001 18:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131124AbRBTXsc>; Tue, 20 Feb 2001 18:48:32 -0500
Received: from oboe.it.uc3m.es ([163.117.139.101]:50961 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S131065AbRBTXsY>;
	Tue, 20 Feb 2001 18:48:24 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200102202348.f1KNmMQ03100@oboe.it.uc3m.es>
Subject: Re: plugging in 2.4. Does it work?
In-Reply-To: <20010221003757.A1447@suse.de> from "Jens Axboe" at "Feb 21, 2001
 00:37:57 am"
To: "Jens Axboe" <axboe@suse.de>
Date: Wed, 21 Feb 2001 00:48:22 +0100 (MET)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jens Axboe wrote:"
> On Wed, Feb 21 2001, Peter T. Breuer wrote:
> > Hurrr ... are you saying that the buffers in the bh's in the request are
> > not contiguous?  My reading of the make_request code in 2.2 was that
> > they were!  Has that changed?  There is now a reference to an elevator
> > algorithm in the code, and I can't make out the effect by looking ... 
> > I have been copying the buffer in the request as though it were a single
> > contigous whole.  If that is not the case, then yes, bang would happen.
> 
> Nothing has changed in this regard at all between 2.2 and 2.4. The
> buffers are guaranteed to be sequentially sector-wise, but definitely
> not contigious in memory!

I recall that in 2.2 the make_request code tested that the
buffers were contiguous in memory. From 2.2.18:

                        /* Can we add it to the end of this request? */
                        if (back) {
                                if (req->bhtail->b_data + req->bhtail->b_size
                                    != bh->b_data) {
                                        if (req->nr_segments < max_segments)
                                                req->nr_segments++;
                                        else break;
                                }

It looks to me like it tested that the b_data char* pointers of the
two requests being considered are exactly distant by the declared
size of one.

Is that no longer the case? If so, that's my answer.


Peter
