Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTIZHZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 03:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTIZHZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 03:25:06 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:52098 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261967AbTIZHZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 03:25:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Date: Fri, 26 Sep 2003 02:24:53 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
References: <10645086121286@twilight.ucw.cz> <200309251323.33416.dtor_core@ameritech.net> <20030925223032.GA32130@ucw.cz>
In-Reply-To: <20030925223032.GA32130@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309260224.54264.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 September 2003 05:30 pm, Vojtech Pavlik wrote:
> On Thu, Sep 25, 2003 at 01:23:33PM -0500, Dmitry Torokhov wrote:
> > - Introducing BTN_TOUCH as far as I can seen does nothing to prevent
> > joydev grabbing either Synaptics or touchscreens... Is there a patch
> > missing?
>
> No. It's a statement you're missing near the beginning of
> joydev_connect().
>

Ok.. I see... and I hate it. We have a mechanism to match input devices to
input handler and we violate it. What could be done is adding a black list
to the input handler structure similar to the white list we have now. This
way all matching conditions will be kept in one place...

...But, unless I am missing something again, with introduction of BTN_TOUCH,
tsdev now will happily claim Synaptics touchpads. We could filter it out
by checking for example ABS_PRESSURE in tsdev but it would be just a another
band aid. I could easily see a touch screen reporting pressure and multiple
fingers. As far as capabilities go touchscreens are almost indistinguishable
from touch pads, they just operate as true absolute devices.

IMHO we should let input device driver explicitly request which input
handler it wishes to bind to (for example by passing a bitmap of desired
input handlers when registering input device and everyone binds to evdev). 
It is not as flexible as capabilities checking solution but much more 
simple and predictable. I do not thing that there will be that many handlers 
implemented...

Should I try to cook something along these lines?

> > BTW, any chance on including pass-through patches? Do you want me to
> > re-diff them?
>
> Hmm, I thought I've merged them in already, but obviously I did not.
> Please resend them (rediffed if possible). Thanks.

I meant reconnect patches that Peter sent in his last mail, sorry for the
confusion.

Dmitry
