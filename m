Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261763AbRE2URd>; Tue, 29 May 2001 16:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbRE2URX>; Tue, 29 May 2001 16:17:23 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:59398 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S261763AbRE2URM>; Tue, 29 May 2001 16:17:12 -0400
From: sduchene@mindspring.com
Date: Tue, 29 May 2001 16:16:53 -0400
To: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
Cc: linux-kernel@vger.kernel.org, Louis Garcia <louisg00@bellsouth.net>
Subject: Re: console colors messed up with 2.4.X Rivafb driver
Message-ID: <20010529161653.B21851@lapsony.mydomain.here>
In-Reply-To: <20010529102920.H790@mug.hdqt.valinux.com> <3B13D688.12981.6392980@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
In-Reply-To: <3B13D688.12981.6392980@localhost>; from fero@drama.obuda.kando.hu on Tue, May 29, 2001 at 05:03:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 05:03:54PM +0200, Bakonyi Ferenc wrote:
> 
> 	Hi!
> 
> Steven A. DuChene wrote:
> > I have a Riva128 based video card in a older SMP P-Pro system and with all
> > of the lastest 2.4 series of kernels (mostly the ac stuff) I have screwy colors
> > on the console (the penguin boot logos are shades of blue) and initially when
> > I start X (XFree86 4.0.3) the colors are very dark until I switch to a console
> > and back again. Once I switch to a console and back to X things are fine in
> Pressing 'ctrl alt +' and 'ctrl alt -' is enough. On Riva 128 cards 
> rivafb uses 8 bit color registers but XFree86 4.0.x still uses 6 bit 
> color registers.
> 
> >...
> > The fbset output on this system says:
> > 
> > mode "1280x1024-74"
> >     # D: 135.007 MHz, H: 78.859 kHz, V: 74.116 Hz
> >     geometry 1280 1024 1280 1024 16
> >     timings 7407 256 32 34 3 144 3
> >     accel true
> >     rgba 5/11,6/5,5/0,0/0
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This line indicates you are using rivafb in 16 bpp mode. Unfortunetly 
> 16 bpp is not supported by Riva 128 hw. It's a bug, in a perfect 
> world rivafb should disable 16 bpp mode on Riva 128. In this case 
> hardware is set to 15 bpp, but rivafb thinks it's set to 16 bpp. (Or 
> something similar.)
> 
> Fastest solution: try using 15 bpp or 32 bpp.

Well, since the video card only has 4Mb of memory I tried 15 bpp but then
I kept getting a kernel Opps from a function in the rivafb driver. I will
try to catch it to see an exact error but it is difficult as the Opps
eventually halts the system and the error is not capturable.

> 
> > endmode
> > 
> > The same thing still occurs if I set the color depth to 8 bit.
> If you boot with 8 bpp and you do not use X, console and logo colors 
> should be fine. Please detail this problem!

I did boot with 8 bpp and it does indeed seem to be fine. Got two correctly
colored penguin logos and system did not Opps.

BTW, when the system Opps with 15 bpp I don't see the penguin logos at all.
There is blank space at the top of the screen during booting where they
would normally be displayed but they aren't there.

With the screwed up colors (but no-Opps'ing system) at 16 bpp I do see the
two penguin logos but as I said they are various shades of blue only.

> 
> > 
> > This is a pci card with 4Mb of video memory. I also have a AMD K6 system with a 16Mb
> > AGP TNT2 card and this does not happen on that machine.
> > 
> > BTW, why is the mtrr for the Riva set to 0M ???
> Because you said yes to 'Processor type and features ---> MTRR 
> (Memory Type Range Register) support'.
> 

Shouldn't that indicate that the system should allocate & use mtrr registers &
memory? It does on other systems I have.
-- 
Steven A. DuChene	sad@ale.org
			sad@valinux.com
			sduchene@mindspring.com

	http://www.mindspring.com/~sduchene/
