Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135623AbRDSLYV>; Thu, 19 Apr 2001 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135624AbRDSLYL>; Thu, 19 Apr 2001 07:24:11 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:35598 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135623AbRDSLYB>;
	Thu, 19 Apr 2001 07:24:01 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104191123.f3JBNfM17858@oboe.it.uc3m.es>
Subject: Re: block devices don't work without plugging in 2.4.3
In-Reply-To: <20010419125140.M16822@suse.de> from "Jens Axboe" at "Apr 19, 2001
 12:51:40 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Thu, 19 Apr 2001 13:23:41 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK .. thanks Jens. Sorry about the repeat .. my nameserver lost its fix
on the root servers thanks to some hurried upgrades, and sendmail
started quietly bouncing mail for "not having" a dns entry, and you
know about deja. Probably the list dropped me for the bounces.
Those are my excuses. Apologies again.

"Jens Axboe wrote:"
> > The result is that a block device that doesn't do plugging doesn't
> > work.
> > 
> > If it has called blk_queue_pluggable() to register a no-op plug_fn,
> > then q->plugged will never be set (it's the duty of the plug_fn), and
> > the devices registered request function will never be called.
> > 
> > This behaviour is distinct from 2.4.0, where registering a no-op
> > plug_fn made things work fine.
> 
> Check the archives, I replied to this days ago. But since I'm taking the
> subject up anyway, let me expand on it a bit further.

Yes, please.

> Not using plugging is gone, blk_queue_pluggable has been removed from
> the current 2.4.4-pre series if you check that. The main reason for
> doing this, is that there are generally no reasons for _not_ using
> plugging in the 2.4 series kernels. In 2.2 and previous, not using the

I agree.

> builtin plugging was generally done to disable request merging. In 2.4,
> the queues have good control over what happens there with the
> back/front/request merging functions -- so drivers can just use that.

They can indeed. And I agree, it had become necessary to both enable
plugging and to enable request merging separately (via control over
these two sets of things), in order to get request merging. That was
silly.

> Besides, the above hunk was removed because it is wrong. For devices
> using plugging, we would re-call the request_fn while the device was
> already active and serving requests. Not only is this a performance hit

Not sure about that ...

> we don't need to take, it also gave problems on some drivers.

Well, I know scsi used to be treating the first element while still on
the queue, but presumably you are not referring to that.

So the consensus is that I should enable plugging while the plugging
function is still here and do nothing when it goes? I must say I don't
think it should really "go", since that means I have to add a no-op
macro to replace it, and I don't like #ifdefs. 

BTW, I don't need request merging (and therefore don't need plugging)
because requests eventually go out over the net. Nevertheless, I have
always been interested in seeing the difference it could cause. I
have never seen the measurements reflect the gain that I would have
expected from request merging, although I would have naively expected
some (in MY case).

Thanks again.

Peter
