Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKIJf5>; Thu, 9 Nov 2000 04:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbQKIJff>; Thu, 9 Nov 2000 04:35:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56079 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129033AbQKIJf0>;
	Thu, 9 Nov 2000 04:35:26 -0500
Date: Thu, 9 Nov 2000 10:35:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: rd - deadlock removal
Message-ID: <20001109103511.G467@suse.de>
In-Reply-To: <14857.60161.343937.977948@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14857.60161.343937.977948@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Nov 09, 2000 at 11:08:33AM +1100
X-OS: Linux 2.4.0-test11 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09 2000, Neil Brown wrote:
[snip]
>                                     DEADLOCK

>  I have two patches which address this problem.
>  The first is simple and simply drops ui_request_lock before calling
>  getblk.  This may be the appropriate one to use given the code
>  freeze.

rd still needs to hold the lock when calling end_request, since
that may end up fiddling with the queue list.

>  The second is more elegant in that it side steps the problem by
>  giving rd.c a make_request function instead of using the default
>  _make_request.   This means that io_request_lock is simply never
>  claimed my rd.

And this solution is much better, even given the freeze I think that
is the way to go.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
