Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUHGXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUHGXxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHGXwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:52:54 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:7051 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S264884AbUHGXv7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:51:59 -0400
From: David Brownell <david-b@pacbell.net>
To: ncunningham@linuxmail.org
Subject: Re: Solving suspend-level confusion
Date: Sat, 7 Aug 2004 15:24:59 -0700
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Oliver Neukum <oliver@neukum.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040730164413.GB4672@elf.ucw.cz> <200408051732.04920.david-b@pacbell.net> <1091772799.2532.50.camel@laptop.cunninghams>
In-Reply-To: <1091772799.2532.50.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071524.59737.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 23:13, Nigel Cunningham wrote:

> > > device_resume_tree(&default_device_tree);
> > > 
> > > Proof of the pudding coming :>
> > 
> > Sounds good.  Will it be possible to remove devices during
> > these tree operations?  Probably never the current one.
> 
> Ummm. I suppose so. It's only affecting the PM section and not the
> device tree proper, so I don't see why it should cause any failures.

If you're not changing dpm_sem usage, it's a self-deadlock
situation.  I guess that bug needs to be fixed in its own right.


> > And (evil chuckle) how will it behave if two tasks are doing
> > that concurrently?  The no-overlap case would be fully
> > parallel, I'd hope!
> 
> All of the operations still use dpm_sem, so really strange things
> shouldn't happen. That said, if you're trying to suspend to disk and ram
> at the same time, you get what you deserve, 

Telling one subsystem to suspend as deeply as possible doesn't
mean no other subsystem will be needed much sooner.  And
why you'd suspend a system "to disk" when the system only
has some flash ram?  :)

- Dave
