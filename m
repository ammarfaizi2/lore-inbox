Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbSJYI6i>; Fri, 25 Oct 2002 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261324AbSJYI6i>; Fri, 25 Oct 2002 04:58:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3090 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261323AbSJYI6g>; Fri, 25 Oct 2002 04:58:36 -0400
Date: Fri, 25 Oct 2002 10:04:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Armin Schindler <mac@melware.de>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: module_init in interrupt context ?
Message-ID: <20021025100446.A19910@flint.arm.linux.org.uk>
Mail-Followup-To: Armin Schindler <mac@melware.de>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0210241208130.6574-100000@chaos.physics.uiowa.edu> <Pine.LNX.4.31.0210250806470.24067-100000@phoenix.one.melware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.31.0210250806470.24067-100000@phoenix.one.melware.de>; from mac@melware.de on Fri, Oct 25, 2002 at 08:15:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 08:15:05AM +0200, Armin Schindler wrote:
> > You are never allowed to sleep with a spinlock held, no matter if it's
> > _bh, _irq or just a plain spin_lock(). Doing so creates the possibility of
> > deadlock (assuming your lock actually is necessary and you're not
> > serialized already), current 2.5 btw has debugging code which checks for
> > this bug.
> >
> > So this code was buggy in earlier 2.4 as well, you'll have to create your
> > proc entry outside the protected region or use a semaphore instead of a
> > spinlock.
> 
> Okay, I wasn't aware of create_proc_entry() must to be called
> from user-context and outside any locks.
> 
> But anyway, isn't the statement "in_interrupt() != 0" somehow wrong
> when just the bh's are disabled ?

You must not schedule with bottom halves disabled.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

