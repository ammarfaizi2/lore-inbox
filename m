Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269829AbUIDHwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269829AbUIDHwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 03:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269830AbUIDHwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 03:52:13 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:59533 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269829AbUIDHwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 03:52:01 -0400
Date: Sat, 4 Sep 2004 08:52:00 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <9e47339104090323047b75dbb2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409040843360.25475@skynet>
References: <Pine.LNX.4.58.0409040107190.18417@skynet> 
 <a728f9f904090317547ca21c15@mail.gmail.com>  <Pine.LNX.4.58.0409040158400.25475@skynet>
  <9e4733910409032051717b28c0@mail.gmail.com>  <Pine.LNX.4.58.0409040548490.25475@skynet>
 <9e47339104090323047b75dbb2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We're going to have to work out a GPL/BSD solution for the fbdev
> merge. There are 80,000 lines of code in the fbdev directory. It is
> impractical to rewrite them. It's probably also impractical to
> relicense the fbdev code BSD since we would have to locate all of the
> coders.

Well I've been thinking we'll need to rob a lot of code from X11, a fair
bit of code in fbdev is taken from X anyways.. I'm not so sure it
wouldn't be that hard to move the rest...

>From what I can see we make the core in-kernel and library sections under
BSD and then the driver can probably choose their license... I just think
this work is pretty ugly work and I would hate for another OS to have to
go do it again from scratch just because we decided to use GPL, I would
also like to make the interface as standard as possible.. (maybe ReactOS
could port it to Windows :-)

> Would this work? drm/shared and drm/bsd directories are BSD licensed.
> drm/linux is GPL licensed. Any fbdev code I add will go into
> drm/linux. Then we patch up drm/bsd so that is continues to work given

All the current code is X licensed, I think we should try and get code
from X where we can and if not maybe ask fb people about it ..

> The code is starting to drift further from BSD anyway. BSD is missing
> major OS features like hotplug and resource control that Linux DRM is
> starting to use.

But the future isn't set in stone, if BSD gets these features this
statement is insigificant...

> The only rational way we can fix the multiple drivers for the same
> video card is to merge fbdev and DRM functions. The other solution is
> device driver multi-tasking with a 256MB state to be saved on task
> swap.

For the cards the DRM supports, we could just reimplement the fb
functionality, the only card I'm aware of that really matters is the
radeon, there is no fbdev for i830/915 (I'm going to do one under the BSD
license when time permits, Dave Dawes did one half in half, part GPL part
BS but it was for 2.4 and he's abandoned it now .. the mach64 fb doesn't
work very well (my mobility chip craps it out..).. maybe the matrox is
another useful one, we probably should work on a dmacon interface rather
than fbcon, again this isn't obvious yet what we do...

Dave.
>
> On Sat, 4 Sep 2004 05:52:37 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> > I think we have to remember licensing at all stages of this, the DRM is
> > X licensed, so I don't think we can just merge the fb code, I'm not sure
> > what peoples views on this, the main reason I see for using X licensing
> > is that we can share this stuff with FreeBSD and have an open source
> > graphics interface standard that the chipset designers can use, against it
> > is the fact that it allows for properitary drivers, - I personally don't
> > think we'll ever win that war.. will the prop drivers be derived works of
> > the DRM rather than the kernel anyone got a spare lawyer?
> >
> > Dave.
> >
> > On Fri, 3 Sep 2004, Jon Smirl wrote:
> > > As we work towards the merged DRM/fbdev goal the fbdev libraries are
> > > going to become part of DRM. The libraries will be used pretty much
> > > unchanged as it is the driver code that needs to be adjusted. How does
> > > this play with the new DRM model?
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

