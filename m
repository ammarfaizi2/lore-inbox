Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbRFGVQK>; Thu, 7 Jun 2001 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263213AbRFGVQB>; Thu, 7 Jun 2001 17:16:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8196 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263212AbRFGVPp>; Thu, 7 Jun 2001 17:15:45 -0400
Date: Thu, 7 Jun 2001 16:40:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Bulent Abali <abali@us.ibm.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Please test: workaround to help swapoff behaviour
In-Reply-To: <OF4314E00C.5B8A0E4C-ON85256A64.006F54E0@pok.ibm.com>
Message-ID: <Pine.LNX.4.21.0106071606540.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Bulent Abali wrote:

> 
> I tested your patch against 2.4.5.  It works.  No more lockups.  Without
> the
> patch it took 14 minutes 51 seconds to complete swapoff (this is to recover
> 1.5GB of
> swap space).  During this time the system was frozen.  No keyboard, no
> screen, etc. Practically locked-up.
> 
> With the patch there are no more lockups. Swapoff kept running in the
> background.
> This is a winner.
>
> But here is the caveat: swapoff keeps burning 100% of the cycles until it
> completes.

Yup. Wait a while until the dead swap cache issue is sorted out. 

When that finally happens, the time spent in swapoff will probably be
"acceptable".

> This is not going to be a big deal during shutdowns.  Only when you enter
> swapoff from
> the command line it is going to be a problem.
> 
> I looked at try_to_unuse in swapfile.c.  I believe that the algorithm is
> broken.

Yes. 

> For each and every swap entry it is walking the entire process list
> (for_each_task(p)).  It is also grabbing a whole bunch of locks
> for each swap entry.  It might be worthwhile processing swap entries in
> batches instead of one entry at a time.

The real fix is to make the processing the other way around --- go looking
into the pte's and from there do the swapins. 

Don't have the time to do everything, though. :) 

