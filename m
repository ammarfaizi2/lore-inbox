Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289402AbSAOE1X>; Mon, 14 Jan 2002 23:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289411AbSAOE1O>; Mon, 14 Jan 2002 23:27:14 -0500
Received: from www.transvirtual.com ([206.14.214.140]:42002 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S289402AbSAOE1D>; Mon, 14 Jan 2002 23:27:03 -0500
Date: Mon, 14 Jan 2002 20:26:38 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev currcon
In-Reply-To: <20020115005650.J23429@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10201142006420.24302-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Jan 14, 2002 at 04:39:43PM -0800, James Simmons wrote:
> > [stuff about currcon]
> 
> I've killed currcon completely in the cyber2000fb driver in favour of
> tracking which struct display is current.  Tracking 'currcon', doing
> a whole pile of special cases, and copying 'var' stuff to/from fb.var
> didn't make sense anymore.  I'm expecting the same thing will happen
> with the other stuff in the struct fb_info.

But struct display is going to go away!!!!!! You haven't seen the complete
new fbdev api. How much cleaner and superior to the current stuff. 

http://linuxconsole.sf.net

   The whole point was to make the fbdev layer independent of the VT tty
system. It makes no sense to have a tty on something like a iPAQ. This way
you can a /dev/fb interface with no VT. You can also do other nice
things like have a vga console on one display and still have a fbdev
driver. Think about how much easier it would be to debug a fbdev driver
that way. BTW that is how I was testing the new fbdev api. Having printk 
on a vga terminal will looking at printks while testing the fbdev driver.
It was so nice. Plus the amount of code reduction will be huge. I mean
huge. 
   Over the years the lower level console drivers have been building crude
to make up for the limitations of the upper console layer. This will be
cleaned up for 2.5.X. So now fbcon will be a wrapper around the fbdev
layer if we do want to use a VT. It will make a very nice small footprint
for embedded systems. BTW this was my goal. Another bonus will be I will
make the VT system modular. So if we do want a VT we can :-) I haven't had
the time to do this but I plan to. I wanted to test it on a iPAQ with a
stowaway keyboard. Think about the power of insmod a keyboard driver,
fbcon.o and then insmod vt.o. Talk about having a even smaller kernel
image to put in a partition. Some devices only have 512K of space to
place a bootable kernel. As time goes on it is becoming harder and
harder to do this. Now we can!!!!!!

It just makes me excited thinking about it:-)

> (Think about the current cyber2000fb code, and what happens to other
> consoles when you fbset 800x600-60 -a and then switch to them to
> discover you only have a 640x480 window where the characters appear).

This will be fixed and very soon. Trust me. 

P.S
   currcon is a temporary step to deal with the issue of only one foreground 
console. It will also GO AWAY as the console system is truly fixed to
support multiple desktops. Yes I have such a system at home so it is
possible. The only reason I'm doing it this way is so when I start
changing the console layer I don't have to rewrite ever single fbdev
driver. Or do you think I should rework the console layer first.  



