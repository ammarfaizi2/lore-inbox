Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVGLWwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVGLWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 18:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVGLWwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 18:52:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52437 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262305AbVGLWvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 18:51:39 -0400
Date: Wed, 13 Jul 2005 00:51:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: randy_dunlap <rdunlap@xenotime.net>, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update documentation
Message-ID: <20050712225126.GC2184@elf.ucw.cz>
References: <20050712090510.GG1854@elf.ucw.cz> <20050712102407.0fce8b7c.rdunlap@xenotime.net> <1121204890.13869.175.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121204890.13869.175.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > | Update suspend documentation.
> > | 
> > | Signed-off-by: Pavel Machek <pavel@suse.cz>
> > | 
> > | ---
> > | 
> > | diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> > | --- a/Documentation/power/swsusp.txt
> > | +++ b/Documentation/power/swsusp.txt
> > | @@ -318,3 +318,10 @@ As a rule of thumb use encrypted swap to
> > |  system is shut down or suspended. Additionally use the encrypted
> > |  suspend image to prevent sensitive data from being stolen after
> > |  resume.
> > | +
> > | +Q: Why we cannot suspend to a swap file?
> > 
> > Q: Why can't we suspend to a swap file?
> > or
> > Q: Why can we not suspend to a swap file?
> > 
> > | +
> > | +A: Because accessing swap file needs the filesystem mounted, and
> > | +filesystem might do something wrong (like replaying the journal)
> > | +during mount. [Probably could be solved by modifying every filesystem
> > | +to support some kind of "really read-only!" option. Patches welcome.]
> 
> This is wrong. Suspend2 has supported writing to a swap file for a long
> time (since 1.0), without requiring the filesystem to be mounted when
> resuming. We just need to store the bdev and block numbers in the image
> header.

Uh, and then you pass something like resume=/dev/hda5@BLOCKID on
command line? Okay, that could work.

Does this look fair?

Q: Why can't we suspend to a swap file?

A: Because accessing swap file needs the filesystem mounted, and
filesystem might do something wrong (like replaying the journal)
during mount.

There are few ways to get that fixed:

1) Probably could be solved by modifying every filesystem to support
some kind of "really read-only!" option. Patches welcome.

2) suspend2 gets around that by storing absolute positions in on-disk
image, with resume parameter pointing directly to suspend header.


								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
