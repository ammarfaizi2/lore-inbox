Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVBAXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVBAXZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBAXZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:25:17 -0500
Received: from gate.crashing.org ([63.228.1.57]:39350 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262169AbVBAXZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:25:02 -0500
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e05020115032fdb8b59@mail.gmail.com>
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
	 <20050122184124.GL468@openzaurus.ucw.cz>
	 <58cb370e05020115032fdb8b59@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 10:24:48 +1100
Message-Id: <1107300288.1665.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 00:03 +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sat, 22 Jan 2005 19:41:24 +0100, Pavel Machek <pavel@suse.cz> wrote:
> > Hi!
> > 
> > > Move PM code from ide-cd.c and ide-disk.c to IDE core so:
> > > * PM is supported for other ATAPI devices (floppy, tape)
> > > * PM is supported even if specific driver is not loaded
> > 
> > Why do you need to have state-machine? During suspend we are running
> > single-threaded, it should be okay to just do the calls directly.
> >                                 Pavel
> 
> If we are running single-threaded I also see no reason for state-machine.
> Ben?
> 
> Pavel, I assume that changes contained in the patch are OK with you?

We aren't always running single threaded. On PPC we are definitely
not :)

Also, we need the request to go down the queue for proper
synchronisation. It's all been discussed at lenght a while ago, this is
the best way to do it. Also, wakeup can be asynchronous this way.

Ben.


