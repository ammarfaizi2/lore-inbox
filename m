Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVCAJFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVCAJFe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVCAJFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:05:33 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:33446 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261834AbVCAJFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:05:05 -0500
Subject: Re: swsusp logic error?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: martin f krafft <madduck@madduck.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050301082254.GA4402@piper.madduck.net>
References: <20050208203950.GA21623@cirrus.madduck.net>
	 <20050227174309.GA27265@piper.madduck.net>
	 <20050228135604.GA6364@piper.madduck.net> <200502281533.01621.rjw@sisk.pl>
	 <20050228144506.GA11125@piper.madduck.net>
	 <20050301082254.GA4402@piper.madduck.net>
Content-Type: text/plain
Message-Id: <1109667621.4229.40.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 01 Mar 2005 20:00:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin.

On Tue, 2005-03-01 at 19:22, martin f krafft wrote:
> also sprach Pavel Machek <pavel () ucw ! cz>
> > > > Could you, please, verify that you don't need to load any
> > > > modules from initrd for your swap partition to work?  It won't
> > > > work if you do.
> > > 
> > > this makes perfect sense to me when you talk about resuming.
> > > does it also apply to suspending?
> > 
> > As kernel is the same for suspend and resume... Yes, it seems it
> > makes sense.
> 
> But before the suspend, the IDE modules are loaded, so the swap
> drive is accessible, no? Or are IDE modules (yes, they are modules
> here) unloaded just before writing to swap?

I think Pavel got a bit confused somewhere here! The IDE modules will
always be loaded when you're doing the suspend, right to the very end.
At resume time, they need to be loaded the swsusp attempts to parse the
resume= parameter, so that it can actually succeed in doing that.
Suspend2 works with IDE made as modules because it allows you to delay
that parsing until after the modules are loaded (you put echo >
/proc/software_suspend/do_resume in your initrd after modules are loaded
but before you mount filesystems). Last time I looked, swsusp didn't
have that capability and thus required IDE to be built in. Pavel, has
that changed?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


