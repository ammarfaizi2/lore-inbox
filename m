Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSG3V6O>; Tue, 30 Jul 2002 17:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSG3V6O>; Tue, 30 Jul 2002 17:58:14 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:31190 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316842AbSG3V6N>;
	Tue, 30 Jul 2002 17:58:13 -0400
Date: Wed, 31 Jul 2002 00:00:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Fix suspend of the kseriod thread
Message-ID: <20020731000042.A24349@ucw.cz>
References: <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz> <20020730225736.K7677@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020730225736.K7677@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Jul 30, 2002 at 10:57:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 10:57:36PM +0100, Russell King wrote:
> On Tue, Jul 30, 2002 at 10:17:22PM +0200, Vojtech Pavlik wrote:
> >  	do {
> >  		serio_handle_events();
> > +		interruptible_sleep_on(&serio_wait); 
> >  		if (current->flags & PF_FREEZE)
> >  			refrigerator(PF_IOTHREAD);
> > -		interruptible_sleep_on(&serio_wait); 
> >  	} while (!signal_pending(current));
> 
> Isn't interruptible_sleep_on() taboo?

As far as I know it only implies a bug when used with some condition,
like "buffer non-empty" etc. As always, I may be wrong, of course.

-- 
Vojtech Pavlik
SuSE Labs
