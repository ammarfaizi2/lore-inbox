Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTIBIHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbTIBIHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:07:50 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:22681 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263601AbTIBIHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:07:48 -0400
Date: Tue, 2 Sep 2003 10:07:33 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Re:Re: Linux 2.6.0-test4
Message-ID: <20030902080733.GA14380@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030831120605.08D6.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831120605.08D6.CHRIS@heathens.co.nz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Heath <chris@heathens.co.nz>:
> > Aug 27 18:53:41 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > Aug 27 19:15:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
> > Aug 27 19:42:50 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > Aug 28 10:14:14 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
> > 
> > Basically, CTRL was stuck. Even when I switched to X11.
> 
> Well, this completely baffles me.  I thought X11 maintains its own
> keydown array.
> 
> Anyway, I've included a patch that should hopefully give us better
> debugging information.  When you get an unknown key error, it will also
> dump the last 16 bytes that were sent from the keyboard.  Be careful
> with this one.  If you post any errors to the list, make sure it doesn't
> contain any sensitive passwords. :-)

I got some more events, and today I even was able to reproduc the
"CTRL-is-stuck" problem.

I was able to get the key unstuck by switching back and forth between
dirrerent FB consoles and by pushing and releaseing CTRL in them...

Sep  2 09:10:01 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9c, on isa0060/serio0) pressed.
Sep  2 09:10:01 hummus2 kernel: i8042 history: e0 d0 1c 9c 2e ae 10 90 e0 50 e0 d0 e0 d0 1c 9c

Sep  2 09:10:06 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xa0, on isa0060/serio0) pressed.
Sep  2 09:10:06 hummus2 kernel: i8042 history: 1c 9c 1c 9c e0 50 e0 d0 e0 50 e0 d0 e0 d0 20 a0

Sep  2 09:14:54 hummus2 kernel: input: AT Set 2 keyboard on isa0060/serio0

Sep  2 09:25:44 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0x9d, on isa0060/serio0) pressed.
Sep  2 09:25:44 hummus2 kernel: i8042 history: e0 50 e0 d0 e0 50 e0 d0 e0 d0 1d 2d ad 1f 9f 9d

Sep  2 09:30:34 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
Sep  2 09:30:34 hummus2 kernel: i8042 history: e0 48 e0 c8 39 b9 e0 38 56 d6 e0 b8 e0 b8 39 b9

Sep  2 09:35:51 hummus2 kernel: atkbd.c: Unknown key (set 2, scancode 0xb9, on isa0060/serio0) pressed.
Sep  2 09:35:51 hummus2 kernel: i8042 history: a0 20 a0 9d e0 4d e0 cd e0 4d e0 cd e0 cd 39 b9

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
