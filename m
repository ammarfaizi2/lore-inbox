Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131129AbRCGW56>; Wed, 7 Mar 2001 17:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCGW5s>; Wed, 7 Mar 2001 17:57:48 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35728 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131129AbRCGW5k>;
	Wed, 7 Mar 2001 17:57:40 -0500
Message-ID: <3AA6BCB3.F74C4ED7@mandrakesoft.com>
Date: Wed, 07 Mar 2001 17:56:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx
In-Reply-To: <200103072243.f27MhdO31896@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> How often is the list manipulated?  My guess is not very often.

Modified very infrequently...  at boot, and for each hotplug insertion
or removal.  It's not even read very often.


> You can allow people to read the list without taking a spinlock and
> only acquire the spinlock on list manipulations.  Inserting an
> element can be performed atomically so there isn't an SMP issue
> so long as you don't allow more than one processor to insert at
> the same time.  This would allow you to perform insertion sort
> meaning that everything from /proc to device drivers auto-magically
> sees the devices in the order they were probed.

I was just thinking the same thing.  list_splice and an insertion sort
can be used instead of all that allocation crap.


> For hot plug devices
> you might want to insert them at the end to follow the "order probed"
> motif.

hmmm..  Is there a reason why this would be -needed-?  It wouldn't be
hard to implement, but I would rather not have drivers dealing with a
list whose normal state is defined as "mostly sorted"...

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
