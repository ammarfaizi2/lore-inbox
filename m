Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291986AbSBAUgo>; Fri, 1 Feb 2002 15:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291987AbSBAUgf>; Fri, 1 Feb 2002 15:36:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63398 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291986AbSBAUg2>;
	Fri, 1 Feb 2002 15:36:28 -0500
Date: Fri, 1 Feb 2002 15:36:26 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Monta <pmonta@pmonta.com>, linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201153626.C2497@havoc.gtf.org>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <3C5AFA22.1020208@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5AFA22.1020208@zytor.com>; from hpa@zytor.com on Fri, Feb 01, 2002 at 12:27:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:27:14PM -0800, H. Peter Anvin wrote:
> Peter Monta wrote:
> 
> >>Anything that is meant to be a server really pretty much needs an
> >>enthropy generator these days.
> >>
> > 
> > Many motherboards have on-board sound.  Why not turn the mic
> > gain all the way up and use the noise---surely there will be
> > a few bits' worth?
> > 
> > Perhaps there ought to be a way to give bits to the kernel's
> > /dev/random input hopper from user space.
> > 
> 
> 
> There already is.  If I'm not completely mistaken, just write the raw data
> to /dev/random, then there is an ioctl() saying "add N bits to the
> entrophy counter."

Yep.  The i810 RNG userspace daemon, rngd, does this.  It reads from
i810 RNG data from /dev/intel_rng, tests the data, and injects it back
into /dev/random with the specified entropy bits.  (zero bits by default,
because we default to paranoia mode of not trusting, but that can and is
usually increased)

	Jeff



