Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263331AbTDCNg7>; Thu, 3 Apr 2003 08:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263396AbTDCNg7>; Thu, 3 Apr 2003 08:36:59 -0500
Received: from smtp4.wanadoo.fr ([193.252.22.28]:40523 "EHLO
	mwinf0303.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S263331AbTDCNg6>; Thu, 3 Apr 2003 08:36:58 -0500
Date: Thu, 3 Apr 2003 15:48:18 +0200
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Message-ID: <20030403134818.GB8297@iliana>
References: <4E134F4AFE@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E134F4AFE@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 03:38:43PM +0100, Petr Vandrovec wrote:
> On  3 Apr 03 at 15:11, Sven Luther wrote:
> > On Thu, Apr 03, 2003 at 03:05:54PM +0100, Petr Vandrovec wrote:
> > > On  3 Apr 03 at 14:38, Sven Luther wrote:
> > > > On Thu, Apr 03, 2003 at 12:05:13PM +0100, Petr Vandrovec wrote:
> > > > > No. With matroxfb, you have two framebuffer devices, /dev/fb0 &
> > > > > /dev/fb1, which can be connected to any of three outputs: analog
> > > > > primary, analog secondary and DVI. Analog primary & DVI share same
> > > > > pair of DDC cables, and analog secondary has its own... And user can
> > > > > interconnect fb* with outputs in almost any way he wants, as long as
> > > > > hardware supports it.
> > > > 
> > > > Mmm, i have not been into fbdev much lately, but for my X devel work, i
> > > > believe thta it is a good thing to separate the framebuffer issues from
> > > > the output issues, and thus, for the card i have at least, have one
> > > > function where the per chip things are done (memory detection, bypass
> > > > unit handling, framebuffer and memory management) and another set of
> > > > functions which would be head, that is output, specific. This way, you
> > > > would configure the /dev/fbx and when the user which to use this or that
> > > > output, the DDC will be connected to the output, not the framebuffer.
> > > > This seems a reasonable way of doing this and should solve your problem,
> > > > no ?
> > > 
> > > Of course. But because of James decided that fbdev layer will
> > > automatically choose appropriate resolution only from xres/yres, I need to
> > > have monitor capabilities at the time upper layer asks to set videomode on
> > > /dev/fbx... And it just sets it on /dev/fbx, leaving out both VTs (so I
> > > cannot remember what mode was probed on each VT anymore) and outputs.
> > 
> > Mmm, and at what time is the fbdev->output mapping done ?
> 
> At random time, when user asks to change fbdev->output mapping... And it 
> still means that I have to create new EDID based on all EDIDs I read from 
> each output - this is biggest problem, and that currently used videomode
> can become invalid - and this is even worse problem.

Ideally, the EDID reading would be done just after the user request an
output mapping change for the first time, and then stored privately to
each output. mode changes and such would be done after the output has
been assigned only, and you would have the EDID by then. You could even
reread it regularly, in case the monitor is hot swapped or something
such.

I have not read James response to you, but had the impression he did
propose something such, did he not ?

Friendly,

Sven Luther
