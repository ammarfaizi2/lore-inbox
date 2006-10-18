Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWJRQQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWJRQQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJRQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:16:25 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:46095 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1161190AbWJRQQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:16:24 -0400
Date: Wed, 18 Oct 2006 17:16:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
cc: john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 Time: Avoid PIT SMP lockups
In-Reply-To: <20061011142646.eb41fac3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0610181650001.28841@blysk.ds.pg.gda.pl>
References: <1160596462.5973.12.camel@localhost.localdomain>
 <20061011142646.eb41fac3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006, Andrew Morton wrote:

> So this patch has the potential to screw up people who have 2-way or 4-way,
> no hpet/pm-timer and dodgy TSCs.

 Note that all APIC-based SMP systems (even these rare i486 beasts) by 
definition do have local APIC timers, one per CPU, with a reasonable 
resolution which could likely be used instead.  There is an erratum in 
some early Pentium integrated APICs, where a tick is lost when 0 is 
reached (the timer counts downwards), so it may be needed to be taken into 
account for good timekeeping, but otherwise the timers look like a 
reasonable choice.  The timers are local to their respective CPUs and are 
never written by Linux (see references to APIC_TMCCT), so there is no need 
for locking to access them.

  Maciej
