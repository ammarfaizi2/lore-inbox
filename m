Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265397AbSJaWES>; Thu, 31 Oct 2002 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSJaWES>; Thu, 31 Oct 2002 17:04:18 -0500
Received: from [195.39.17.254] ([195.39.17.254]:14852 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S265392AbSJaWDH>;
	Thu, 31 Oct 2002 17:03:07 -0500
Date: Thu, 31 Oct 2002 22:36:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: prevent swsusp from eating disks
Message-ID: <20021031213625.GA4331@elf.ucw.cz>
References: <1036006956.5141.117.camel@irongate.swansea.linux.org.uk> <20021031013942.25199@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031013942.25199@192.168.4.1>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Another is that I feel (and I know Pavel doesn't agree here) that
> >> the disk driver should also block further incoming requests (that
> >> is leave them in the queue) instead of panic'ing. That is the
> >> driver should not rely on not beeing fed any more request, but
> >> rather make sure it will leave them in the queue and deal with
> >> them when resumed.
> >
> >It is cleaner if the ordering of power off is right. If the model is
> >right then the first suspend would be the drives. Part of drive suspend
> >ought to be corking the queue.
> 
> Yup.
> 
> My point here is that while Pavel approach is to kill/suspend anything
> that may trigger new IO requests (thus topping all userland, stopping
> selected kernel threads, etc...), I tend to think we leave all that
> alive, and just block requests going to suspended devices until those
> get alive again. That used to work well on pmac and leads to very
> fast suspend/resume cycles.

I believe it is simpler to do my way ;-). Of couse, adding stopping to
drivers will only add robustness and may enable faster suspends in
future (I do not think it is going to be significant)....

								Pavel
-- 
When do you have heart between your knees?
