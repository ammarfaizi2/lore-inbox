Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267437AbRGPPvk>; Mon, 16 Jul 2001 11:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267438AbRGPPvb>; Mon, 16 Jul 2001 11:51:31 -0400
Received: from web14306.mail.yahoo.com ([216.136.173.82]:13574 "HELO
	web14306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267437AbRGPPvX>; Mon, 16 Jul 2001 11:51:23 -0400
Message-ID: <20010716155126.37887.qmail@web14306.mail.yahoo.com>
Date: Mon, 16 Jul 2001 08:51:26 -0700 (PDT)
From: Kanoj Sarcar <kanojsarcar@yahoo.com>
Subject: Re: [PATCH] Separate global/perzone inactive/free shortage 
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>, Dirk Wetter <dirkw@rentec.com>,
        Mike Galbraith <mikeg@wen-online.de>, linux-mm@kvack.org,
        "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0107140204110.4153-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> Hi,
> 
> As well known, the VM does not make a distiction
> between global and
> per-zone shortages when trying to free memory. That
> means if only a given
> memory zone is under shortage, the kernel will scan
> pages from all zones. 
> 
> The following patch (against 2.4.6-ac2), changes the
> kernel behaviour to
> avoid freeing pages from zones which do not have an
> inactive and/or
> free shortage.
> 
> Now I'm able to run memory hogs allocating 4GB of
> memory (on 4GB machine)
> without getting real long hangs on my ssh session.
> (which used to happen
> on stock -ac2 due to exhaustion of DMA pages for
> networking).
> 
> Comments ? 
> 
> Dirk, Can you please try the patch and tell us if it
> fixes your problem ? 
> 
> 

Just a quick note. A per-zone page reclamation
method like this was what I had advocated and sent
patches to Linus for in the 2.3.43 time frame or so.
I think later performance work ripped out that work.
I guess the problem is that a lot of the different
page reclamation schemes first of all do not know
how to reclaim pages for a specific zone, and secondly
have to go thru a lot of work before they discover the
page they are trying to reclaim does not belong to the
shortage zone, hence wasting a lot of work/cputime.
try_to_swap_out is a good example, which can be solved
by rmaps. 

Kanoj

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
