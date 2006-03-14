Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752292AbWCNHVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbWCNHVP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 02:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbWCNHVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 02:21:15 -0500
Received: from cicero0.cybercity.dk ([212.242.40.52]:27871 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S1752292AbWCNHVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 02:21:14 -0500
From: Elias Naur <elias@oddlabs.com>
Organization: Oddlabs ApS
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Expose input device usages to userspace
Date: Tue, 14 Mar 2006 08:21:32 +0100
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <200603132154.38876.elias@oddlabs.com> <1142283779.3023.49.camel@laptopd505.fenrus.org> <200603140026.28522.dtor_core@ameritech.net>
In-Reply-To: <200603140026.28522.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603140821.32301.elias@oddlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 06:26, Dmitry Torokhov wrote:
> On Monday 13 March 2006 16:02, Arjan van de Ven wrote:
> > On Mon, 2006-03-13 at 21:54 +0100, Elias Naur wrote:
> > > Hi,
> > >
> > > I believe that the current event input interface is missing some kind
> > > of information about the general kind of input device (Mouse, Keyboard,
> > > Joystick etc.) so I added a simple ioctl to do just that. The relevant
> > > line in include/linux/input.h is:
> > >
> > > #define EVIOCGUSAGE(len)    _IOC(_IOC_READ, 'E', 0x1c, len)         /*
> > > get all usages */
> > >
> > > It returns a bit set with the device usages. Current usages are:
> > >
> > > #define USAGE_MOUSE         0x00
> > > #define USAGE_JOYSTICK      0x01
> > > #define USAGE_GAMEPAD       0x02
> > > #define USAGE_KEYBOARD      0x03
> >
> > I'm not sure that this is a good idea in general.
> > However when you do it, at least make it a bitmap; things can be both a
> > mouse and a keyboard for example.
>
> No, I don't think this is needed at all - users should be interested in
> what capabilities a particular device has, not what type it was assigned
> by soneone.

I see your point that an application should not rely too much on device 
usages. However, the main reason I want device usages is to help applications 
and users identify and (visually) represent devices. For example, games could 
show an appropriate icon graphic representing each active device. The event 
interface already has a few other ioctls for this kind of information:

 - The name (EVIOCGNAME).
 - The ID (EVIOCGID). IMHO, device usages are more useful than the "bustype" 
field of struct input_id.
 - The physical location (EVIOCGPHYS).

And speaking of capabilities, the event interface already exposes "types 
assigned by someone" to each device component (ABS_X, KEY_ESC, BTN_TRIGGER 
etc.). If no vendor assigned types should be exposed, only the raw capability 
(a type (abs axis, rel axis, key) and a struct input_absinfo for absolute 
axes) needed to interpret component values would be needed.

 - elias
