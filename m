Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287503AbRLaM7G>; Mon, 31 Dec 2001 07:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287511AbRLaM65>; Mon, 31 Dec 2001 07:58:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:26633 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287503AbRLaM6q>;
	Mon, 31 Dec 2001 07:58:46 -0500
Date: Mon, 31 Dec 2001 13:58:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: You WIN ...
Message-ID: <20011231135804.C7130@suse.de>
In-Reply-To: <20011229151534.D609@suse.de> <Pine.LNX.4.10.10112291246190.31392-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112291246190.31392-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sat on this for a few days not to boil over)

On Sat, Dec 29 2001, Andre Hedrick wrote:
> 
> Jens,
> 
> You win -- it is not worth trying to work with you at this time.
> All you and I have done is become bitter enemies.
> 
> Next, I do not know all the details of the kernel, but what I know is
> that neither one of us is willing to listen and learn.  However, I have
> tried to get answers from you public and private, and nothing.  You may

I've answered lots of your mails and inquiries on irc, I frankly cannot
see how I can improve there.

> get your wish granted to replace me in the future, as this has been your
> stated goal from the past to me directly.

I've never stated that I want to replace you. In fact I've stated
several times that I definitely do not want to maintain low level IDE
code (or any other any directly hardware related driver, nothing but
trouble). I stick to core kernel mainly, makes me happy.

> In closing, there were several cases of filesystem corruption based on
> partition offsets and other various items.  This was totally unacceptable
> for the most part.  I truly think that you do not see what the object of

Please -- there was _one_ case of a one-off in partition handling with
an obscure partition format caused by a missing include, *this was not a
bio problem*. Please list the "various other items" for me. Are you
making stuff up again now?

You seem to naively believe that if you driver passed some ata analyzer
tests or follows the specification state diagrams to the letter, that
it's perfect. That is just so obviously wrong. How about timing related
bugs in your driver under different circumstances? SMP (or just irq)
related races?

I have seen data corruption several times while developing bio
(expected, I'm not perfect), however _none_ of these could have been
avoided with using an analyzer. The low level block driver just did what
I/bio asked it to do, regardless of the data contents or data direction
was right or not. Too bad.

We have seen data corruption in stable kernels before after block or IDE
change. The former was due to missing locking lately, or head-active
list corruption. The latter was a plugging bug in IDE. Neither of these
could have been caught with an analyzer.

> "BLOCK" is all about, regardless that you are clever and quick.  You have
> decided that block will define the interface to the drivers and thus the
> drivers can not conform to standards set forth by the people creating the
> physical layer.

Not so, I'm not telling drivers what to do. I'm making the block
interface as flexible as I can for drivers, while also making it easier
to write a block driver and _get it right_.

> Finally, I offer a public apology to you and all who have suffered on LKML.

Thank you

-- 
Jens Axboe

