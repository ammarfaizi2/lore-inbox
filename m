Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965297AbVKBWFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbVKBWFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbVKBWFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:05:45 -0500
Received: from tim.rpsys.net ([194.106.48.114]:4789 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S965297AbVKBWFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:05:44 -0500
Subject: Re: best way to handle LEDs
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20051102211146.GG23943@elf.ucw.cz>
References: <20051101234459.GA443@elf.ucw.cz>
	 <1130891953.8489.83.camel@localhost.localdomain>
	 <20051102135614.GL30194@elf.ucw.cz>
	 <1130942322.8523.15.camel@localhost.localdomain>
	 <20051102211146.GG23943@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 22:05:23 +0000
Message-Id: <1130969124.8523.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 22:11 +0100, Pavel Machek wrote:
> > > Perhaps I'd keep it simple and leave it at
> > > 
> > > * do hardcoded kernel action for this led
> > > 
> > > or
> > > 
> > > * do whatever userspace tells you.
> > > 
> > > That way you will not be able to remap charger LED onto hard disk
> > > indicator, but we can support that on ibm-acpi too. (Where hw controls
> > > LEDs like "sleep", but lets you control them. You can't remap,
> > > though).
> > 
> > Then the arguments start about which function should be hardcoded to
> > which leds and why can't userspace access these triggers?
> 
> Because there are some machines (IBM thinkpad) where LEDs are either
> driven by userspace, or driven by hardware. I'd like to export that
> functionality using same interface.

A specific limitation of ACPI LEDs shouldn't constrain the interface and
spoil things for everything that can support generic triggers.

> > I'd prefer a totally flexible system and it doesn't really add much
> > complexity once you have a trigger framework which we're going to need
> > to handle mutiple led trigger sources sanely anyway.
> 
> Unfortunately hardware can not do that, at least for IBM
> thinkpad. 

So we need to find a way of providing this functionality, maybe by
allowing leds to provide their own specific triggers. Thinking about
this limitation, I think it can be handled by the trigger
implementation.

> Plus, remapping harddisk indicator on battery led is not
> something I'd like to support :-). 

It wouldn't do that be default but I see no reason to constrain any
interface to stop this. The kernel isn't supposed to set policy (or in
my view put unnecessary constraints on interfaces).

Richard



