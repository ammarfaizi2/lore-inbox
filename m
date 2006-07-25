Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWGYSxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWGYSxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWGYSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:53:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54149 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751485AbWGYSxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:53:18 -0400
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
From: Arjan van de Ven <arjan@infradead.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060725184328.GF4608@hmsreliant.homelinux.net>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	 <1153850139.8932.40.camel@laptopd505.fenrus.org>
	 <20060725182208.GD4608@hmsreliant.homelinux.net>
	 <1153852375.8932.41.camel@laptopd505.fenrus.org>
	 <20060725184328.GF4608@hmsreliant.homelinux.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 25 Jul 2006 20:53:16 +0200
Message-Id: <1153853596.8932.44.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-25 at 14:43 -0400, Neil Horman wrote:
> On Tue, Jul 25, 2006 at 08:32:55PM +0200, Arjan van de Ven wrote:
> > 
> > > > 3) this will negate the power gain you get for tickless kernels, since
> > > > now they need to start ticking again ;( )
> > > > 
> > > That is true, but only in the case where someone opens up /dev/rtc, and if they
> > > open that driver and send it a UIE or PIE ioctl, it will start ticking
> > > regardless of this patch (or that is at least my impression).
> > 
> > but.. if that's X like you said.. then it's basically "always"...
> > 
> Well, not always (considering the number of non-X embedded systems out there),
> but I take your point.  So it really boils down to not having a tickless kernel,
> or an X server that calls gettimeofday 1 million times per second (I think thats
> the number that Dave threw out there).  Unless of course, you have a third
> alternative, which, as I mentioned before I would be happy to take a crack at,
> if you would elaborate on your idea a little more.

well the idea that has been tossed about a few times is using a vsyscall
function that either calls into the kernel, or directly uses the hpet
page (which can be user mapped) to get time information that way... 
or even would use rdtsc in a way the kernel knows is safe (eg corrected
for the local cpu's speed and offset etc etc).


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

