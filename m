Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263390AbTDCN1i>; Thu, 3 Apr 2003 08:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263389AbTDCN1h>; Thu, 3 Apr 2003 08:27:37 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:50156 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S263390AbTDCN1f>;
	Thu, 3 Apr 2003 08:27:35 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Date: Thu, 3 Apr 2003 15:38:43 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4E134F4AFE@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Apr 03 at 15:11, Sven Luther wrote:
> On Thu, Apr 03, 2003 at 03:05:54PM +0100, Petr Vandrovec wrote:
> > On  3 Apr 03 at 14:38, Sven Luther wrote:
> > > On Thu, Apr 03, 2003 at 12:05:13PM +0100, Petr Vandrovec wrote:
> > > > No. With matroxfb, you have two framebuffer devices, /dev/fb0 &
> > > > /dev/fb1, which can be connected to any of three outputs: analog
> > > > primary, analog secondary and DVI. Analog primary & DVI share same
> > > > pair of DDC cables, and analog secondary has its own... And user can
> > > > interconnect fb* with outputs in almost any way he wants, as long as
> > > > hardware supports it.
> > > 
> > > Mmm, i have not been into fbdev much lately, but for my X devel work, i
> > > believe thta it is a good thing to separate the framebuffer issues from
> > > the output issues, and thus, for the card i have at least, have one
> > > function where the per chip things are done (memory detection, bypass
> > > unit handling, framebuffer and memory management) and another set of
> > > functions which would be head, that is output, specific. This way, you
> > > would configure the /dev/fbx and when the user which to use this or that
> > > output, the DDC will be connected to the output, not the framebuffer.
> > > This seems a reasonable way of doing this and should solve your problem,
> > > no ?
> > 
> > Of course. But because of James decided that fbdev layer will
> > automatically choose appropriate resolution only from xres/yres, I need to
> > have monitor capabilities at the time upper layer asks to set videomode on
> > /dev/fbx... And it just sets it on /dev/fbx, leaving out both VTs (so I
> > cannot remember what mode was probed on each VT anymore) and outputs.
> 
> Mmm, and at what time is the fbdev->output mapping done ?

At random time, when user asks to change fbdev->output mapping... And it 
still means that I have to create new EDID based on all EDIDs I read from 
each output - this is biggest problem, and that currently used videomode
can become invalid - and this is even worse problem.

In the past life was sweet, user apps showed windows that currently used
setting is unavailable, and offered some changes. Now when we are moving
more and more policy to the kernel...
                                                    Petr Vandrovec
                                                    

