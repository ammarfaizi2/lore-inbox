Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVFBHbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVFBHbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 03:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVFBHbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 03:31:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52427 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261597AbVFBHbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 03:31:44 -0400
Date: Thu, 2 Jun 2005 09:31:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Freezer Patches.
Message-ID: <20050602073119.GC1841@elf.ucw.cz>
References: <1117629212.10328.26.camel@localhost> <20050601130205.GA1940@openzaurus.ucw.cz> <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz> <1117665934.19020.94.camel@gaston> <20050601230235.GF11163@elf.ucw.cz> <1117676753.10888.105.camel@localhost> <20050602071431.GA1841@elf.ucw.cz> <1117697187.10888.138.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117697187.10888.138.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If sys_sync() is not working, *fix sys_sync()*. [BTW I see that
> > problem before and I think it is being worked on.] I'm *not* going to
> > work around it in refrigerator.
> 
> I'm not saying sys_sync is broken. I _am_ saying that if you have
> processes submitting I/O while you're trying to sync, syncing will take
> longer and you may well still end up with dirty buffers at the end. On
> top of this, you may think freezing has failed because processes don't
> enter the refrigerator within your timelimit (assuming you have
> one).

Then simple launch sys_sync(), let it finish, *then* do
refrigeration. That way sys_sync() does not count to the timelimit.

Now, sys_sync() takes too long on some setups. That needs to be fixed,
anyway; users don't like to wait for 15 minutes after typing
"sync". Do not work around it in refrigerator.
								Pavel
