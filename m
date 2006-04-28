Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWD1LYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWD1LYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 07:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWD1LYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 07:24:19 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:61581 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S965074AbWD1LYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 07:24:18 -0400
Subject: Re: Some Concrete AppArmor Questions - was Re: [RFC][PATCH 0/11]
	security: AppArmor - Overview
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ken Brush <kbrush@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Chris Wright <chrisw@sous-sol.org>,
       James Morris <jmorris@namei.org>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <ef88c0e00604271058q203d0553sf45401914a892799@mail.gmail.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060421173008.GB3061@sorel.sous-sol.org>
	 <1145642853.21749.232.camel@moss-spartans.epoch.ncsc.mil>
	 <17484.20906.122444.964025@cse.unsw.edu.au>
	 <1145911526.14804.71.camel@moss-spartans.epoch.ncsc.mil>
	 <17485.55676.177514.848509@cse.unsw.edu.au>
	 <1145984831.21399.74.camel@moss-spartans.epoch.ncsc.mil>
	 <17487.61698.879132.891619@cse.unsw.edu.au>
	 <ef88c0e00604261606g64ed5844j67890e8c3d7974a9@mail.gmail.com>
	 <1146159833.5238.95.camel@moss-spartans.epoch.ncsc.mil>
	 <ef88c0e00604271058q203d0553sf45401914a892799@mail.gmail.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 28 Apr 2006 07:28:33 -0400
Message-Id: <1146223713.11817.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 10:58 -0700, Ken Brush wrote:
> > No, it wouldn't.  The question itself is flawed - it presumes that AA
> > does confine the application to its expected behavior.
> 
> I can confine a process to my idea of it's expected behavior.

Um, only if your idea is limited to authorized capabilities and paths.
If you actually want to circumscribe the full behavior of the program
(e.g. IPC, inter-process operations), you don't have the necessary
enforcement mechanism.

> I can guarantee that if my profile does not allow write access to /etc
> that apache's write to "/etc/new_file" will not be allowed.

If it uses that path as the argument, then yes (although to be clear, AA
operates at file level and skips directory write/search checking, IIUC
from the code - see aa_filter_mask).  But you don't know whether or not
it can write to the same file via another path that is included in its
profile.

> The argument that somehow someone would setup a soft link or something
> so that apache could write to /etc via indirection is not my primary
> concern.  That is systematic of a more concerted attack and a very
> determined attacker.  Or at the very least, a mistake on my part. And
> in that case, I cannot protect myself from myself.

So you are only worried about script kiddies?  Further, once someone
crafts an exploit specifically targeting AA, knowing full well its
limitations, that exploit will become fodder for the kiddies as well.
If a security mechanism only prevents attacks that weren't designed
against it, what good is it aside from a temporary stopgap?

> I have no requirements like that. I just would prefer that when people
> try to exploit my internet services, that the programs are not allowed
> to do things that I would rather it not do. AA seems to fulfill that
> requirement.

Why can't you use existing virtualization solutions ala Vservers or
OpenVZ or whatever?

-- 
Stephen Smalley
National Security Agency

