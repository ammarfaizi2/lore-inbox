Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUAIAiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbUAIAiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:38:15 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:4311 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263946AbUAIAiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:38:00 -0500
Subject: Re: [Dri-devel] 2.4.23: user/kernel pointer bugs
	(drivers/char/vt.c, drivers/char/drm/gamma_dma.c)
From: Eric Anholt <eta@lclark.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       marcelo.tosatti@cyclades.com, faith@valinux.com,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073605921.13007.68.camel@dhcp23.swansea.linux.org.uk>
References: <1073592494.18588.77.camel@dooby.cs.berkeley.edu>
	 <1073605921.13007.68.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1073608790.713.13.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 08 Jan 2004 16:39:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-08 at 15:52, Alan Cox wrote:
> On Iau, 2004-01-08 at 20:08, Robert T. Johnson wrote:
> > Both of these bugs look exploitable.  The vt.c patch is
> > self-explanatory.  
> > 
> > In gamma_dma.c, argument "d" to gamma_dma_priority() points to a
> > structure copied from userspace (see gamma_dma()).  That means that
> > d->send_indices is a pointer under user control, so it shouldn't be
> > dereferenced.  The patch just safely copies the contents to a kernel
> > buffer and uses that instead.  Ditto for d->send_sizes.
> 
> Fortunately (in this case) Gamma hasn't worked since about 1999. The SiS
> DRM driver in XFree 4.4 snapshot is also exploitable although the 4.3
> one seems ok. If you feed the memory allocator random crap it oopses.
> With 4.3.x (ie the code in 2.4.x) it doesn't oops but requires sis_fb.
> With 4.3.99... it oopses if I dont have sisfb.

Uhoh, the SiS is my fault.  I'll take a look soon.

> > Also, I notice the drm code uses it's own memory allocation wrappers.  I
> > don't know all the details of the drm code, so I just used kmalloc. 
> > You'll probably want to change those two calls after applying the
> > patch.  Sorry for the inconvenience.
> 
> It comes out as kmalloc, but its done so it will be portable to other
> systems. So on *BSD it comes out appropriately too.

Actually, they were wrapped originally because there was a bunch of
debugging and statistics code for memory allocation.  That's been axed
because nobody actually used it, so now they're just left as functions
wrapping the OS's malloc/free.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


