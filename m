Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVFLUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVFLUaR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVFLUaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 16:30:16 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:65510 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261151AbVFLUaK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 16:30:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NVRrsEum7+8mSrwFCTAgKObLCv5JbLyGsZxLZg/3VN2c/u5pzVqoRdgK//IJ2118XC76GgJfJdf9F+/SNtcsc9iCb8LJrK9bV/512ZOiu9Pw2iiSu+jr6bhJBr0OxlsYt07LX5A16PkFdh2Ev00R2fkdApCREZ4k9mliX8D0fKY=
Message-ID: <9e473391050612133036fe2902@mail.gmail.com>
Date: Sun, 12 Jun 2005 16:30:09 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMC ioctl or sysfs interface?
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <1118600720.9949.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A83F59.7090509@drzeus.cx>
	 <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>
	 <42A9FF79.1010003@drzeus.cx>
	 <1118444435.5213.72.camel@localhost.localdomain>
	 <42AC7BD4.9040906@drzeus.cx>
	 <1118600720.9949.99.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2005-06-12 at 19:15, Pierre Ossman wrote:
> > Alan Cox wrote:
> > I wasn't aware that you could do ioctl on sysfs nodes. I guess I'll have
> > to dig a bit deeper in the documentation/code.
> 
> You can add support, but you'll need a device node one day anyway so you
> might as well give up on the sysfs only game - it doesn't IMHO work.

I have a sysfs interface for fbdev in the kernel -
/sys/class/graphics/fb0/*  It is working well for me and it's the only
interface EGL uses to access fbdev. It's all controllable with strings
that can be scripted if you want. If you play with it some of the
attributes are broken, there are fixes for them in the pipeline.

I also have DRM loaded for the same hardware. I'd have to think about
it for a while to see if DRM could go sysfs only. I'm using DRM to map
the framebuffer instead of fbdev.

One big difference is that a device node can carry session state. If
you open the device the file handle can track things belonging to the
session. With sysfs sessions are more of a mess. fbdev works cleanly
because there is no session state.

-- 
Jon Smirl
jonsmirl@gmail.com
