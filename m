Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWFBEee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWFBEee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFBEee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:34:34 -0400
Received: from smtp.enter.net ([216.193.128.24]:33298 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751111AbWFBEed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:34:33 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Fri, 2 Jun 2006 00:34:23 +0000
User-Agent: KMail/1.8.1
Cc: "Dave Airlie" <airlied@gmail.com>, "Ondrej Zajicek" <santiago@mail.cz>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200606012234.31566.dhazelton@enter.net> <9e4733910606012016r2f8d4708hc092eb3dd9b925a2@mail.gmail.com>
In-Reply-To: <9e4733910606012016r2f8d4708hc092eb3dd9b925a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606020034.24324.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 03:16, Jon Smirl wrote:
> On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> > VT switch to a VT where X is running. X will still require a VT and
> > assume it has good access to the graphics system. While currently it has
> > no problems, when drmcon becomes a reality there will have to be a state
> > switch between the consoles settings and the setting for the VT running
> > X.
>
> I forgot to include comments on VT's.
>
> We need to reconsider how VT's are implemented. I would like to remove
> them from the kernel. Now don't get too excited, I also want to
> replace them with a system that would function the same for a normal
> user.
>
> There is only one VT system in the kernel. Making it support more that
> one user requires a gigantic patch (18,000 lines). That patch has been
> floating around for years and has never been merged. I don't think it
> makes sense to extend the existing VT code even further to support
> multiuser.
>
> My proposal would be to switch to the concept of splitting console as
> I described earlier. There would only be one in-kernel system
> management console and it wouldn't support VT's. The system management
> console is not meant for normal use.
>
> Normal consoles would be implemented via user space processes. These
> processes would provide the VT swap feature that people are used to.
> They would also be accelerated via DRM. Since they are user space apps
> it is easy to support multiuser by having multiple processes.
>
> Getting rid of the VT implementation inside of the kernel lets us move
> towards the single state in the hardware goal. The current in-kernel
> VT design forces the "save your state, now I'll load mine" behavior.
> That behavior is evil and it is the source of a lot of problems and it
> should be removed. VT's were a good idea on VGA cards with 14
> registers, now cards have 300 registers, a coprocessor, 512MB, etc.
> There is simply too much state to swap.
>
> In this model there would be no change at the normal user level,
> Ctrl-Atl-num at a normal user console will still get you another
> session. A hot key would display the system management console,
> another would make it disappear.

Okay, and have the kernel trap the hotkey and call out to a usermode helper? 
Good idea, but I'm going to stick it way down on my TODO list, since it's 
something that would better be implemented after the framework for drmcon is 
in place.

DRH
