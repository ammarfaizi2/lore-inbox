Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273360AbRIWJeu>; Sun, 23 Sep 2001 05:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRIWJeb>; Sun, 23 Sep 2001 05:34:31 -0400
Received: from schmee.sfgoth.com ([63.205.85.133]:17931 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S273360AbRIWJeY>; Sun, 23 Sep 2001 05:34:24 -0400
Date: Sun, 23 Sep 2001 02:33:45 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tip@prs.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
Subject: Re: [PATCH] 2.4.10-pre13: ATM drivers cause panic
Message-ID: <20010923023345.C62864@sfgoth.com>
In-Reply-To: <3BAC93D4.65E17AA6@internetwork-ag.de> <E15kpDk-0003Xu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <E15kpDk-0003Xu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Sep 22, 2001 at 05:01:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Anyways, please find a (quick) patch below. It would be great if this patch or
> > any other similar could make it into the next release!
> > Thanks,
> 
> That patch cannot possibly be correct. alloc_atm_dev sleeps

Actually there are a LOT of places that atm_dev_lock is held across sleeps -
I've been meaning to deal with them for awhile.  Some of them are noted by
the Stanford checker, others are outside its reach (like calls into the
function pointers in atm_dev).  I've been meaning to fix it once and for all
by turning that spinlock into a semaphore, but have not had a chance to
audit the code and make sure that it will be safe in all circumstances.
I need to trace all the interrupt paths and see what their locking needs
are.

I'm not at home tonight so I can't look at the code much right now, but
I'll try to sort out what the best fix is and forward it on to you.

-Mitch
