Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266496AbUGPHFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUGPHFi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 03:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUGPHFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 03:05:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19387 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266496AbUGPHFd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 03:05:33 -0400
Date: Fri, 16 Jul 2004 08:05:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Ron House <house@usq.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug or Feature? Multiply mounted device
Message-ID: <20040716070531.GA12308@parcelfarce.linux.theplanet.co.uk>
References: <40F75738.4040601@usq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F75738.4040601@usq.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 02:19:04PM +1000, Ron House wrote:
> Hi all, apologies for posting here, but I need to ask the guys who know 
> for sure. In my fstab, I have two entries for my DOS HD so I can mount 
> it with or without CRLF mangling, as follows (sorry for the line splitting):
> 
> /dev/hda5   /d      vfat 
> rw,suid,dev,async,users,umask=033,uid=1500,gid=1001,conv=b 0 0
> /dev/hda5   /dc     vfat 
> rw,suid,dev,async,users,umask=033,uid=1500,gid=1001,noauto,conv=a 0 0
> 
> I just noticed with my new Linux setup (kernel 2.4.20-8smp - don't know 
> what all that means) that it will let me mount both at once, so I can 
> see the partition as either /d or /dc at the same time. I may be going 
> mad, but I seem to recall with my previous kernel that I couldn't do this.
> 
> My question: Bug or feature? If I write all sorts of stuff to both 
> logical devices, will it correctly sort it all out on the same physical 
> device, or will I wreck the partition? All help much appreciated!

You will get both mountpoints as aliases to the tree.  Note that all
fs-specific flags will be ignored on subsequent mounts right now.
Eventually different flags will give you -EBUSY.

BTW, conv= is silently ignored by vfat, so your conv=a is a no-op - that
stuff simply doesn't belong in kernel and CRLF mangling had been removed
quite a while ago (try to make it play nice with mmap(2) and see how soon
you'll run away screaming).

