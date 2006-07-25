Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWGYUol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWGYUol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWGYUol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:44:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751572AbWGYUok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:44:40 -0400
Date: Tue, 25 Jul 2006 16:42:28 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: 76306.1226@compuserve.com, mingo@elte.hu
Subject: Re: + spinlock_debug-dont-recompute-jiffies_per_loop.patch added to -mm tree
Message-ID: <20060725204228.GE13829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, 76306.1226@compuserve.com,
	mingo@elte.hu
References: <200607251910.k6PJASfo006168@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607251910.k6PJASfo006168@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 12:10:28PM -0700, Andrew Morton wrote:
 > 
 > The patch titled
 > 
 >      spinlock_debug: don't recompute (jiffies_per_loop applied-patches arch backup bin block config-x COPYING CREDITS CREDITS~git-gfs2 crypto CVS Documentation drivers fs include init ipc Kbuild kernel lib linus-series log mach MAINTAINERS MAINTAINERS~avr32-arch MAINTAINERS~edac-new-opteron-athlon64-memory-controller-driver MAINTAINERS~git-gfs2 MAINTAINERS~git-klibc MAINTAINERS.orig MAINTAINERS~origin MAINTAINERS~qla3xxx-NIC-driver MAINTAINERS~x86_64-mm-add-a-maintainers-entry-for-calgary Makefile Makefile~git-kbuild Makefile~git-klibc Makefile~mm Makefile.orig Makefile.rej mm net notes patches pc README REPORTING-BUGS scripts security series 'series sound Tags test.img txt usr HZ) in spinloop
 > 
 > has been added to the -mm tree.  Its filename is

Wow, that's umm, spectacular ;-)

 > ------------------------------------------------------
 > Subject: spinlock_debug: don't recompute (jiffies_per_loop applied-patches arch backup bin block config-x COPYING CREDITS CREDITS~git-gfs2 crypto CVS Documentation drivers fs include init ipc Kbuild kernel lib linus-series log mach MAINTAINERS MAINTAINERS~avr32-arch MAINTAINERS~edac-new-opteron-athlon64-memory-controller-driver MAINTAINERS~git-gfs2 MAINTAINERS~git-klibc MAINTAINERS.orig MAINTAINERS~origin MAINTAINERS~qla3xxx-NIC-driver MAINTAINERS~x86_64-mm-add-a-maintainers-entry-for-calgary Makefile Makefile~git-kbuild Makefile~git-klibc Makefile~mm Makefile.orig Makefile.rej mm net notes patches pc README REPORTING-BUGS scripts security series 'series sound Tags test.img txt usr HZ) in spinloop
 > From: Chuck Ebbert <76306.1226@compuserve.com>
 > 
 > In spinlock_debug.c, the spinloops call __delay() on every iteration. 
 > Because that is an external function, (jiffies_per_loop * HZ), the loop's
 > iteration limit, gets recomputed every time.  Caching it explicitly
 > prevents that.

What is the purpose of those __delays being there at all ?
Seems odd to be waiting that long when the spinlock could become available
a lot sooner.  (These also make spinlock debug really painful
on boxes with huge numbers of CPUs).

		Dave

-- 
http://www.codemonkey.org.uk
