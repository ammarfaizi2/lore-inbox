Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbTGJLft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269219AbTGJLft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:35:49 -0400
Received: from ol.freeshell.org ([192.94.73.20]:11976 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S269218AbTGJLfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:35:48 -0400
Date: Thu, 10 Jul 2003 11:50:01 +0000
From: Tavis Ormandy <taviso@gentoo.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, alpha@gentoo.org
Subject: Re: [PATCH] 2.4.21: Optionally Configure UAC Policy via Sysctl (Alpha)
Message-ID: <20030710115001.GA997@sdf.lonestar.org>
References: <20030710081513.GA7671@sdf.lonestar.org> <20030710153217.A21944@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030710153217.A21944@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 03:32:17PM +0400, Ivan Kokshaysky wrote:
> On Thu, Jul 10, 2003 at 08:15:13AM +0000, Tavis Ormandy wrote:
> > +  To disable the warning messages at runtime, you might use
> > +
> > +  echo 1 > /proc/sys/kernel/uac/noprint
> 
> It's really bad idea. Unaligned traps are *bugs*, so we don't
> want to hide them. Especially system-wide.
> 

It's true that that they are bugs, but on such widespread errors that
are transparently fixed by the kernel, do we really need to be reminded
every time such an event occurs?

$ grep unaligned /proc/cpuinfo 
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 4400 (pc=30281c8c434,va=30281db8f62)

This machine has been up just a few hours, and already a has fixed a lot
of these errors. I really dont need the signal:noise ratio of my logs
diluted by this, unless im searching for bugs, which is why a sysctl
makes sense, imo.

> You can do all the same per process, using existing OSF-compatible
> UAC control.
> 

True, and thats _really_ useful for turning the messages _on_ for the
application your working with/debugging/etc, system-wide messages just
dont make sense to me.

Also, it is optional, so only users who foresee wanting to disable the
messages will do so.

-- 
-------------------------------------
taviso@sdf.lonestar.org | finger me for my gpg key.
-------------------------------------------------------
