Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVGDAQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVGDAQF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 20:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVGDAQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 20:16:05 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:19868 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261581AbVGDAP4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 20:15:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZN8FOloQ9LMg+UwGK/7hvIwbss++1grGmuOYJRo75koYgZ1Id92dX6Hln+c6U7YteR7/tEBaMT9W5TG67yjIx5gRvJ6z7m9Yhv/gcwGhcs+9XQMAprLhQdcNPhFdHXOpdw9EETpJOHr8Fb65rJ2imxAYOkB02FQiBN+jJJ24a/E=
Message-ID: <8e6f947205070317156cabb964@mail.gmail.com>
Date: Sun, 3 Jul 2005 20:15:55 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Peter Ronnquist <pronnquist@yahoo.com>
Subject: Re: Where/how to start implementing vertical retrace interrupt interface?
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org
In-Reply-To: <20050702154153.88754.qmail@web30507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050702154153.88754.qmail@web30507.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/05, Peter Ronnquist <pronnquist@yahoo.com> wrote:

I've added the dri-devel and xorg mailing lists to the cc: list.

> If I have understood things correctly then X/x.org can
> not provide a flicker free update of the graphics on a
> display since the linux kernel does not provide a way
> to synchronize to the vertical retrace of a display.
> 
> See
> http://lists.freedesktop.org/archives/xdg/2004-August/004561.html

I don't know if that was true at the time it was written, but today
the DRM implements vblank wait for 3 drivers (mga, r128, and radeon).
However, as far as I can tell, none of the X server's 2d  drivers
makes use of it. Perhaps some more work is needed to make the
interface convient for the X server?

If you have a card supported by one of these drivers, you can move on
to getting the X server to use that capability to support vblank
counters in the XSync extension.

http://freedesktop.org/~jg/roadmap.html#mozTocId921013

Then you only need for toolkits (and/or individual apps) to get with
the program and start using using XSync.

> If a person with little previous experience of the
> linux kernel source tree would like to start on such a
> feature then how complicated do you believe it is to
> implement? (days or months of work)
>
> Where in the kernel source is a good place to start
> looking?

linux/drivers/char/drm/  is where the kernel drivers for graphics cards live. 

Here is an overview of the different pieces of the current
drm/dri/xserver graphics puzzle:
http://dri.freedesktop.org/wiki/DriverFiles

-- 
Will Dyson
