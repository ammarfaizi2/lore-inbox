Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266369AbSLDKbC>; Wed, 4 Dec 2002 05:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSLDKbC>; Wed, 4 Dec 2002 05:31:02 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:44250 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266369AbSLDKbB>;
	Wed, 4 Dec 2002 05:31:01 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Antonino Daplas <adaplas@pol.net>
Date: Wed, 4 Dec 2002 11:38:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
Cc: James Simmons <jsimmons@infradead.org>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       luther@dpt-info.u-strasbg.fr
X-mailer: Pegasus Mail v3.50
Message-ID: <95A78C92329@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Dec 02 at 17:08, Antonino Daplas wrote:
> On Wed, 2002-12-04 at 12:32, Sven Luther wrote:
> > On Tue, Dec 03, 2002 at 05:22:35PM +0500, Antonino Daplas wrote:
> > > >   2) The ability to go back to vga text mode on close of /dev/fb. 
> > > >      Yes fbdev/fbcon supports that now. 
> > > 
> > > I'll take a stab at writing VGA save/restore routines which hopefully is
> > > generic enough to be used by various hardware.  No promises though, VGA
> > > programming gives me a headache :(
> > 
> > BTW, i am writing a fbdev for a card where the docs tell me to disable
> > vga output before enabling graphical output. Does i need to do this in
> > the fbdev i write, or is it already handled by the vga layer, or
> > whatever ?
> 
> Most cards with a VGA core needs to disable the VGA output before going
> to graphics mode.  Disabling VGA output is hardware specific, and is
> usually automatic when you go to graphics mode.
> 
> Because James wrote the fb framework to be very modular, then you must
> be careful to save/restore the initial video state  when loading or
> unloading.  Theoretically, a driver should load, but not go to graphics
> mode immediately.  Only upon a call to xxxfb_set_par() should the driver
> do so.  Before going to graphics mode, that's were you save the initial
> state.  Have a reference count or something to keep track of the number
> of users, and when this reference count becomes zero, restore the
> initial state.  You should be able to do this by hooking these routines
> in fb_open() and fb_release().

FYI, I'm not going to support any hardware restoration on last fb_release,
nor hardware init only after first fb_open in matroxfb. Either you want
this driver, or not. Besides that I do not see any reason to have such 
code, matroxfb provides multiple framebuffers, and to get them
all work, hardware must be in known state, it is impossible to program
only half of chip and expect that it will somehow work. It will crash,
lock your PCI bus, or even commits suicide.

And I'm sure that other possible solution, that opening /dev/fb1 
(or /dev/videoX or /dev/dri/mga) will cause your vgacon picture to 
disappear, violates principle of least surprise.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
