Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319094AbSIDICm>; Wed, 4 Sep 2002 04:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319099AbSIDICm>; Wed, 4 Sep 2002 04:02:42 -0400
Received: from [62.40.73.125] ([62.40.73.125]:30890 "HELO Router")
	by vger.kernel.org with SMTP id <S319094AbSIDICi>;
	Wed, 4 Sep 2002 04:02:38 -0400
Date: Tue, 3 Sep 2002 00:30:26 +0200
From: Jan Hudec <bulb@cimice.maxinet.cz>
To: Oliver Neukum <oliver@neukum.name>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
Subject: Re: question on spinlocks
Message-ID: <20020902223026.GB30964@vagabond>
Mail-Followup-To: Jan Hudec <bulb@cimice.maxinet.cz>,
	Oliver Neukum <oliver@neukum.name>,
	Thunder from the hill <thunder@lightweight.ods.org>,
	Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209011607380.3234-100000@hawkeye.luckynet.adm> <200209020033.23113.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209020033.23113.oliver@neukum.name>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 12:33:23AM +0200, Oliver Neukum wrote:
> Am Montag, 2. September 2002 00:09 schrieb Thunder from the hill:
> > Hi,
> >
> > On Mon, 2 Sep 2002, Oliver Neukum wrote:
> > > > > No; spin_lock_irqsave/spin_unlock_irqrestore and
> > > > > spin_lock/spin_unlock have to be used in matching pairs.
> > > >
> > > > If it was his least problem! He'll run straight into a "schedule
> > > > w/IRQs disabled" bug.
> > >
> > > OK, how do I drop an irqsave spinlock if I don't have flags?
> >
> > IMHO you might even ask "How do I start a car when I don't have the
> > keys?"
> 
> Break off the lock, touch some cables ... ;-)
> 
> > You might find a way, but it's not desired. Are you sure you want to
> > reschedule in an interrupt handler? If it's none, are you sure you want
> > to disable interrupts?
> 
> I am not in an interrupt handler. It's not my fault that the scsi layer
> calls queuecommand with a spinlock held. But I need to sleep,
> I have to get rid of that spinlock's effects. If possible I even want
> interrupts to be enabled.

If it's calling it with spinlock held, it probably relies on that it
won't be sleeping. So you either have to avoid sleeping (start now,
finish in tasklet) or patch the calling code.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
