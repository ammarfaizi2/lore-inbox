Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbULOTfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbULOTfA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbULOTfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:35:00 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:28028 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262365AbULOTe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:34:56 -0500
Date: Wed, 15 Dec 2004 21:34:58 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com, alsa-devel <alsa-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215193458.GB13539@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103135460.18982.68.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Lee Revell (rlrevell@joe-job.com) "Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.":
> On Wed, 2004-12-15 at 19:20 +0100, Takashi Iwai wrote:
> > At Wed, 15 Dec 2004 09:46:35 +0200,
> > Michael S. Tsirkin wrote:
> > > 
> > > There were two additional motivations for my patch:
> > > 1. Make it possible to avoid the BKL completely by writing
> > >    an ioctl with proper internal locking.
> > > 2. As noted by  Juergen Kreileder, the compat hash does not work
> > >    for ioctls that encode additional information in the command, like this:
> > > 
> > > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len) > > 
> > I like the idea very well.  Other benifits in addition:
> > 
> 
> How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
> official way to do BKL-less ioctls"?
> 
> http://lkml.org/lkml/2004/12/14/53
> 
> Lee

It conflicts :) When I wrote the original patch for 2.6.8.1
I didnt see the unlocked_ioctl.patch.

unlocked_ioctl is the same as ioctl_native in my patch, except that

1. I added more documentation in several places :)
   (notably Documentation/filesystems/Locking)

2. I thought it a bit silly to name a function for what
   it does not do (does not take a lock), and we
   still need a call for the compat layer.

My patch adds another call to enable special handling
for 32 bit ioctls on 64 bit systems.

I could look at porting to -rc3-mm1, unless
we dont want to back unlocked_ioctl.patch off.
What do people here think?

MST
