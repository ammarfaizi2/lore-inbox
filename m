Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130699AbQJ1P6c>; Sat, 28 Oct 2000 11:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130706AbQJ1P6X>; Sat, 28 Oct 2000 11:58:23 -0400
Received: from Cantor.suse.de ([194.112.123.193]:25098 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130914AbQJ1P6Q>;
	Sat, 28 Oct 2000 11:58:16 -0400
Date: Sat, 28 Oct 2000 17:58:12 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: kumon@flab.fujitsu.co.jp, Andi Kleen <ak@suse.de>,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was: Strange performance behavior of 2.4.0-test9)
Message-ID: <20001028175812.A10106@gruyere.muc.suse.de>
In-Reply-To: <39F957BC.4289FF10@uow.edu.au>, <39F92187.A7621A09@timpanogas.org> <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu> <20001027094613.A18382@gruyere.muc.suse.de> <39F957BC.4289FF10@uow.edu.au> <200010271257.VAA24374@asami.proc.flab.fujitsu.co.jp> <39FAF4C6.3BB04774@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <39FAF4C6.3BB04774@uow.edu.au>; from andrewm@uow.edu.au on Sun, Oct 29, 2000 at 02:46:14AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 02:46:14AM +1100, Andrew Morton wrote:
> kumon@flab.fujitsu.co.jp wrote:
> > 
> > Change the following two macros:
> >         acquire_fl_sem()->lock_kernel()
> >         release_fl_sem()->unlock_kernel()
> > then
> > 5192 Req/s @8cpu is got. It is same as test8 within fluctuation.
> 
> hmm..  BKL increases scalability.  News at 11.
> 
> The big question is: why is Apache using file locking so
> much?  Is this normal behaviour for Apache?

It serializes accept() to avoid the thundering herd from the wake-all
semantics.

With the 2.4 stack that is probably not needed anymore (it was in 2.2), 
it may just work to remove the file locking (it should always be correct,
just on 2.2 it may be slower to remove it) 

> Because if so, the file locking code will be significantly
> bad for the scalability of Apache on SMP (of all things!).
> It basically grabs a big global lock for _anything_.  It
> looks like it could be a lot more granular. 

iirc everybody who looked at the code agrees that it needs a rewrite
badly.


-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
