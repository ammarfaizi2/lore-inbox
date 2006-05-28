Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWE1CeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWE1CeY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 22:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWE1CeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 22:34:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:42918 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965006AbWE1CeX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 22:34:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUFKqn0j4nR7ySDqIcWG4YGFQGEu1TtbnrhAHUg/ZoJMJpYtN517RU6nRRoKr3d3uc9WR00+4zlCztSuFk0rVXP/Qsa94AJHX5zHu5yzH6xy23k9fhKFxzz2arRoEeL8t5v5XmccgLRi5Ai+qDrEYRFc9PaBO8S/2j693rjUvHU=
Message-ID: <9e4733910605271934q76d41330lcf339f221612d74b@mail.gmail.com>
Date: Sat, 27 May 2006 22:34:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605272213.58015.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605271801.36942.dhazelton@enter.net>
	 <9e4733910605271703p5f9de85dw74bc97d86d9a3cd7@mail.gmail.com>
	 <200605272213.58015.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> Yes, I noticed this while studying the DRM code. Part of me doing this,
> actually, will also be updating the DRM in kernel to the latest release.
> (Doing such provides at least one new DRM driver that already has it's X
> counterpart in the 6.8.2 tree)

DaveA will take care of merging drivers from CVS into the kernel tree.
Drivers that are in CVS and not in the kernel are probably there
because their DMA engines are not secure. With Direct Rendering normal
users can submit DMA commands to the GPUs. The kernel drivers check
these commands and make sure that the user isn't using the DMA
controller to play with memory that they don't own. If the DRM driver
is missing these checks it can't go into the kernel since it isn't
secure. I'd ignore DRM CVS and just play with the code in the kernel
tree.

> Fully merging fbdev with DRM would really create some problems for the
> embedded people. If the design of using the fbdev driver as a base layer and
> the DRM drivers as an acceleration layer works then that's all that's truly
> needed. Merging the DRM and fbdev code bases would create a situation where
> the embedded people would have to configure *out* the DRM code that has been
> merged into the fbdev drivers. Not only would such a thing create potential
> bugs in the system, it is a step that could create problems with people
> maintaining the .config's for those systems.

It may cause problems for some embedded people but I wouldn't worry
about them right now. If they don't like something I'm sure we'll hear
from them. Most people don't go to the expense of putting a DRM
capable chip into a system and then not use all of its capabilities.
Remember, only 8 out of the 60 fbdev drivers have DRM modules.

Worst thing that can happen is that they lose 50K of memory. Don't
spend a lot of effort worrying about this especially if no one is
complaining. Issues like this can be addressed later.


> > BTW, I have already submitted a patch that does this and it was
> > rejected. I might be able to find it somewhere, but the dependency
> > code is not very hard to write.
>
> If you can find it Jon, I'd appreciate it. If not, then I'll have to dive into
> the code head first and hope I don't drown in it.

I'll poke around and see if I can find it, but it probably wouldn't
merge anymore.  It took me less than a day to write it so it shouldn't
be too hard to recreate. Just add a do nothing function to each of the
8 fbdev drivers and then make each of the 8 DRM drivers call it. Then
adjust the include and make files until everything compiles. You're
not trying to change anything yet, you're just trying to bind them to
each other.

-- 
Jon Smirl
jonsmirl@gmail.com
