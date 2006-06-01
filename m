Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965294AbWFAUfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965294AbWFAUfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWFAUfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:35:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:38606 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965294AbWFAUfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:35:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IytKTBgyXX0jiiwWRqx8wr3qIR+LugALaIb3lnUBx3D7kOO5WuVp8MVO4+ZO6CMdeH4t23FTG70NlOkhATkvMKq+Fwurb8y5J4bf+1H525iedWdWOX3CBtXRRRYoxtcFMMuey9kpbpHdIfmKKOBtWBCIqklgXYQ3EC4JvWF4/lQ=
Message-ID: <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
Date: Thu, 1 Jun 2006 16:35:12 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "David Lang" <dlang@digitalinsight.com>,
       "Ondrej Zajicek" <santiago@mail.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <200606011603.57421.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>
	 <200606011603.57421.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> > > 5) The system needs to be robust. Daemons can be killed by the OOM
> > > mechanism, you don't want to lose your console in the middle of trying
> > > to fix a problem. This also means that you have to be able to display
> > > printk's from inside interrupt handles.
>
> Point of disagreement. Tons of userspace helpers isn't a good choice.

Where do you get 'tons'? There will probably be one for initial reset,
one for VESA based mode setting and a few more if there is device
specific code needed for a specific card.

Making console rely on a permanent daemon that is subject to getting
killed by the OOM mechanism is not a workable solution.

You also need to think about how cursors are handled. A non-root app
needs to be able to move the cursor. Actually moving the cursor
requires root. The in-kernel console system needs a cursor. It would
be much better if cursor control was implemented in the device
drivers.

> I don't know about doing a printk from inside interrupt context - the current
> architecture doesn't, IIRC, support printk from inside interrupt context for
> certain drivers for various reasons.

Printk works from inside interrupt handlers currently. This is an
absolute requirement for kernel debugging that can't be removed.
Because of this requirement there has to be a way for all drivers to
draw the console entirely inside the kernel. You can not make calls to
user space from inside interrupt handlers.

> > > 6) Things like panics should be visible no matter what is running. No
> > > more silent deaths.

Panics can occur inside interrupt handlers. You can't queue up printks
in this context and they display them later, the kernel just died,
there is no later.

-- 
Jon Smirl
jonsmirl@gmail.com
