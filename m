Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVACA1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVACA1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVACA1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:27:48 -0500
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:29347 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261353AbVACA1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:27:36 -0500
Date: Sun, 2 Jan 2005 19:21:02 -0500
From: David Meybohm <dmeybohmlkml@bellsouth.net>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050103002102.GA5987@localhost>
Mail-Followup-To: Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de> <20050102203005.GA9491@lst.de> <m1is6fy2vm.fsf@muc.de> <20050102223650.GA5818@localhost> <20050102233039.GB71343@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102233039.GB71343@muc.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 12:30:39AM +0100, Andi Kleen wrote:
> 
> A kernel module is by definition a security hole. It can do everything,
> including setting the uids of all processes to 0.

Yes, but allowing the administrator to easily unintentionally create
security holes in loading a security module defeats the whole purpose of
having modular security.

> > the new security module that is being loaded has no idea what state all
> > processes are in when the module gets loaded?
> 
> This can still be fine if you don't care about the security of 
> everything that runs before (e.g. because it is controlled early
> startup code). If you care about their security don't do it when
> it hurts. 

But this also means every security module has to handle the case of
being loaded after this time in the boot process interactively by
administrators.  That's very complex and race-prone.

> > What do you think about only allowing init to load LSM modules i.e.
> > check in {mod,}register_security that current->pid == 1.
> 
> I think it's a bad idea. Such policy should be left to user space.

Well, by excluding some policy you have to put more code in the kernel
in the LSM modules to handle being loaded at any time.  So, I don't
think the dogma of "no policy in the kernel" is a good one to follow
here:  it ignores the problem and creates new ones.

Dave
