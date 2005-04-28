Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVD1SOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVD1SOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVD1SOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:14:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53689 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262207AbVD1SLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:11:50 -0400
Date: Thu, 28 Apr 2005 15:08:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mj@ucw.cz, lmb@suse.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050428130819.GF2226@openzaurus.ucw.cz>
References: <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz> <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu> <20050427175425.GA4241@ucw.cz> <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQquc-0002W6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Is it possible to limit all these from kernelspace?  Probably yes,
> > > although a timeout for operations is something that cuts either way.
> > > And the compexity of these checks would probably be orders of
> > > magnitude higher then the check we are currently discussing.
> > 
> > Yes ... but does the check we are discussing really solve the
> > problem?
> > 
> > Let's say that you attempt to export home directories of users by a
> > user-space NFS daemon. This daemon probably changes its fsuid to
> > match the remote user, so the check happily accepts the access and
> > the user is able to lock up the daemon.
> 
> Valid point.  The only defense is that when a program set's fsuid,
> it's performing the operation "on behalf of the user".  So the user is
> actually doing DoS against himself.
> 
> Of course this is not strictly true.  E.g. in the userspace NFS case
> it's probably a DoS against all users of the mount.

Exactly. So can we simply merge root-only fuse, and then worry
how to make it safe with user-mounted fuse. See your own unfsd example
why user-mounting is bad.

One possible solution would be to have root-owned fused that
talks to user-owned fused-s and checks they are behaving correctly?

Second is somehow improving those two lines this long thread is all about...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

