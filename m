Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUIDPq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUIDPq1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUIDPq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 11:46:27 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:16502 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbUIDPqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 11:46:25 -0400
Message-ID: <9e47339104090408463fec9929@mail.gmail.com>
Date: Sat, 4 Sep 2004 11:46:23 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: New proposed DRM interface design
Cc: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.sf.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409040843360.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
	 <a728f9f904090317547ca21c15@mail.gmail.com>
	 <Pine.LNX.4.58.0409040158400.25475@skynet>
	 <9e4733910409032051717b28c0@mail.gmail.com>
	 <Pine.LNX.4.58.0409040548490.25475@skynet>
	 <9e47339104090323047b75dbb2@mail.gmail.com>
	 <Pine.LNX.4.58.0409040843360.25475@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sep 2004 08:52:00 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> 
> > We're going to have to work out a GPL/BSD solution for the fbdev
> > merge. There are 80,000 lines of code in the fbdev directory. It is
> > impractical to rewrite them. It's probably also impractical to
> > relicense the fbdev code BSD since we would have to locate all of the
> > coders.
> 
> Well I've been thinking we'll need to rob a lot of code from X11, a fair
> bit of code in fbdev is taken from X anyways.. I'm not so sure it
> wouldn't be that hard to move the rest...

I have tried twice now to extract code from X and merge it into DRM.
It is a pointless endeavor. The driver code is so intertwined into the
X type system and other pieces of X it is hopeless to extract it.
You're better off just using it as a reference and writing the code
again. On the other hand code fron fbdev can be used with almost zero
change in DRM.

The radeon fbdev I2C driver code is based on the X version. But if you
compare the code it is a complete rewrite.

The big piece of fbdev code I need implements text drawing in graphics
mode. This is needed to print OOPs when they happen in a graphics
mode. I also need the fbdev drivers for which there is no
corresponding DRM equivalent. These drivers need to be converted to
use drm_core so that we have a unified driver model.

One end goal of all this is to end up with a single video mode setting
API for the kernel.
