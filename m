Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275274AbTHGKD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275275AbTHGKD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:03:27 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:60552 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S275274AbTHGKDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:03:25 -0400
Date: Thu, 7 Aug 2003 12:03:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client notification mecanism & PM
Message-ID: <20030807100309.GB166@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org> <1060249101.1077.67.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060249101.1077.67.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > James, if you are ok, can you get that upstream to Linus asap so
> > > I can start pushing the driver bits for radeon & aty128 ?
> > 
> > Working on it. I'm thinking about also how it effects userland and how 
> > userland affects the console if present. Basically the logic will go 
> > 
> > pci suspend ->  framebuffer driver supend function -> call each client
> > 
> > Just give me a few days to piece it together.
> 
> Right now, we don't have a proper userland notification. So far, the
> main affected thing is XFree, but this is ok as it will have received
> a suspend request via /dev/apm_bios (which we emulate on PowerMacs),
> and so won't touch the framebuffer until resumed.
> 
> There isn't much we can do against a userland client tapping the
> framebuffer that it mmap'ed previously. I don't know how feasible it
> would be to sort of "hack" this process mapping on the fly (would
> involve some nasty SMP synchronisation issues) so that the userland
> process is just put to sleep on fb access while the fb is suspended
> (or get a SEGV). We probably want to extend the notification mecanism
> to userland in some way, but this isn't something i cover in this
> patch.

I believe solution to this is simple: always switch to kernel-owned
console during suspend. (swsusp does it, there's patch for S3 to do
the same). That way, Xfree (or qtopia or whoever) should clean up
after themselves and leave the console to the kernel. (See
kernel/power/console.c)
							Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
