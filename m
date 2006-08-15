Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWHODHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWHODHR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWHODHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:07:17 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:26292 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1752082AbWHODHP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:07:15 -0400
Date: Tue, 15 Aug 2006 05:06:59 +0200
From: Voluspa <lista1@comhem.se>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: lukesharkey@hotmail.co.uk, linux-kernel@vger.kernel.org,
       gene.heskett@verizon.net, ian.stirling@mauve.plus.com, davej@redhat.com,
       andi@rhlx01.fht-esslingen.de, malattia@linux.it
Subject: Re: Touchpad problems with latest kernels
Message-Id: <20060815050659.4b51e9a5.lista1@comhem.se>
In-Reply-To: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
References: <20060814190959.df449d55.lista1@comhem.se>
	<d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 15:27:52 -0400 Dmitry Torokhov wrote:
> On 8/14/06, Voluspa <lista1@comhem.se> wrote:
> >
> > On 2006-08-14 13:58:09 Luke Sharkey wrote:
> > > While on 2054 it generally works fine, On the latest kernels (2154,
> > > 2174 etc.)  I have only to e.g. open a konqueror window for the
> > > onscreen pointer to start going funny, and jerking about (As happens on
> > > computers with v. low RAM).  I know its not a RAM problem, as a)
> > > everything else works fine, there is no slow down of any of the
> > > programs I run, only problems with the mouse and b) I have just
> > > upgraded from 512 MB of RAM to 1 GB.
> > >
> > > If I plug in a mouse, the pointer works fine.  Though I would happily
> > > use a mouse, this is often inconvenient on a laptop.
> > >
> > > Do you have any ideas what's wrong?
> >
> > This is a known problem (and fixed in Windows) with the synaptics touch
> > pad. About one year ago I did a web search amounting to something like
> > "synaptics rubber band" and found a fixed windows driver. But since
> > there is no OS of that kind on this machine, I contacted the developer
> > of the synaptics X driver.
> >
> > We had a discussion (swedish only) in private mail, where I ran the
> > driver in debug mode - he no longer had a machine with that hardware.
> > Unfortunately I've lost the whole communication due to a voltage frying
> > of everything in the mail machine, so can not give any details.
> >
> > If Peter Österlund still has the e-mails I hereby give full permission
> > to disclose a translated copy to anyone interested.
> >
> > But I think it all came down to Peter not being able to do anything...
> > In earlier kernels the issue _seemed_ to lessen if booting with
> > i8042.nomux but nowadays that kernel option only gets rid of the 'lost
> > sync' messages from the pad that turn up in /var/log/messages
> > (Btw, excessive printing of that message Dmitry!)
> >
> 
> Hmm, have you tried lowering report rate of the synaptics driver
> (psmouse.rate=40)? 80 ppsm is quite high and I know some Toshibas have
> trouble handling the full rate...

I've tried it now (without i8042.nomux) though not much progress on
this Acer notebook. But first, let me expand on the original issue here.

Doing the "synaptics rubber band" web-search it is easy to locate the
_very_ informative windows-info-driver-patch page. Due to copyright I
can't quote enough of it to make sense (the page is good all the way to
the bottom!) so here's the link about Synaptics 'supersensitive' mode:

http://www.rm.com/Support/TechnicalArticle.asp?cref=TEC360005

The debug runs I performed for Peter confirmed all the symptoms
described, but the problem then becomes how to discern this crazy state
as not being an intentional 'two-finger' 'hard-pressure'
'palm-touching' one (upon which some kind of reset could be issued).

Unless someone establishes a contact with people at Synaptics or
disassembles the win driver, linux will stay with the loony tunes...

Ok, back to psmouse.rate=40 :

Aug 15 04:07:21 sleipner kernel: psmouse.c: TouchPad at
isa0060/serio4/input0 lost sync at byte 1
Aug 15 04:07:21 sleipner last message repeated 4 times
Aug 15 04:07:21 sleipner kernel: psmouse.c: issuing reconnect request

This came from 1 use of "cat /proc/acpi/thermal_zone/*/temp*" while
moving an xterm at the same time by way of the touch pad. Battery
readings are fine on this notebook - don't interfere with the input
system (anymore? Think ACPI has improved in this area).

Here's the next "cat /proc/acpi/thermal_zone/*/temp*":

Aug 15 04:07:45 sleipner kernel: psmouse.c: TouchPad at
isa0060/serio4/input0 lost sync at byte 4
Aug 15 04:07:45 sleipner kernel: psmouse.c: TouchPad at
isa0060/serio4/input0 lost sync at byte 1
Aug 15 04:07:45 sleipner kernel: psmouse.c: TouchPad at
isa0060/serio4/input0 - driver resynched.

Mvh
Mats Johannesson
