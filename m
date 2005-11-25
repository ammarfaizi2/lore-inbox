Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVKYNuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVKYNuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbVKYNuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:50:23 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:38076 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932673AbVKYNuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:50:23 -0500
Date: Fri, 25 Nov 2005 14:50:30 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Marc Koschewski <marc@osknowledge.org>, Ed Tomlinson <tomlins@cam.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: psmouse unusable in -mm series (was: 2.6.15-rc1-mm2 unsusable on DELL Inspiron 8200, 2.6.15-rc1 works fine)
Message-ID: <20051125135030.GB6728@stiffy.osknowledge.org>
References: <20051118182910.GJ6640@stiffy.osknowledge.org> <20051124124444.GA23667@stiffy.osknowledge.org> <200511242124.00127.rjw@sisk.pl> <200511242220.25702.rjw@sisk.pl> <20051125082253.GA13959@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051125082253.GA13959@ucw.cz>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc2-marc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vojtech Pavlik <vojtech@suse.cz> [2005-11-25 09:22:53 +0100]:

> On Thu, Nov 24, 2005 at 10:20:25PM +0100, Rafael J. Wysocki wrote:
> > Update:
> > 
> > On Thursday, 24 of November 2005 21:23, Rafael J. Wysocki wrote:
> > > On Thursday, 24 of November 2005 13:44, Marc Koschewski wrote:
> > > }-- snip --{
> > > > > It looks like you are seeing a different bug.  The one opened for debian user space
> > > > > covers mousedev not being loaded if the kernel is 2.6.15, which leads to no /dev/input
> > > > > 
> > > > 
> > > > That's what I think, thus the report on LKLM. But noone but me seems to
> > > > be trapped into it until... :/
> > > 
> > > FWIW, my touchpad doesn't work with -rc2-mm1 too (usually I use a USB mouse,
> > > so I didn't notice before).  Here's what dmesg says about it:
> > > 
> > > Synaptics Touchpad, model: 1, fw: 5.9, id: 0x926eb1, caps: 0x804719/0x0
> > > input: SynPS/2 Synaptics TouchPad as /class/input/input2
> > > 
> > > The box is an Asus L5D (x86-64).
> > 
> > Actually, it works on the console (ie with gpm), but X is unable to use it,
> > apparently.  However it used to be, at least on 2.6.14-git9 (this is the latest
> > non-mm kernel I've been able to test quickly on this box).
> > 
> > Marc, does your touchpad work with gpm?
>  
> What's in your relevant xorg.conf sections?

Section "InputDevice"
	Identifier	"id_mouse"
	Driver		"mouse"
	Option		"CorePointer"
	Option		"Device"		"/dev/input/mice"
	Option		"Protocol"		"ImPS/2"
	Option		"ZAxisMapping"		"4 5"
EndSection

Section "ServerLayout"
	Identifier	"home"
	Screen 0	"id_screen_lcd" 0 0
	InputDevice	"id_mouse"		"CorePointer"
	InputDevice	"id_keyboard"		"CoreKeyboard"
	#Option		"Xinerama"		"on"
	Option		"Xinerama"		"off"
EndSection

Section "ServerFlags"
	Option		"AllowMouseOpenFail"	"true"
	Option		"DontZap"		"true"
	Option		"DontVTSwitch"		"false"
	Option		"DefaultServerLayout"	"home"
EndSection

