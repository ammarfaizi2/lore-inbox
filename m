Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTAVGOx>; Wed, 22 Jan 2003 01:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTAVGOx>; Wed, 22 Jan 2003 01:14:53 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:41344 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267352AbTAVGOw>; Wed, 22 Jan 2003 01:14:52 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Greg Ungerer <gerg@snapgear.com>, <linux-kernel@vger.kernel.org>
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301212339540.8909-100000@chaos.physics.uiowa.edu>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 22 Jan 2003 15:23:48 +0900
In-Reply-To: <Pine.LNX.4.44.0301212339540.8909-100000@chaos.physics.uiowa.edu>
Message-ID: <buod6mp8zyj.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:
> Yes, I saw it, but on the other hand I'd like to avoid introducing
> complexity which isn't really needed.

Actually as far as I can see, my suggested alternative is _less_ complex
than the current RODATA.

It seems to me that the absolutely most straight-forward solution is to
have a single macro that groups input sections and symbol defs, and is
simply embeddable into any old output section, i.e. RODATA_CONTENTS
(note that it's actually shorter than RODATA).  Is there some reason
why multiple output sections are actually necessary?

Also, I've found that defining symbols outside the sections, like RODATA
does, to be somewhat dangerous, and have had much better luck defining
them inside the sections whenever possible (sometimes it isn't, of
course, but none of the RODATA symbols appear to have any problems).

> So the important question is:  Is there a reason that v850 does things
> differently, or could it just as well live with separate .text and
> .rodata sections.

It's not that it _needs_ to group things inside a single output section
(though often doing so is just simpler), but it _does_ need more control
over the output sections than is provided by the current RODATA macro:
at least, it needs to be able to specify which memory regions the
various sections go, sometimes at separate link- and run-time addresses
(i.e., a "> MEM AT> OTHER_MEM" directive following each output section).

-Miles
-- 
A zen-buddhist walked into a pizza shop and
said, "Make me one with everything."
