Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277347AbRJOJZu>; Mon, 15 Oct 2001 05:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277353AbRJOJZl>; Mon, 15 Oct 2001 05:25:41 -0400
Received: from web11802.mail.yahoo.com ([216.136.172.156]:32521 "HELO
	web11802.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277347AbRJOJZd>; Mon, 15 Oct 2001 05:25:33 -0400
Message-ID: <20011015092605.55285.qmail@web11802.mail.yahoo.com>
Date: Mon, 15 Oct 2001 11:26:05 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: specific optimizations for unaccelerated framebuffers
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011006003547.A42@toy.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >   I am not speaking of DMA'ing at the refresh frequency (approx 70 times
> >  per second the complete video memory), just the modified 64Kb blocks,
> >  "once upon a while": if a single pixel is written twice, you will just
> >  see the latter written value on the screen - but who cares.
> >   Been able to DMA the complete video memory image around 5-10
> >  times/second should be over the human eye sensitivity.
> 
> Yep, that should work. Same trick as xterm uses.
> 								Pavel

  Will be a bit more complex than xterm/curses. One of the problem
 is that using the VESA1 interface is needed (DMA restrictions), so
 you need to get back the array given by the Gujin bootloader, describing
 which I/O port to use to switch the 32/64K window at 0xA0000. You do not
 want to go back to real-mode at every VESA1 page change.
 (This array is already available with the current Gujin, using it is
 Gujin native mode for VESA1 cards)

> [Of course, user *will* see you are only updating at 5fps... But it will
> be way beter than current slowness.]

  And the only usual "fast changing" thing is the mouse, so either use a
 hardware extension of the video card or direct PCI write for it only.

 My main question was which bandwidth the standard DMA is able to do
 for memory to memory copy, if it is too slow, do not even start
 to code anything... got no answer. The PC DMA can only copy memory by
 16 bit units - and I am not sure it will behave correctly with
 PCI stalls.

> Are you going to create a patch?

  Lets say, I start just after I finish Gujin; i.e. if you want to see
 something before Linux 3.1, find someone else... I can still help a bit.

  Etienne.

___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
