Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbUANWYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbUANWYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:24:09 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:63360
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264322AbUANWX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:23:56 -0500
Date: Wed, 14 Jan 2004 17:22:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic subarch
 UP installer kernels
In-Reply-To: <200401141159.03248.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0401141720590.9824@montezuma.fsmlabs.com>
References: <200401131627.02138.jamesclv@us.ibm.com>
 <Pine.LNX.4.58.0401131957420.18388@montezuma.fsmlabs.com>
 <200401141159.03248.jamesclv@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004, James Cleverdon wrote:

> On Tuesday 13 January 2004 5:00 pm, Zwane Mwaikambo wrote:
> > On Tue, 13 Jan 2004, James Cleverdon wrote:
> > > Problem:  Earlier I didn't consider the case of the generic sub-arch and
> > > uni-proc installer kernels used by a number of distros.  It currently is
> > > scaled by NR_CPUS.  The correct values should be big for summit and
> > > generic, and can stay the same for all others.
> >
> > This all looks strange, especially in assign_irq_vector() does this
> > mean that you'll try and allocate up to 1024 vectors?
>
> The irq_vector array name is a bit misleading.  It contains the vectors for
> each potential I/O APIC RTE.  The array needs to be at least the sum of all
> the RTEs in the system.  Summit PCI bridge chips have large I/O APICs (50
> RTEs), and a large system has up to 16 of them.  16*50 = 800.  Allocating 1k
> entries provides a pad for the future, and u8 doesn't cost much.

Ok i understand the need to accomodate all the RTEs, but what i was
considering was what happens when assign_irq_vector runs out of vectors to
allocate and ends up "wrapping". I just sent an email to Jun Nakajima with
a bit more detail.

Thanks,
	Zwane

