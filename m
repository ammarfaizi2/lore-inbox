Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVKYVlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVKYVlb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVKYVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 16:41:31 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:12695 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932165AbVKYVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 16:41:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Date: Fri, 25 Nov 2005 16:41:24 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Marc Koschewski <marc@osknowledge.org>, Ed Tomlinson <tomlins@cam.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <20051125082253.GA13959@ucw.cz> <200511252216.23439.rjw@sisk.pl>
In-Reply-To: <200511252216.23439.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251641.25284.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 16:16, Rafael J. Wysocki wrote:
> On Friday, 25 of November 2005 09:22, Vojtech Pavlik wrote:
> > On Thu, Nov 24, 2005 at 10:20:25PM +0100, Rafael J. Wysocki wrote:
> > > Update:
> > > 
> > > On Thursday, 24 of November 2005 21:23, Rafael J. Wysocki wrote:
> > > > On Thursday, 24 of November 2005 13:44, Marc Koschewski wrote:
> > > > }-- snip --{
> > > > > > It looks like you are seeing a different bug.  The one opened for debian user space
> > > > > > covers mousedev not being loaded if the kernel is 2.6.15, which leads to no /dev/input
> > > > > > 
> > > > > 
> > > > > That's what I think, thus the report on LKLM. But noone but me seems to
> > > > > be trapped into it until... :/
> > > > 
> > > > FWIW, my touchpad doesn't work with -rc2-mm1 too (usually I use a USB mouse,
> > > > so I didn't notice before).  Here's what dmesg says about it:
> > > > 
> > > > Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
> > > > input: SynPS/2 Synaptics TouchPad as /class/input/input2
> > > > 
> > > > The box is an Asus L5D (x86-64).
> > > 
> > > Actually, it works on the console (ie with gpm), but X is unable to use it,
> > > apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
> > > non-mm kernel I've been able to test quickly on this box).
> > > 
> > > Marc, does your touchpad work with gpm?
> >  
> > What's in your relevant xorg.conf sections?
> 
> Section "ServerFlags"
>   Option       "AllowMouseOpenFail"
> EndSection
> 
> Section "InputDevice"
>   Driver       "mouse"
>   Identifier   "Mouse[1]"
>   Option       "Device" "/dev/input/mice"
>   Option       "Name" "Logitech Optical USB Mouse"
>   Option       "Protocol" "explorerps/2"
>   Option       "Vendor" "Sysp"
>   Option       "ZAxisMapping" "4 5"
> EndSection
> 
> Section "InputDevice"
>   Driver       "synaptics"
>   Identifier   "Mouse[3]"
>   Option       "Device" "/dev/input/mice"
>   Option       "Emulate3Buttons" "on"
>   Option       "InputFashion" "Mouse"
>   Option       "Name" "Synaptics;Touchpad"
>   Option       "Protocol" "explorerps/2"
>   Option       "SHMConfig" "on"
>   Option       "Vendor" "Sysp"
>   Option       "ZAxisMapping" "4 5"
> EndSection
> 
> Section "ServerLayout"
>   Identifier   "Layout[all]"
>   InputDevice  "Keyboard[0]" "CoreKeyboard"
>   InputDevice  "Mouse[1]" "CorePointer"
>   InputDevice  "Mouse[3]" "SendCoreEvents"
>   Option       "Clone" "off"
>   Option       "Xinerama" "off"
>   Screen       "Screen[0]"
> EndSection
> 

Ok, so you are using Synaptics driver. Does you have evdev module loaded
and do you have /dev/input/eventX nodes created? If not that would explain
why the touchpad is not working in X.

-- 
Dmitry
