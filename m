Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVACAcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVACAcv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVACAcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:32:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:5898 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261359AbVACAcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:32:39 -0500
Date: 3 Jan 2005 01:32:37 +0100
Date: Mon, 3 Jan 2005 01:32:37 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050103003237.GA89490@muc.de>
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de> <20050102203005.GA9491@lst.de> <m1is6fy2vm.fsf@muc.de> <20050102223650.GA5818@localhost> <20050102233039.GB71343@muc.de> <20050103002102.GA5987@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103002102.GA5987@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 07:21:02PM -0500, David Meybohm wrote:
> > > the new security module that is being loaded has no idea what state all
> > > processes are in when the module gets loaded?
> > 
> > This can still be fine if you don't care about the security of 
> > everything that runs before (e.g. because it is controlled early
> > startup code). If you care about their security don't do it when
> > it hurts. 
> 
> But this also means every security module has to handle the case of
> being loaded after this time in the boot process interactively by
> administrators.  That's very complex and race-prone.

The administrator has to prevent the case or make sure
it doesn't cause any problems.

You just have to be careful to not start any daemons before it,
safest is probably to load it in the initrd.

> 
> > > What do you think about only allowing init to load LSM modules i.e.
> > > check in {mod,}register_security that current->pid == 1.
> > 
> > I think it's a bad idea. Such policy should be left to user space.
> 
> Well, by excluding some policy you have to put more code in the kernel
> in the LSM modules to handle being loaded at any time.  So, I don't

> think the dogma of "no policy in the kernel" is a good one to follow
> here:  it ignores the problem and creates new ones.

The kernel just assumes that root knows what he/she/it is doing.
Zillions of other kernel interfaces make the same assumptions.

-Andi
