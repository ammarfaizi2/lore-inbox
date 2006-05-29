Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWE2A7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWE2A7U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 20:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWE2A7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 20:59:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:34501 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751086AbWE2A7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 20:59:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fY9yOU9A/PuM1zS3Bcds6RBXamNfeNadsFo2q4+j27bI2w4D1+GBMnLfhjI1GX8dXzBoeCYW/ipMdbVfDoNRCVF3dUjLD+yy+Kmw+l6oVQjyDie9IDtm2FJdJTPuuSkrYy7wP7Wu1kw5JjGM0YdM1HcQNWt9aR+kZEwL+0PEFuc=
Message-ID: <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>
Date: Sun, 28 May 2006 20:59:19 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, Dave Airlie <airlied@gmail.com> wrote:
> I've already pointed out to Jon the problems with this approach on
> numerous occasions and to be honest do not have the time to do so
> again,
>
> I will not accept patches to make DRM drivers rely on fbdev drivers in
> the kernel for many many many reasons, two quick ones :

Hence we will have no forward progress in kernel graphics for the next
few decades.

>
> a) we don't always have a fully functional fbdev driver, see intel fb drivers.

Binding the drivers to each other does not cause any code to be called
in either driver. This is just the first step down a long path to
making the merged drivers work.

> b) loading fbdev drivers breaks X in a lot of cases, we need to be a
> bit more careful.

It is perfectly legal to load an fbdev driver with X today. If it
doesn't work it is a bug in X and should be fixed.

> c) Lots of distros don't use fbdev drivers, forcing this on them to
> use drm isn't an option.

Why isn't this an option? Will the distros that insist on continuing
to ship three conflicting video drivers fighting over a single piece
of hardware please stand up and be counted? Distros get new drivers
all the time, why will this be any different?

> should I go on?

yes

You do realize that in a merged fbdev/DRM driver that if the mode
setting code is pushed into a user space library (I've said that would
be part of the path to a fully merged driver) that there really isn't
much left to a fbdev driver besides the binding and initialization
code.

> I've made suggestions I've given you patches that start the work, I'm
> going to finish that work, but I've no timeline, I'd hope at KS/OLS
> this year to do it..

In your scheme the 60 existing fbdev drivers need to be edited to
remove their code that binds them to the hardware and make them use a
new low level driver. Are you signing up to edit all of these drivers?
I'll shut up when I see a tested patch that edits all 60 drivers and
make them use the new layer. My fear is that half the fbdev drivers
will get adjusted and no one will get around to fixing the rest,
effectively creating two fbdev architectures. A complete patch would
address that concern.

BTW, I've done patches that touched all of those drivers and it is a
very painful process. Be prepared to work on code for every
architecture supported by Linux.

-- 
Jon Smirl
jonsmirl@gmail.com
