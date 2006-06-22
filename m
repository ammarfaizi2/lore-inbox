Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbWFVD4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWFVD4q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWFVD4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:56:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29880 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751635AbWFVD4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:56:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg KH <greg@kroah.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/25] Decouple IRQ issues (MSI, i386, x86_64, ia64)
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<20060621102407.GA18447@elte.hu> <20060621162537.GC25961@kroah.com>
Date: Wed, 21 Jun 2006 21:55:19 -0600
In-Reply-To: <20060621162537.GC25961@kroah.com> (Greg KH's message of "Wed, 21
	Jun 2006 09:25:37 -0700")
Message-ID: <m164it6dzs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>> Very nice! Your queue addresses all of the remaining grievances i had 
>> about the x86_64/i386 IRQ code (MSI/balancing) and does this ontop of 
>> genirq, which is very good. This is much more than i hoped for when you 
>> told us about your project! :)
>> 
>> The only open bigger issue i guess (besides all the smaller code details 
>> that i'm sure we'll sort out) is timing. Your queue, as tempting as it 
>> is, is probably not 2.6.18 material. _I_ would certainly dare this for 
>> 2.6.18, but Andrew/Linus would kill me i guess.
>
> No, it needs to sit in -mm for a while.  All of the new 2.6.18 stuff
> already has been in there, this is a bit too late for it.  I have no
> problem with taking this and letting it get beat on for a few months and
> then go into 2.6.19.

As long as these patches get put somewhere for a beating I don't care.

They are so cross architecture I'm not really certain where they should sit.

>> So the question is - are we brave/confident enough to try to stabilize 
>> this in the next couple of days and drop it into 2.6.18 together with 
>> the other bits of genirq?
>
> No, see above please.

If we did it I would support them.  

The important thing is that these patches get put somewhere so other
people can build on them.

If you don't count msi the changes are pretty trivial.  Especially
with the last couple of patches removed from the patchset.

>> I strongly suspect that the bugs this patchset will introduce is
>> roughly equal to the bugs we already have due to the existing MSI and
>> irq-balancing unrobustnesses, so we might as well go for that, instead
>> of prolonging the pain by doing a two-stage (or 3-stage) process.
>> (which would be to introduce genirq stage #1 now, then introduce
>> genirq stage #2 in 2.6.19) Delaying genirq to 2.6.19 altogether would
>> be messy i think and would interfere with ben's (and others') platform
>> plans. Hm?
>
> I don't object to genirq to go in now for 2.6.18, but this series is too
> new.  Incremental changes please :)

I object to genirq going into 2.6.18 without fixing the x86_64 and
the x86 regressions I spotted with the number of calls to move_native_irq.
x86 calls it twice and x86_64 not at all.  But that is a trivial fix.

My patchset kills the root case (CONFIG_PCI_MSI non msi irq behavioral changes).

Eric

