Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292255AbSCDJMl>; Mon, 4 Mar 2002 04:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292281AbSCDJMb>; Mon, 4 Mar 2002 04:12:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20753 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292255AbSCDJMQ>;
	Mon, 4 Mar 2002 04:12:16 -0500
Date: Mon, 4 Mar 2002 10:09:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: queue_nr_requests needs to be selective
Message-ID: <20020304090925.GC1062@suse.de>
In-Reply-To: <20020301132254.A11528@vger.timpanogas.org> <3C7FE7DD.98121E87@zip.com.au> <20020301162016.A12413@vger.timpanogas.org> <3C800D66.F613BBAA@zip.com.au> <20020301172701.A12718@vger.timpanogas.org> <3C8021A9.BB16E3FC@zip.com.au> <20020301191626.A13313@vger.timpanogas.org> <3C804BF0.3993B153@zip.com.au> <20020302091023.GH12014@suse.de> <3C8099BF.85BA994D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8099BF.85BA994D@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02 2002, Andrew Morton wrote:
> > I'm just a bit worried
> > about the batch_request vs nr_requests ratio. Are you sure 1/4 is always
> > a good ratio? In my previous testing, a batch value of more than 32 had
> > little impact and usually changed things for the worse.
> > 
> 
> Well I just left it as it was for the default case...
> 
> I haven't tested much at all for different batching levels.  And
> in this area, tuning it for my combination of hardware probably
> doesn't carry much relevance for Jeff's setup (for example).

Just the fact that you are using much bigger free queue sizes now means
that the batching in itself has less of an effect than with the smaller
queue sizes (here it's absolutely vital to get good merging).

> And the change to FIFO wakeup may have invalidated your earlier
> testing.

Could be, I'd inclined to think that FIFO behaviour would aid the
batching as well. Remember that we have had FIFO wakups there before, so
that's not entirely new.

> So hmm.  I'll have a play with it, and if nothing obvious jumps
> out, I'll just clamp it at 32.

I think that would be best, I'll wait for numbers though :-). To be
honest, batch counts of eg 256 just sounds a bit insane to me.

-- 
Jens Axboe

