Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263063AbSJGOGj>; Mon, 7 Oct 2002 10:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263064AbSJGOGj>; Mon, 7 Oct 2002 10:06:39 -0400
Received: from 62-190-203-7.pdu.pipex.net ([62.190.203.7]:3080 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263063AbSJGOGg>; Mon, 7 Oct 2002 10:06:36 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210071417.g97EHDjG006197@darkstar.example.net>
Subject: Re: 2.5.X breaks PS/2 mouse
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Mon, 7 Oct 2002 15:17:13 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021007144250.A626@ucw.cz> from "Vojtech Pavlik" at Oct 07, 2002 02:42:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Pressing the left button, then the right button, (this is complete, and follows the above immediately):
> > > > 
> > > > i8042.c: 01 <- i8042 (interrupt, aux, 12) [230409]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230410]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230411]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230548]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230552]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [230554]
> > > > i8042.c: 02 <- i8042 (interrupt, aux, 12) [231505]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231506]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231507]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231694]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231695]
> > > > i8042.c: 00 <- i8042 (interrupt, aux, 12) [231696]
> > > > 
> > > > So, it definitely seems to be sending data to the port...  Strange...
> > > 
> > > It must work. I'm really wondering why it doesn't. What happens when you
> > > load the 'evbug' module?
> > 
> > I can't very easily - the kernel on the machine doesn't have kernel module
> > support enabled, and with 4MB RAM, it's really painfully slow to work with
> > if I use a kernel with modules enabled.  If there is no other way to debug
> > it, I can try, but it's a last resort :-)
> 
> Do you have 'evdev' (Event interface) compiled in? It'd be a replacement
> for evbug ...

I didn't, but I've compiled a new kernel with it in.  Unfortunately, it doesn't seem to do anything useful :-(.

cat /dev/input/eventX | hexdump

returns nothing, not even for keyboard events, which makes me think I've gone wrong somewhere :-/

> > Something that occurred to me, and I could be totally wrong here, but
> > is it possible that the trackball is being detected as a "generic
> > mouse" when it isn't one?
> 
> Most likely (95%) it behaves a generic ps/2 mouse. After all, it seems
> to send generic ps/2 data. Why the data isn't getting through, is the
> question.
> 
> > I tried connecting the generic mouse, disconnecting it, and then
> > connecting the trackball, and saw in dmesg that some kind of handshake
> > was going on.  This was completely different for mouse and trackball.
> > Would it be any use to post this output?
> 
> If it was different, then definitely!

Sorry, I was wrong, I think I pressed a mouse button whilst connecting it and mis-read the info.  The init is exactly the same.

However, the data sent from each one seems to be very different, (I've re-formatted this a bit to save space, but it's from the dmesg output):

mouse

 Left button - 09 00 00 08 00 00
Right button - 0a 00 00 08 00 00

trackball

 Left button - 01 00 00 00 00 00
Right button - 02 00 00 00 00 00

> > If the evbug module is the only way to go, I'll try it, but it'll
> > probably take me the rest of the day, (seriously) :-).
> 
> Let's try other ways before that.

Good idea :-)

John.
