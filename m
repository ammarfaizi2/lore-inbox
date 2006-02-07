Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWBGDCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWBGDCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWBGDCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:02:13 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:1804 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964919AbWBGDCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:02:13 -0500
Date: Mon, 6 Feb 2006 22:01:29 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060207030129.GA23860@mail>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Nigel Cunningham <nigel@suspend2.net>,
	suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139251682.2791.290.camel@mindpipe> <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl> <20060207003713.GB31153@voodoo> <20060207004611.GD1575@elf.ucw.cz> <20060207005930.GD31153@voodoo> <1139275143.2041.24.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139275143.2041.24.camel@mindpipe>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/06 08:19:02PM -0500, Lee Revell wrote:
> On Mon, 2006-02-06 at 19:59 -0500, Jim Crilly wrote:
> > I guess reasonable is a subjective term. For instance, I've seen quite
> > a few people vehemently against adding new ioctls to the kernel and
> > yet you'll be adding quite a few for /dev/snapshot. I'm just of the
> > same mind as Nigel in that it makes the most sense to me that the
> > majority of the suspend/hibernation process to be in the kernel. 
> 
> No one is saying that ANY new ioctls are bad, just that the KISS
> principle of engineering dictates that it's bad design to use ioctls
> where a simple read/write to a sysfs file will do.
> 

I understand that, but shouldn't the KISS principle also be applied to
the user interface of a feature? As it stands it looks like Suspend2
is going to be a lot simpler for users to configure and get right than
uswsusp. As long as you have Suspend2 enabled in the kernel it 'just
works', even if you don't have the userland UI it'll still suspend and
resume just without the progress bars. There is still some room for error
with things like forgetting to enable the swap writer and then attempting
to suspend to a swap device or making lzf a module and forgetting to
load it before resuming from a compressed image, but those are no worse
than any other kernel option.

With uswsusp it'll be more flexible in that you'll be able to use any
userland process or library to transform the image before storing it, but
the suspend and resume processes are going to be a lot more complicated.
For instance, how are you going to tell the kernel that you need the
uswsusp UI binary, /bin/gzip and /usr/bin/gpg to run after the rest of
userland has been frozen?

Jim.
