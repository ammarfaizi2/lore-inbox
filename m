Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUF3M6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUF3M6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266656AbUF3M6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:58:34 -0400
Received: from david.siemens.de ([192.35.17.14]:6098 "EHLO david.siemens.de")
	by vger.kernel.org with ESMTP id S265891AbUF3M6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:58:30 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Wed, 30 Jun 2004 14:58:04 +0200
User-Agent: KMail/1.6
Cc: laflipas@telefonica.net, linux-kernel@vger.kernel.org, t.hirsch@web.de,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20040629143232.52963.qmail@web81303.mail.yahoo.com> <200406291253.10542.dtor_core@ameritech.net> <200406300102.16083.dtor_core@ameritech.net>
In-Reply-To: <200406300102.16083.dtor_core@ameritech.net>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301458.04705.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 30 Jun 2004 12:58:07.0853 (UTC) FILETIME=[E3D7C1D0:01C45EA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 30. Juni 2004 08.02 schrieb Dmitry Torokhov unter "Re: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> The mux got confused as to where the byte came from. They byte itself seems
> to be in line with other data in the stream. At this moment your mouse has
> probably started jumping around. The patch I send earlier should help with
> this kind of problem.

Well, there are several things:
 1) Cursor hangs on system load with internal mousepad
    (no external mouse connected)
 2) Cursor jumps a bit with internal mousepad
    (no external mouse connected)
 3) Cursor jumps like crazy when moving external mouse
 4) Cursor randomly clicks when moving external mouse
 5) Hitting the mouse pad does not do a button1-click
 6) Sometimes the keyboard does not work anymore or 
    sends neverending random events - even with no
    external mouse/keyboard

I did not recognize that the previous patch helped in any of these problems, 
but No. 2 is the hardest to check, because I have to work for a while until 
it occurs.

The second patch does not help either.

The i8042.nodemux option only "resolved" No. 3 and No. 4, because the external 
mouse was no more available. Until now, nothing makes anything better.


> > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12) [181878]
> > Jun 28 16:01:20 qingwa kernel: drivers/input/serio/i8042.c: 00 <- i8042
> > (interrupt, aux3, 12) [181880]

> Not quite sure what all this is about... Did you plug external keyboard
> here?

Possible.


> > [184574] Jun 28 16:01:22 qingwa kernel: drivers/input/serio/i8042.c: 00
> > <- i8042 (interrupt, aux3, 12) [184576] Jun 28 16:01:22 qingwa kernel:
> > drivers/input/serio/i8042.c: 18 <- i8042 (interrupt, aux3, 12) [184585]

> It seems that we are missing a byte between ff and 18, delay between 2
> bytes is about a second... Where did the byte go? Do you have DMA turned on
> on your hard driver? Anything polling battery status? Can't do anything
> here...

Do you mean hard disk DMA? Then Yes for DMA and yes for polling.


> Could you change drivers/input/mouse/psmouse-base.c - psmouse_interrupt()
> in call to time time_after HZ/2 to HZ/4. You may see more "lost x bytes"
> messages but I bet touchpad handling will feel much better.

I'll try if I can find out what you mean...
...ok, did the change.

As far as I understand, it has only effect on internal touchpad. I will 
therefore need some time for long time check. You'll hear from me later, but 
this surely won't resolve problems No. 2 - 6.

It is now together with your second patch, you first patch is no more in my 
sources. Is this good? (I understand that by "Vanilla" you mean the original 
source without your first patch?)


Regards
Marc
