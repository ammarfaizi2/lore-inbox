Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTDCM0p>; Thu, 3 Apr 2003 07:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263368AbTDCM0o>; Thu, 3 Apr 2003 07:26:44 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.26]:12894 "EHLO
	mwinf0501.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263366AbTDCM0n>; Thu, 3 Apr 2003 07:26:43 -0500
Date: Thu, 3 Apr 2003 14:38:03 +0200
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Message-ID: <20030403123803.GD7131@iliana>
References: <4A83DF6367@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A83DF6367@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:05:13PM +0100, Petr Vandrovec wrote:
> On  3 Apr 03 at 9:40, Sven Luther wrote:
> > On Thu, Apr 03, 2003 at 03:07:33AM +0100, Petr Vandrovec wrote:
> > > On  2 Apr 03 at 22:55, James Simmons wrote:
> > > 
> > > > It doesn't need a struct pci_dev in this case. It is possible to get this 
> > > > info from the i2c bus but I never seen any drivers do this. What data would
> > > > we have to pass in get the EDID inforamtion? So the question is how 
> > > > generic will get_EDID end up being or will we have to have driver specfic 
> > > > hooks since I don't pitcure i2c approaches being the same for each video 
> > > > card. Petr didn't you attempt this with the matrox driver at one time?
> > > 
> > > Yes, matroxfb provides one i2c (DDC) bus for each output videocard has.
> > > I ended with only this support (and userspace EDID parser) as i2c was
> > > initialized loong after framebuffer at that time... Now when i2c is usable
> > > when fbdev initializes, it looks much better.
> > > 
> > > Only get_EDID interface I need is one which gets i2c bus as argument. But
> > > I have no idea how I should handle situation where you have connected
> > > two different monitors to both crtc1 outputs... Like 50Hz PAL TV &
> > > 60+Hz VGA monitor. Currently it is user responsibility to resolve such
> > > situation...
> > 
> > Is the EDID reading stuff not done per head ?
> 
> No. With matroxfb, you have two framebuffer devices, /dev/fb0 & /dev/fb1,
> which can be connected to any of three outputs: analog primary, analog
> secondary and DVI. Analog primary & DVI share same pair of DDC cables,
> and analog secondary has its own... And user can interconnect fb* with
> outputs in almost any way he wants, as long as hardware supports it.

Mmm, i have not been into fbdev much lately, but for my X devel work, i
believe thta it is a good thing to separate the framebuffer issues from
the output issues, and thus, for the card i have at least, have one
function where the per chip things are done (memory detection, bypass
unit handling, framebuffer and memory management) and another set of
functions which would be head, that is output, specific. This way, you
would configure the /dev/fbx and when the user which to use this or that
output, the DDC will be connected to the output, not the framebuffer.
This seems a reasonable way of doing this and should solve your problem,
no ?

Friendly,

Sven Luther
