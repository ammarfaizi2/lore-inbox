Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVCQQ4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVCQQ4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVCQQ4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:56:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43025 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261230AbVCQQzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:55:53 -0500
Date: Thu, 17 Mar 2005 16:55:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Albert Cahalan <albert@users.sf.net>
Cc: Christoph Lameter <clameter@sgi.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
Message-ID: <20050317165534.B12344@flint.arm.linux.org.uk>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	Christoph Lameter <clameter@sgi.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	Matt Mackall <mpm@selenic.com>, john stultz <johnstul@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	George Anzinger <george@mvista.com>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
	paulus@samba.org, schwidefsky@de.ibm.com,
	keith maanthey <kmannth@us.ibm.com>,
	Patricia Gaughen <gone@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
	mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
	Darren Hart <darren@dvhart.com>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Anton Blanchard <anton@samba.org>, donf@us.ibm.com
References: <20050313004902.GD3163@waste.org> <1110825765.30498.370.camel@cog.beaverton.ibm.com> <20050314192918.GC32638@waste.org> <1110829401.30498.383.camel@cog.beaverton.ibm.com> <20050314195110.GD32638@waste.org> <1110830647.30498.388.camel@cog.beaverton.ibm.com> <20050314202702.GF32638@waste.org> <1110852973.1967.180.camel@cube> <Pine.LNX.4.58.0503141920460.16054@schroedinger.engr.sgi.com> <1110900235.7893.207.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1110900235.7893.207.camel@cube>; from albert@users.sf.net on Tue, Mar 15, 2005 at 10:23:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 10:23:54AM -0500, Albert Cahalan wrote:
> On Mon, 2005-03-14 at 19:22 -0800, Christoph Lameter wrote:
> > On Mon, 14 Mar 2005, Albert Cahalan wrote:
> > 
> > > When the vsyscall page is created, copy the one needed function
> > > into it. The kernel is already self-modifying in many places; this
> > > is nothing new.
> > 
> > AFAIK this will only works on ia32 and x86_64 and not definitely not
> > on ia64. Who knows about the other platforms ....
> 
> I'll bet it does work fine on IA-64. If it didn't, you would
> be unable to load the kernel or load an executable.
> 
> I know it works for PowerPC. You'll need an isync instruction
> of course. You may also want a sync instruction and some code
> to invalidate the cache.
> 
> Setting up the page content should be a 1-time operation done
> at boot. Check your processor manuals as needed.

Won't work on ARM.  We have XIP kernels, which prevents the use of
self-modifying code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
