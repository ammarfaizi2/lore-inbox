Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSGGVX4>; Sun, 7 Jul 2002 17:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316585AbSGGVXz>; Sun, 7 Jul 2002 17:23:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:20890 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316582AbSGGVXy>;
	Sun, 7 Jul 2002 17:23:54 -0400
Date: Sun, 7 Jul 2002 23:26:23 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org
Subject: Re: dead keyboard in lk 2.5.25
Message-ID: <20020707232623.A10762@ucw.cz>
References: <3D284E20.D5D00F99@torque.net> <20020707164554.B15933@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020707164554.B15933@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Jul 07, 2002 at 04:45:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 07, 2002 at 04:45:54PM +0100, Russell King wrote:
> On Sun, Jul 07, 2002 at 10:20:16AM -0400, Douglas Gilbert wrote:
> > --- linux/drivers/input/serio/i8042.c	Sat Jul  6 08:57:35 2002
> > +++ linux/drivers/input/serio/i8042.c2525fix	Sun Jul  7 09:52:50 2002
> > @@ -269,8 +269,11 @@
> >   */
> >  
> >  	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
> > -		printk(KERN_ERR "i8042.c: Can't get irq %d for %s\n", values->irq, values->name);
> > -		return -1;
> > +		free_irq(values->irq, NULL);
> > +		if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
> > +			printk(KERN_ERR "i8042.c: Can't get irq %d for %s\n", values->irq, values->name);
> > +			return -1;
> > +		}
> >  	}
> >  
> >  /*
> 
> Hmm, interesting concept.  "If someone else is using my resource, I'll
> free it for them, and re-claim it".  It sounds very much like a hack
> rather than a fix to me.
> 
> I'd guess the real solution would be to stop pc_keyb being initialised
> when you're trying to use i8042.c.  Vojtech?

The real solution is to delete pc_keyb.c. But that'll take some time
yet. i8042.c is there so that the build problems, and other obvious
stuff gets fixed. Later we can start actually using it.

-- 
Vojtech Pavlik
SuSE Labs
