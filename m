Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWBCJtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBCJtl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 04:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBCJtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 04:49:41 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:42933 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932137AbWBCJtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 04:49:40 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: pavel@ucw.cz, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ 00/10] [Suspend2] Modules support.
In-Reply-To: <1138919381.15691.162.camel@mindpipe>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <20060202142323.088a585c.akpm@osdl.org> <1138919381.15691.162.camel@mindpipe>
Date: Fri, 3 Feb 2006 09:49:33 +0000
Message-Id: <E1F4xZN-0001K1-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:

> Follow up - do we have a rough idea how bad the suspend problem is, like
> approximately what % of laptops don't DTRT and just suspend when you
> close the lid?

It's arguable whether "just suspending when you close the lid" is
actually DTRT, but if you want "how many x86 laptops can we successfully
suspend and resume" then the number is between 80-90% for RAM and a
little more than that for disk (numbers based on Ubuntu, other
distributions don't have as much infrastructure for this right now).
This is based on doing hacky things like unloading all the network and
USB drivers before suspend, but by and large the driver situation is
much improved. The single biggest problem is video reinitialisation, and
that can't be solved in-kernel.

Based on actual hard, shipping evidence - swsusp works sufficiently well
that throwing it out and replacing it with a different implemenation is
entirely unnecessary. The two big advantages that suspend2 brings us are

1) Improved speed (an entirely fair objection to swsusp)
2) Graphical bling (and I think doing that in the kernel is pretty
insane)

Pavel's proposed plan brings us both of those without massive kernel
changes, so I'm really quite tempted to go with that. From a
distribution standpoint, integrating it is very straightforward.

(By and large, the biggest problem is repeated kernel regressions that
hit suspend in bizarre ways. This doesn't get picked up on quickly
because almost nobody is using this code, because "everyone knows" it
doesn't work. Except it /does/. What we need is for distributions to
actually work together on this, rather than everyone trying to fix the
same problems independently, each coming up with different solutions and
the world generally being a miserable place)

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
