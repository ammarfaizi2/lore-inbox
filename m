Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUF3NXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUF3NXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUF3NXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:23:13 -0400
Received: from web81306.mail.yahoo.com ([206.190.37.81]:11691 "HELO
	web81306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266663AbUF3NXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:23:05 -0400
Message-ID: <20040630132305.98864.qmail@web81306.mail.yahoo.com>
Date: Wed, 30 Jun 2004 06:23:05 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: Continue: psmouse.c - synaptics touchpad driver sync problem
To: Marc Waeckerlin <marc.waeckerlin@siemens.com>
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Mittwoch, 30. Juni 2004 08.02 schrieb Dmitry Torokhov unter "Re:
> Continue:
> psmouse.c - synaptics touchpad driver sync problem":
> > The mux got confused as to where the byte came from. They byte itself
> > seems to be in line with other data in the stream. At this moment your
> > mouse has probably started jumping around. The patch I send earlier
> > should help with this kind of problem.
> 
> Well, there are several things:
>  1) Cursor hangs on system load with internal mousepad
>     (no external mouse connected)

You mean when the system load is high? Yes, that can happen.. 

>  2) Cursor jumps a bit with internal mousepad
>     (no external mouse connected)
>  3) Cursor jumps like crazy when moving external mouse
>  4) Cursor randomly clicks when moving external mouse

Has the external mouse ever worked in 2.6? Or is it always
just randomly clickng stuff? Have you tried connecting another
mouse?

>  5) Hitting the mouse pad does not do a button1-click

I gather you do not have the X Synaptis driver installed?
Check out http://w1.894.telia.com/~u89404340/touchpad/index.html

>  6) Sometimes the keyboard does not work anymore or
>     sends neverending random events - even with no
>     external mouse/keyboard
> 
> I did not recognize that the previous patch helped in any of these
> problems, but No. 2 is the hardest to check, because I have to work
> for a while until it occurs.
> 
> The second patch does not help either.
> 
> The i8042.nodemux option only "resolved" No. 3 and No. 4, because the
> external mouse was no more available. Until now, nothing makes anything
> better.
>

Just to confirm - you are saying that the touchpad + external mouse
worked together fine in 2.4 but in 2.6 with i8042.nomux the external
mouse does not work, correct?
 
> 
> > > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12)
> [181878]
> > > Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <-
> i8042
> > > (interrupt, aux3, 12) [181880]
> 
> > Not quite sure what all this is about... Did you plug external keyboard
> > here?
> 
> Possible.
> 
> 
> > > [184574] Jun 28 16:01:22 qingwa kernel: drivers/input/serio/i8042.c:
> 00
> > > <- i8042 (interrupt, aux3, 12) [184576] Jun 28 16:01:22 qingwa kernel:
> > > drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12)
> [184585]
> 
> > It seems that we are missing a byte between ff and 18, delay between 2
> > bytes is about a second... Where did the byte go? Do you have DMA turned
> > on on your hard driver? Anything polling battery status? Can't do
> > anything here...
> 
> Do you mean hard disk DMA? Then Yes for DMA and yes for polling.
>

Ok, what program does the polling? What is the polling interval? Does
it help if you stop the program?

> 
> > Could you change drivers/input/mouse/psmouse-base.c - psmouse_interrupt()
> > in call to time time_after HZ/2 to HZ/4. You may see more "lost x bytes"
> > messages but I bet touchpad handling will feel much better.
> 
> I'll try if I can find out what you mean...
> ...ok, did the change.
> 
> As far as I understand, it has only effect on internal touchpad. I will
> therefore need some time for long time check. You'll hear from me later,
> but this surely won't resolve problems No. 2 - 6.
> 
> It is now together with your second patch, you first patch is no more in
> my sources. Is this good? (I understand that by "Vanilla" you mean the
> original source without your first patch?)

Yes.

--
Dmitry
