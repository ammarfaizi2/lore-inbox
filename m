Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVDDTkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVDDTkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDDTkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:40:16 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:24715 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261351AbVDDTkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:40:07 -0400
Date: Mon, 4 Apr 2005 13:42:04 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
cc: Nigel Cunningham <ncunningham@cyclades.com>, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       len.brown@intel.com
Subject: Re: [ACPI] Re: [RFC 0/6] S3 SMP support with physcial CPU hotplug
In-Reply-To: <20050404113129.GA7120@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.61.0504041322490.30273@montezuma.fsmlabs.com>
References: <1112580342.4194.329.camel@sli10-desk.sh.intel.com>
 <20050403193750.40cdabb2.akpm@osdl.org> <1112608444.3757.17.camel@desktop.cunningham.myip.net.au>
 <20050404113129.GA7120@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel!

On Mon, 4 Apr 2005, Pavel Machek wrote:

> > > > The patches are against 2.6.11-rc1 with Zwane's CPU hotplug patch in -mm
> > > >  tree.
> > > 
> > > Should I merge that thing into mainline?  It seems that a few people are
> > > needing it.
> > 
> > Perhaps we should address the MTRR issue first.
> > 
> > I've had code in Suspend2 for quite a while (6 months+) that removes the
> > sysdev support for MTRRs and saves and restores them with CPU context,
> > thereby avoiding the smp_call-while-interrupts-disabled issue. Perhaps
> > it would be helpful here?
> 
> This seems like separate issue... I'd prefer not to block this patch.
> 
> MTRRs should be probably handled by some kind of "cpu is going down"
> and "cpu is going up" callbacks... Zwane, do you have any ideas?
> Linklist of handlers should be enough...

Hmm, it seems to me that we if we're bringing up additional processors we 
only need to update the processor coming online (using mtrrs from an 
online processor) and hold a lock stopping any other updates. So for that, 
we definitely need online and offline callbacks.

Thanks,
	Zwane

