Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUIDTDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUIDTDv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 15:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbUIDTDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 15:03:51 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:19281 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265768AbUIDTDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 15:03:48 -0400
Message-ID: <a728f9f904090412036e662e45@mail.gmail.com>
Date: Sat, 4 Sep 2004 15:03:45 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: New proposed DRM interface design
Cc: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040904012510.77417.qmail@web14929.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409040158400.25475@skynet>
	 <20040904012510.77417.qmail@web14929.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004 18:25:10 -0700 (PDT), Jon Smirl <jonsmirl@yahoo.com> wrote:
> --- Dave Airlie <airlied@linux.ie> wrote:
> > >
> > > Will this redesign allow for multiple 3d accelerated cards in the
> > same
> > > machine?  could I have say an AGP radeon and a PCI radeon or a AGP
> > > matrox and a PCI sis and have HW accel on :0 and :1.  If not, I
> > think
> > > it's something we should consider.
> >
> > should be no problem at all, this is what I consider a DRM
> > requirement so
> > any design that doesn't fulfill it isn't acceptable...
> >
> > of course implemented code may need a bit of testing :-)
> 
> I've been reworking the DRM code to better support two dissimilar video
> card. I pratice on a PCI Rage128 and AGP Radeon.
> 
> I would also like to start making infastructure changes to allow two
> independently logged in users, one on each head. Multihead DRM cards
> will show one device per head. If you set a merged fb mode the other
> head will get disabled.

I'm not sure mergedfb is really "the way" to go long term.  It has
certain limitations (drawing engine limits, scrolling viewport when
using dissimilar modes on each head, etc.).  We might be better off
sharing access to the 3d engine like we do for 2D with "regular"
multihead.  xinerama could then be handled by indirect rendering mixed
with DMX and GLproxy.  some sort of fast path could be designed for
dualhead cards if a 3D window strattled both heads.  Just a thought.

Alex

> 
> This is the general plan I am working towards...
> http://lkml.org/lkml/2004/8/2/111
> 
> 
> 
> 
> =====
> Jon Smirl
> jonsmirl@yahoo.com
>
