Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269819AbUIDGEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269819AbUIDGEx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 02:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269820AbUIDGEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 02:04:53 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:30629 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269819AbUIDGEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 02:04:47 -0400
Message-ID: <9e47339104090323047b75dbb2@mail.gmail.com>
Date: Sat, 4 Sep 2004 02:04:47 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: New proposed DRM interface design
Cc: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409040548490.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
	 <a728f9f904090317547ca21c15@mail.gmail.com>
	 <Pine.LNX.4.58.0409040158400.25475@skynet>
	 <9e4733910409032051717b28c0@mail.gmail.com>
	 <Pine.LNX.4.58.0409040548490.25475@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to have to work out a GPL/BSD solution for the fbdev
merge. There are 80,000 lines of code in the fbdev directory. It is
impractical to rewrite them. It's probably also impractical to
relicense the fbdev code BSD since we would have to locate all of the
coders.

The proprietary drivers are ok. They don't have to use the GPL
DRM/fbdev code; nothing stops them from writing their own version. I
also don't see how a binary driver that links with drm_core and the
kernel is any different than one that just links to the kernel. GPL
will stop a vendor from taking the source for drm_core/lib and making
a private version. But we want to stop that.

So what do we do about FreeBSD? For example I need to bring in the I2C
and mode setting code from the GPL fbdev radeon driver into the DRM
one. I don't want to rewrite a 1,000 lines of working driver code.

How many DRM users are there on FreeBSD? I've only run into three that
I know of. I'm sure there are more but is it 1,000 people or 100,000?
I don't think DRM CVS will even compile currently on FreeBSD. I think
I broke it a week ago and no one has said anything.

Would this work? drm/shared and drm/bsd directories are BSD licensed.
drm/linux is GPL licensed. Any fbdev code I add will go into
drm/linux. Then we patch up drm/bsd so that is continues to work given
the changes in drm/linux. The other alternative is simply forking the
tree. The licenses also allow chunks of DRM to be pulled into the
fbdev directory but that's effectively a fork.

The code is starting to drift further from BSD anyway. BSD is missing
major OS features like hotplug and resource control that Linux DRM is
starting to use.

The only rational way we can fix the multiple drivers for the same
video card is to merge fbdev and DRM functions. The other solution is
device driver multi-tasking with a 256MB state to be saved on task
swap.

On Sat, 4 Sep 2004 05:52:37 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> I think we have to remember licensing at all stages of this, the DRM is
> X licensed, so I don't think we can just merge the fb code, I'm not sure
> what peoples views on this, the main reason I see for using X licensing
> is that we can share this stuff with FreeBSD and have an open source
> graphics interface standard that the chipset designers can use, against it
> is the fact that it allows for properitary drivers, - I personally don't
> think we'll ever win that war.. will the prop drivers be derived works of
> the DRM rather than the kernel anyone got a spare lawyer?
> 
> Dave.
> 
> On Fri, 3 Sep 2004, Jon Smirl wrote:
> > As we work towards the merged DRM/fbdev goal the fbdev libraries are
> > going to become part of DRM. The libraries will be used pretty much
> > unchanged as it is the driver code that needs to be adjusted. How does
> > this play with the new DRM model?
