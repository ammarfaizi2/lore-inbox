Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262499AbSIZL1y>; Thu, 26 Sep 2002 07:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262501AbSIZL1y>; Thu, 26 Sep 2002 07:27:54 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:26889 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S262499AbSIZL1x>;
	Thu, 26 Sep 2002 07:27:53 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020926105853.A168142@ucw.cz>
References: <1032996672.11642.6.camel@chevrolet> 
	<20020926105853.A168142@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Sep 2002 13:32:59 +0200
Message-Id: <1033039991.708.6.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2002-09-26 kl. 10:58 skrev Vojtech Pavlik:
> On Thu, Sep 26, 2002 at 01:31:12AM +0200, Stian Jordet wrote:
> 
> > I haven't really tried a 2.5 kernel for a very long time. I used some of
> > the earliest, but then I suddenly had problems booting one of them, and
> > haven't really taken much effort in getting it boot lately.
> > 
> > But now I decided I should try again. I got 2.5.38 booted after some
> > initial trouble. But, I have a couple of weird problems. First, the
> > mouse. I have a Logitech Cordless Optical mouse. With kernel 2.4.x I use
> > MouseManPlusPS/2 as the XFree mouse-driver. Then I can use the wheel and
> > the fourth button just as expected. But with kernel 2.5.38 neither the
> > wheel or the fourth button works. I change protocol to IMPS/2 in XFree,
> > and everything works like expected, but the fourth button works just
> > like pussing the wheel (third button). This is excactly the same
> > behavior as with 2.4.20-pre7 (that's why I use MouseManPlusPS/2). Anyone
> > have a clue why this doesn't work with kernel 2.5.38?
> 
> Use ExplorerPS/2 in XFree to get access to all the buttons. The new
> input drivers handle the MouseMan protocol right in the kernel, and
> independently on the real mouse type (ImPS/2, ImExPS/2, GenPS/2,
> Logitech PS2++ USB, Busmouse, whatever) export an ExplorerPS/2-like
> virtual mouse to userspace. This is what most applications support
> correctly, and is compatible with generic PS/2 and ImPS/2 protocols also.

That did the trick, thank you very much :) And I see ExplorerPS/2 works
like a charm with 2.4.x as well, so everything is just fine :) I guess
this actually was a stupid question, and I'm sorry.

> 
> > Second problem, if I press SHIFT+PAGEUP, my computer freezes. It spits
> > out this message: "input: AT Set 2 keyboard on isa0060/serio0, and then
> > it's dead. I have a Logitech cordless keyboard. 
> > 
> > Anyone else experienced this?
> 
> I fixed this in about 2.5.36. Please #define ATKBD_DEBUG in
> drivers/input/keyboard/atkbd.c, and send me the kernel output just
> before the crash, please. I'll try to reproduce it here meanwhile.

I'm added #define ATKBD_DEBUG right below all the other define's in
atkbd.c, did a make clean; make dep; make bzImage and tried again. I
can't see any difference. It still just prints "input: AT Set 2 keyboard
on isa0060/serio0". I did, however, find out that if I press SHIFT+what
ever of the buttons arrows, insert, home, page up/down, delete and end,
I get just the same behaviour. It does not happen with CTRL or ALT.

Thank you very much.

Best regards,
Stian Jordet

