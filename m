Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTI0B6b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 21:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTI0B6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 21:58:31 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:7071 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262034AbTI0B63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 21:58:29 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Date: Fri, 26 Sep 2003 20:58:21 -0500
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>, akpm@osdl.org, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <10645086121286@twilight.ucw.cz> <200309260224.54264.dtor_core@ameritech.net> <20030926075408.GA7330@ucw.cz>
In-Reply-To: <20030926075408.GA7330@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309262058.21860.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 September 2003 02:54 am, Vojtech Pavlik wrote:
> On Fri, Sep 26, 2003 at 02:24:53AM -0500, Dmitry Torokhov wrote:
> > On Thursday 25 September 2003 05:30 pm, Vojtech Pavlik wrote:
> > > > BTW, any chance on including pass-through patches? Do you want me
> > > > to re-diff them?
> > >
> > > Hmm, I thought I've merged them in already, but obviously I did
> > > not. Please resend them (rediffed if possible). Thanks.
> >
> > I meant reconnect patches that Peter sent in his last mail, sorry for
> > the confusion.
>
> I don't think I'll apply those, sorry. We really should try to go the
> driver-model way and not invent our own ways how to restore devices
> hierarchically.

Reconnect patches are merely an extension of serio_rescan mechanism - the
only difference is that reconnect tries to keep the same input device if
the hardware didn't change. It does not care about any hierarchy, it just
a way for someone to try to re-initialize driver (probably the driver 
itself). I for example never suspend, but my docking station resets the
touch pad back to relative mode. With reconnect it is possible to dock
and undock with X and GPM running and it will not screw your input 
devices (rescan would create brand new input devices while X and GPM still
use old ones).

The pass-through support of all things implements device hierarchy in non 
driver-model way and you just included it. The entire input subsystem is not 
based on the driver model at the moment.. Are there plans to change it in 2.6
timeframe? If not for 2.6 then I would ask you to reconsider, reconnect will
make life of users much easier. If you have something in works could I have a
peek so I could probably adjust my patches.

BTW, is it possible with current driver model to reinitialize an arbitrary 
device, not entire bus?

Dmitry
