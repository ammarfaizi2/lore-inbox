Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVABXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVABXas (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVABXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 18:30:48 -0500
Received: from colin2.muc.de ([193.149.48.15]:28178 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261344AbVABXal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 18:30:41 -0500
Date: 3 Jan 2005 00:30:39 +0100
Date: Mon, 3 Jan 2005 00:30:39 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050102233039.GB71343@muc.de>
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de> <20050102203005.GA9491@lst.de> <m1is6fy2vm.fsf@muc.de> <20050102223650.GA5818@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102223650.GA5818@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 05:36:50PM -0500, David Meybohm wrote:
> On Sun, Jan 02, 2005 at 09:47:41PM +0100, Andi Kleen wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> > >
> > > At least Debian currently inserts the capabilities module on boot.
> > 
> > That is fine as long as they control all code executed before
> > that module loading.  And if they do not it is their own fault
> > and they have to fix that in user space or compile the capability in.
> > Unix policy is to not stop root from doing stupid things because
> > that would also stop him from doing clever things.
> 
> But if the module system creates security holes in the security system,
> shouldn't that be avoided?  Isn't this is a fundamental problem because

A kernel module is by definition a security hole. It can do everything,
including setting the uids of all processes to 0.

> the new security module that is being loaded has no idea what state all
> processes are in when the module gets loaded?

This can still be fine if you don't care about the security of 
everything that runs before (e.g. because it is controlled early
startup code). If you care about their security don't do it when
it hurts. 

> What do you think about only allowing init to load LSM modules i.e.
> check in {mod,}register_security that current->pid == 1.  Then init can
> load the policy from some file in /etc changeable by the administrator
> before starting any other processes.  Then you don't have to recompile
> the kernel to change policies, but you still need to reboot and can't
> get into funky states.

I think it's a bad idea. Such policy should be left to user space.

-Andi
