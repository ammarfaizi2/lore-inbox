Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbUJZJpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbUJZJpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 05:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbUJZJpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 05:45:11 -0400
Received: from sd291.sivit.org ([194.146.225.122]:17796 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262200AbUJZJpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 05:45:02 -0400
Date: Tue, 26 Oct 2004 11:46:13 +0200
From: Stelian Pop <stelian@popies.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041026094613.GD2998@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr> <20041025135036.GA3161@crusoe.alcove-fr> <20041025135742.GA1733@ucw.cz> <20041025144549.GD3161@crusoe.alcove-fr> <20041025151120.GA1802@ucw.cz> <20041025152023.GE3161@crusoe.alcove-fr> <20041025160427.GA2002@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041025160427.GA2002@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 06:04:27PM +0200, Vojtech Pavlik wrote:

> > KeyRelease event, serial 24, synthetic NO, window 0x2a00001,
> >     root 0x40, subw 0x2a00002, time 6566259, (37,47), root:(542,70),
> >     state 0x20, keycode 214 (keysym 0x8f6, function), same_screen YES,
> >     XLookupString gives 0 bytes: 
>  
> Watch the "state" variable.

Indeed, I didn't noticed it.

However, this still doesn't work as expected. I looked at WindowMaker's
code for grabbing a key and found out it uses the standard IsModifierKey
macro, which is defined in X11/Xutil.h as:

#define IsModifierKey(keysym) \
  ((((KeySym)(keysym) >= XK_Shift_L) && ((KeySym)(keysym) <= XK_Hyper_R)) \
  || (((KeySym)(keysym) >= XK_ISO_Lock) && \
       ((KeySym)(keysym) <= XK_ISO_Last_Group_Lock)) \
  || ((KeySym)(keysym) == XK_Mode_switch) \
  || ((KeySym)(keysym) == XK_Num_Lock))

So it clearly handles only some special modifier keys.

Moreover, the xkeycaps manpage (available at
http://wwwvms.mppmu.mpg.de/unix_man_pages/xkeycaps.html) goes a bit
more in-depth and says:

   Modifier Bit
                 Modifier  bits  are  attributes  which   certain
                 keysyms  can have.  Some modifier bits have pre­
                 defined semantics:  Shift,  Lock,  and  Control.
                 The  remaining modifier bits (Mod1 through Mod5)
                 have semantics which are  defined  by  the  keys
                 with which they are associated.

So I'm back where I started, I cannot see how to define my new
'Fn' key to be interpreted as a 'ModX' modifier by X.

I will probably go now the new evdev based X driver, and will use
new, above 240, keycodes for all key combinations. Provided the
Gentoo patches build and work correctly.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
