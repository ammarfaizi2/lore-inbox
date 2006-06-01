Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965316AbWFAVYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965316AbWFAVYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbWFAVYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:24:09 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:34668 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965316AbWFAVYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:24:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rjh2D2NgVU24ZpHcz4EqTJ5xLYjrFuuUvJE8BoLEe1fOkI62l7gBMrRnd6OhjZ9uc2fTIJwpyx8tEza6aF0bH441zFEr2VdnGB+gcteGJvRBYCJYOvtL/BhqdLXptERqrfmAClli+Pn/5EK4zHAorNoGkpx/GZeGnCg6xHoGizQ=
Message-ID: <9e4733910606011423u75fa076hce22547c28c0a987@mail.gmail.com>
Date: Thu, 1 Jun 2006 17:23:56 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>,
       "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <447F56A0.8030408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
	 <200606011603.57421.dhazelton@enter.net>
	 <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
	 <447F56A0.8030408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> >
> > Printk works from inside interrupt handlers currently. This is an
> > absolute requirement for kernel debugging that can't be removed.
> > Because of this requirement there has to be a way for all drivers to
> > draw the console entirely inside the kernel. You can not make calls to
> > user space from inside interrupt handlers.
> >
> >> > > 6) Things like panics should be visible no matter what is running. No
> >> > > more silent deaths.
> >
> > Panics can occur inside interrupt handlers. You can't queue up printks
> > in this context and they display them later, the kernel just died,
> > there is no later.
> >
>
> Console writes are done with the console semaphore held. printk will also
> just write to the log buffer and defer the actual console printing
> for later, by the next or current process that will grab the semaphore.

That was my original position too. But Alan Cox has drilled it into me
that this is not acceptable for printks in interrupt context, they
need to print there and not be deferred.

-- 
Jon Smirl
jonsmirl@gmail.com
