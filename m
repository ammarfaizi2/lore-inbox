Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVJEKDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVJEKDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVJEKDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:03:43 -0400
Received: from free.hands.com ([83.142.228.128]:10915 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965096AbVJEKDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:03:42 -0400
Date: Wed, 5 Oct 2005 11:03:34 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chase Venters <chase.venters@clientec.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005100333.GL10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510041840.55820.chase.venters@clientec.com> <Pine.LNX.4.58.0510050242170.20622@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510050242170.20622@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In any case, I think pretty much all of this work lives outside the kernel.
> > There is one side note I'd make about booting - my own boot process has to
> > wait forever for my Adaptec SCSI controller to wake up. It would be
> > interesting if bootup initialization tasks could be organized into dependency
> > levels and run in parallel, though as I'm a beginner to the workings of the
> > kernel I'm not entirely sure how possible this would be.

 again - depinit.

 the only thing that richard lightman didn't spend time on was the
 splitting out of hotplug / hotplug scripts such that depinit could be
 told "okay the ethernet's up now, all eth0 dependencies can now proceed"
 or "okay the scsi controller is up now, all fstab entries depending
 on this controller can now proceed".

 richard's example scripts split out "var", "usr", "home", "boot" as
 separate dependencies (actually they're symlinks to the "mount"
 pseudo-dependency) on which things like pretty much all services 
 that need to do syslogging depend on the "var" dependency you get the
 idea.

 so as long as it's hotplug that gets the notifications, great.

 if it's _not_ hotplug that's receiving the notifications, such that
 device driver initialisation cannot be delayed because you're looking at
 calling some boot-rom initialisation stuff, then, sorry, nope - you're
 gonna have to just wait for that SCSI controller to get its act
 together :)

 but again, this is off-topic for the original discussion and is again
 userspace not kernel oh well, in for a penny in for a pound.

 l.
