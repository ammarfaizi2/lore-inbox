Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTABMmi>; Thu, 2 Jan 2003 07:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTABMmi>; Thu, 2 Jan 2003 07:42:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:36870 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261645AbTABMmh>; Thu, 2 Jan 2003 07:42:37 -0500
Date: Thu, 2 Jan 2003 07:47:45 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix os release detection in module-init-tools-0.9.6
In-Reply-To: <Pine.LNX.4.33L2.0301011048490.20796-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.3.96.1030102073757.18246B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, Randy.Dunlap wrote:

> On Wed, 1 Jan 2003, John Bradford wrote:
> 
> | > > | Um, you read the .config, which hopefully is stored somewhere.
> | > > | (Although you could resurrect the /proc/config patch which goes around
> | > > | every so often).  There are many things you can't tell by reading
> | > > | /proc/ksyms.
> | > >
> | > > Right, the .config file is the answer.  And there are at least 2
> | > > patch solutions for it, the /proc/config that Rusty mentioned, or
> | > > the in-kernel config that Khalid Aziz and others from HP did along
> | > > with me, and it's in 2.4.recent-ac or 2.5.recent-dcl or 2.5.recent-cgl.
> | >
> | > It would be useful to have a few global options perhaps included in /proc
> | > (or wherever) on all kernels. By global I mean those which affect the
> | > entire kernel, like preempt or smp, rather than driver options. We already
> | > note 'tainted,' so this is not a totally new idea. It would seem that most
> | > of the processor options could fall in this class, MCE, IOAPIC, etc.
> | >
> | > If the aim is to speed stability, putting any of the "whole config"
> | > options in and defaulted on might be a step toward that.
> |
> | Having all of the config options in a /proc/config file would be a
> | great help for people using my new bug database, because it would
> | allow them to upload the .config for their current kernel even if it
> | is not one they have compiled themselves.
> 
> It seems that we still differ that putting them in /proc
> is required.  I don't see a hard requirement for that as long
> as the vmlinu[xz] or bzImage etc. file contains the config
> strings, which is what the other mentioned patch does.

The problem is that a failing kernel shouldn't be trying to get that info,
and it would be (at least) as valuable as tainted to have a summary line
showing the global options in the oops.

> They are still affixed to a particular file, and they can be
> pulled from it whether it's the running kernel or not.
> Putting them in /proc wastes RAM and is undesirable, at least
> on small systems and most embedded platforms.
So do many other optional things. That's why they're optional. Putting the
whole .config in /proc should be optional, a few global flags like preempt
are probably valuable enough in an oops to justify a few bytes.

> However, that patch does also contain an option for putting
> the config entries in /proc.  :)
> 
> | At the moment, the facility to search for bugs via the config options
> | that cause them is only useful for people who are compiling their own
> | kernel.

That one *would* be solved by a .config added to the vmlinuz file, or by a
config list in /lib/modules/{kernel}, etc.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

