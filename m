Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWBTJUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWBTJUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 04:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWBTJUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 04:20:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4684 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964796AbWBTJUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 04:20:15 -0500
Date: Mon, 20 Feb 2006 10:20:09 +0100
From: Jens Axboe <axboe@suse.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, karim@opersys.com,
       compudj@krystal.dyndns.org
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060220092008.GZ8852@suse.de>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17401.21427.568297.830492@tut.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19 2006, Tom Zanussi wrote:
> Paul Mundt writes:
>  > On Sun, Feb 19, 2006 at 09:56:23AM -0800, Greg KH wrote:
>  > 
> 
> [...]
> 
>  > > And I agree with Christoph, with this change, you don't need a separate
>  > > relayfs mount anymore.
>  > > 
>  > Yes, that's where I was going with this, but I figured I'd give the
>  > relayfs people a chance to object to it going away first.
>  > 
>  > If with this in sysfs and simple handling through debugfs people are
>  > content with the relay interface for whatever need, then getting rid of
>  > relayfs entirely is certainly the best option. We certainly don't need
>  > more pointless virtual file systems.
>  > 
>  > I'll work up a patch set for doing this as per Cristoph's kernel/relay.c
>  > suggestion. Thanks for the feedback.
> 
> Considering that I recently offered to post a patch that would do
> essentially the same thing, I can't have any objections to this. ;-)
> 
> But just to make sure I'm not missing anything in the patches, please
> let me know if any of the following is incorrect.  What they do is
> remove the fs part of relayfs and move the remaining code into a
> single file, while leaving everthing else basically intact i.e. the
> relayfs kernel API remains the same and existing clients would only
> need to make relatively minor changes:
> 
> - find a new home for their relay files i.e. sysfs, debufs or procfs.
> 
> - replace any relayfs-specific code with their counterparts in the new
>   filesystem i.e. directory creation/removal, non-relay ('control')
>   file creation/removal.
> 
> - change userspace apps to look for the relay files in the new
>   filesystem instead of relayfs e.g. change /relay/* to /sys/*
>   in the relay file pathnames.
> 
> Although I personally don't have any problems with doing this, I've
> added some of the authors of current relayfs applications to the cc:
> list in case they might have any objections to it.  The major relayfs
> applications I'm aware of are:
> 
> - blktrace, currently in the -mm tree.  This could probably move its
>   relayfs files to sysfs using your new interface.

blktrace just needs minor file location changes to work with this
scheme, so no problem for me.

I think the patch is a good idea, it's a lot nicer than a separate fs.

-- 
Jens Axboe

