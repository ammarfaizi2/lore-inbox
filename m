Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWEXP1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWEXP1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 11:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbWEXP1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 11:27:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:56012 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932652AbWEXP1t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 11:27:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LDTzAcSzFU0dqyd0fVUg8v6FWIb25BPOXGjNP2rM/jG5QJ8/xbq/amSA68jCXel8jPmzqW5220SNfi224qT+JTtO2yLG4F72+b+k2RTxVs1r5S/Oye3T7AlFbuzkrhSTA/LcnZ8dVXd8yD+XVieNZk5wMDkq9G2KMMvn7VVF+aI=
Message-ID: <9e4733910605240827w309c4dc7of42ea2def10960c9@mail.gmail.com>
Date: Wed, 24 May 2006 11:27:49 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605232338.54177.dhazelton@enter.net>
	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
	 <200605240017.45039.dhazelton@enter.net>
	 <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/06, Dave Airlie <airlied@gmail.com> wrote:
> The current system is fixable, we've discussed how to fix it a number
> of times, however there have never been resources to do it, we
> explained to Jon on a number of occasion how we as the maintainers
> felt it should be fixed, the patches he produced didn't follow the
> direction we wanted, he stated "the writer decides", we stated "the
> maintainers don't accept it".

I have done the following things...
1) Repeatedly discussed the design of the fixes in depth on the mailing lists
2) Provided extensive documentation of a path to fix the current set of problems
3) Provided numerous patches fixing various parts of the problem

But now it is a year latter and kernel graphics sits exactly where it
was a year ago. There has been zero forward progress. The X developer
obsession of reducing all OSes to a least common denominator is
clearly holding back Linux graphics support. Merging DRM and fbdev is
a win for Linux since it eliminates one of the places where two
independent drivers are trying to control the same piece of hardware.
The merging is blocked because of issues with DRM on BSD (merging
would introduce GPL code into DRM which couldn't then be ported onto
BSD without forking).

So instead of doing a merge a complicated device driver sharing bus is
being constructed

>Okay I've put up two patches at
>http://www.skynet.ie/~airlied/patches/merge/three_tier.diff
>http://www.skynet.ie/~airlied/patches/merge/three_tier_2.diff
>Neither of these do what I wanted to do but they give a lot of ideas
>on how to do it, the device model required in the end using a bus to
>do this, I actually had some thoughts about it at the X.org developers
>conference earlier in the year while reading LDD, but I've been
>swamped since and probably won't get back to it until OLS.


I'm still sticking with my core driver principles:
1) One driver per device
2) A loaded driver must mark the device in use
3) Don't touch hardware that the driver doesn't own
4) Don't use root priv to bypass OS functions
The current graphics code violates all of these

Blocking my changes has resulted in the loss of a full time developer
from an area that is woefully understaffed. I would strongly suggest
that anyone considering doing work in this area to learn from my
experience. Since acceptance of any work you do is questionable, only
work on tiny pieces. Then when your work is blocked you won't have
lost months of effort. I would recommend doing no more that a week's
work before trying to get it merged. And don't start on other changes
while waiting on results from the first one. If the first one is
blocked (likely) you don't want your second change depending on it.

-- 
Jon Smirl
jonsmirl@gmail.com
