Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316797AbSEVAPX>; Tue, 21 May 2002 20:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316798AbSEVAPW>; Tue, 21 May 2002 20:15:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18704 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316797AbSEVAPW>; Tue, 21 May 2002 20:15:22 -0400
Date: Wed, 22 May 2002 02:15:25 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020522001525.GG27021@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020521233312.GA27021@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44.0205211707001.3589-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I need to know more than they are sleeping. I also know they are
> > sleeping *without holding any semaphores*. I need working system to be
> > able to save state to disk. That's why I hacked it into signal
> > handler.
> 
> Sorry, I should have been more clear. I think the signal handler approach
> is fine for user processes, I was just wondering why you needed anything
> like that for kernel threads..
> 
> When a kernel thread is sleeping, I don't see that it has much state at
> all: it will be re-started anyway on the next boot, and I don't see it
> having any "state".

If that kernel thread is sleeping because it waits for disk, it has
some state, and I do not want to freeze it just now (because it might
hold some lock). I only want to freeze them at safe point, and it
seemed to me that for kernel threads it is easiest to mark safe points
by hand.

Does it compile for you for now?
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
