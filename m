Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTABNCC>; Thu, 2 Jan 2003 08:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTABNCC>; Thu, 2 Jan 2003 08:02:02 -0500
Received: from [81.2.122.30] ([81.2.122.30]:6149 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261599AbTABNCA>;
	Thu, 2 Jan 2003 08:02:00 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301021307.h02D73hU001084@darkstar.example.net>
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6
To: davidsen@tmr.com (Bill Davidsen)
Date: Thu, 2 Jan 2003 13:07:03 +0000 (GMT)
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030102073757.18246B-100000@gatekeeper.tmr.com> from "Bill Davidsen" at Jan 02, 2003 07:47:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > | > > | Um, you read the .config, which hopefully is stored somewhere.
> > | > > | (Although you could resurrect the /proc/config patch which goes around
> > | > > | every so often).  There are many things you can't tell by reading
> > | > > | /proc/ksyms.
> > | > >
> > | > > Right, the .config file is the answer.  And there are at least 2
> > | > > patch solutions for it, the /proc/config that Rusty mentioned, or
> > | > > the in-kernel config that Khalid Aziz and others from HP did along
> > | > > with me, and it's in 2.4.recent-ac or 2.5.recent-dcl or 2.5.recent-cgl.
> > | >
> > | > It would be useful to have a few global options perhaps included in /proc
> > | > (or wherever) on all kernels. By global I mean those which affect the
> > | > entire kernel, like preempt or smp, rather than driver options. We already
> > | > note 'tainted,' so this is not a totally new idea. It would seem that most
> > | > of the processor options could fall in this class, MCE, IOAPIC, etc.
> > | >
> > | > If the aim is to speed stability, putting any of the "whole config"
> > | > options in and defaulted on might be a step toward that.
> > |
> > | Having all of the config options in a /proc/config file would be a
> > | great help for people using my new bug database, because it would
> > | allow them to upload the .config for their current kernel even if it
> > | is not one they have compiled themselves.
> > 
> > It seems that we still differ that putting them in /proc
> > is required.  I don't see a hard requirement for that as long
> > as the vmlinu[xz] or bzImage etc. file contains the config
> > strings, which is what the other mentioned patch does.
> 
> The problem is that a failing kernel shouldn't be trying to get that info,
> and it would be (at least) as valuable as tainted to have a summary line
> showing the global options in the oops.

Yes, you're right, I wasn't thinking - people generally aren't going
to be submitting bug reports about the kernel that's actually running,
they'll boot in to another, (stable), one.

> > They are still affixed to a particular file, and they can be
> > pulled from it whether it's the running kernel or not.
> > Putting them in /proc wastes RAM and is undesirable, at least
> > on small systems and most embedded platforms.
> So do many other optional things. That's why they're optional. Putting the
> whole .config in /proc should be optional, a few global flags like preempt
> are probably valuable enough in an oops to justify a few bytes.

The way to do it, then, would be to have a directory with files
created for each enabled option.

I.E. instead of having a file that resembled a .config file somewhere
in /proc, have a directory called config in proc:

# ls /proc/config
CONFIG_X86	CONFIG_MMU		CONFIG_SWAP
CONFIG_UID16	CONFIG_GENERIC_ISA_DMA	CONFIG_EXPERIMENTAL

..etc...

# cat /proc/config/CONFIG_X86
y

That way, on an embedded system you can eliminate some of the entries,
and a check such as

if exist(/proc/CONFIG_X86) echo 'Running on an X86'

will still work, regardless of whether, E.G. CONFIG_PCI_NAMES has been
included, or left out to save memory.

> > | At the moment, the facility to search for bugs via the config options
> > | that cause them is only useful for people who are compiling their own
> > | kernel.
> 
> That one *would* be solved by a .config added to the vmlinuz file, or by a
> config list in /lib/modules/{kernel}, etc.

One solution would be for people to upload their whole kernel, and
have my DB just parse the .config part at the end - a bit wasteful,
but if it makes it easier for people to submit bug reports, then maybe
it's a necessary feature.

John.
