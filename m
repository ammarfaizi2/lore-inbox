Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317891AbSGaKHz>; Wed, 31 Jul 2002 06:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317896AbSGaKHz>; Wed, 31 Jul 2002 06:07:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:32992 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317891AbSGaKHy>;
	Wed, 31 Jul 2002 06:07:54 -0400
Date: Wed, 31 Jul 2002 12:10:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Fix suspend of the kseriod thread
Message-ID: <20020731121054.A26396@ucw.cz>
References: <20020730225736.K7677@flint.arm.linux.org.uk> <20020730122638.A11153@ucw.cz> <20020730122918.A11248@ucw.cz> <20020730152255.A20071@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730221722.A22761@ucw.cz> <20020730225736.K7677@flint.arm.linux.org.uk> <9658.1028109354@redhat.com> <20020731115818.A26329@ucw.cz> <10657.1028110041@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10657.1028110041@redhat.com>; from dwmw2@infradead.org on Wed, Jul 31, 2002 at 11:07:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 11:07:21AM +0100, David Woodhouse wrote:

> vojtech@suse.cz said:
> >  Ok. Is the use in drivers/input/serio.c buggy? 
> 
> If it matters that the thread can miss wakeup events and sleep indefinitely 
> while there's a 'SERIO_RESCAN' event pending, then yes it looks buggy.
> 
> 	serio_thread()				serio_rescan()
> 	--------------				--------------
> 
> 	serio_handle_events();
> 						serio->event |= SERIO_RESCAN;
> 						wake_up(&serio_wait);
> 	sleep_on(&serio_wait);
> 
> 	...sleeps...
> 
> If both serio_thread() and serio_rescan() hold the BKL you're OK. It looks 
> like serio_rescan() doesn't, though.

Thanks for the explanation. Yes, this could happen.

> > What should be it replaced with?
> 
> In general, the response 'anything but sleep_on' is considered appropriate.
> Try wait_event().

-- 
Vojtech Pavlik
SuSE Labs
