Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264380AbRFHWrh>; Fri, 8 Jun 2001 18:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264381AbRFHWr1>; Fri, 8 Jun 2001 18:47:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13579 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264380AbRFHWrS>; Fri, 8 Jun 2001 18:47:18 -0400
Date: Fri, 8 Jun 2001 18:11:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Bulent Abali <abali@us.ibm.com>
Cc: Mike Galbraith <mikeg@wen-online.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Please test: workaround to help swapoff behaviour
In-Reply-To: <OF4314E00C.5B8A0E4C-ON85256A64.006F54E0@pok.ibm.com>
Message-ID: <Pine.LNX.4.21.0106081811180.3343-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Bulent Abali wrote:

> 
> 
> 
> 
> >This is for the people who has been experiencing the lockups while running
> >swapoff.
> >
> >Please test. (against 2.4.6-pre1)
> >
> >
> >--- linux.orig/mm/swapfile.c Wed Jun  6 18:16:45 2001
> >+++ linux/mm/swapfile.c Thu Jun  7 16:06:11 2001
> >@@ -345,6 +345,8 @@
> >         /*
> >          * Find a swap page in use and read it in.
> >          */
> >+        if (current->need_resched)
> >+             schedule();
> >         swap_device_lock(si);
> >         for (i = 1; i < si->max ; i++) {
> >              if (si->swap_map[i] > 0 && si->swap_map[i] != SWAP_MAP_BAD)
> {
> 
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
> This is not going to be a big deal during shutdowns.  Only when you enter
> swapoff from
> the command line it is going to be a problem.
> 
> I looked at try_to_unuse in swapfile.c.  I believe that the algorithm is
> broken.
> For each and every swap entry it is walking the entire process list
> (for_each_task(p)).  It is also grabbing a whole bunch of locks
> for each swap entry.  It might be worthwhile processing swap entries in
> batches instead of one entry at a time.
> 
> In any case, I think having this patch is worthwhile as a quick and dirty
> remedy.

Bulent, 

Could you please check if 2.4.6-pre2+the schedule patch has better
swapoff behaviour for you? 

Thanks 

