Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTIBSzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTIBSzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:55:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4780
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261335AbTIBSzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:55:01 -0400
Date: Tue, 2 Sep 2003 20:54:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>
Subject: Re: 2.4.22aa1
Message-ID: <20030902185453.GL1599@dualathlon.random>
References: <20030902020218.GB1599@dualathlon.random> <200309022037.39364.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309022037.39364.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 08:38:39PM +0200, Marc-Christian Petersen wrote:
> On Tuesday 02 September 2003 04:02, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > Only in 2.4.22aa1: 20_sched-o1-fixes-10
> > Only in 2.4.22pre7aa1: 20_sched-o1-fixes-9
> > 	Changed the CHILD_PENALTY logic to be centered around
> > 	50%. From Kurt Garloff.
> 
> the changes 's/CHILD_PENALTY/CHILD_INHERITANCE' and "s/PARENT_PENALTIY//' are 
> really awfull for desktops. If I change child_inheritance from 60 to 95 and 
> reintroduce the logic with parent_penaltiy, it's alot smooter under load.
> 
> I think these logics should be #ifdef'ed with CONFIG_DESKTOP, no?

s/PARENT_PENALTIY// is a noop. The CHILD_INHERITANCE moves it from 50%
to 60% and center it in the middle. If something it will increase the
sleep_avg of the child that will lead to making the childs more
responsive. It sounds quite strange that backing out this, makes the
system more responsive. btw, Kurt developed this stuff with the object
of making it more responsive, not less. What could go wrong is that the
child will get more responsiveness than the parent and maybe for your
load the interactive app is the parent and not the child, dunno.

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
