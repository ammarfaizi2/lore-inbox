Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVGLXZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVGLXZC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVGLXW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:22:56 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:12945 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262248AbVGLXWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:22:01 -0400
Subject: Re: [patch] suspend: update documentation
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: randy_dunlap <rdunlap@xenotime.net>, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050712225126.GC2184@elf.ucw.cz>
References: <20050712090510.GG1854@elf.ucw.cz>
	 <20050712102407.0fce8b7c.rdunlap@xenotime.net>
	 <1121204890.13869.175.camel@localhost>  <20050712225126.GC2184@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121210623.8109.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 13 Jul 2005 09:23:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-13 at 08:51, Pavel Machek wrote:
> Hi!
> 
> > > | Update suspend documentation.
> > > | 
> > > | Signed-off-by: Pavel Machek <pavel@suse.cz>
> > > | 
> > > | ---
> > > | 
> > > | diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> > > | --- a/Documentation/power/swsusp.txt
> > > | +++ b/Documentation/power/swsusp.txt
> > > | @@ -318,3 +318,10 @@ As a rule of thumb use encrypted swap to
> > > |  system is shut down or suspended. Additionally use the encrypted
> > > |  suspend image to prevent sensitive data from being stolen after
> > > |  resume.
> > > | +
> > > | +Q: Why we cannot suspend to a swap file?
> > > 
> > > Q: Why can't we suspend to a swap file?
> > > or
> > > Q: Why can we not suspend to a swap file?
> > > 
> > > | +
> > > | +A: Because accessing swap file needs the filesystem mounted, and
> > > | +filesystem might do something wrong (like replaying the journal)
> > > | +during mount. [Probably could be solved by modifying every filesystem
> > > | +to support some kind of "really read-only!" option. Patches welcome.]
> > 
> > This is wrong. Suspend2 has supported writing to a swap file for a long
> > time (since 1.0), without requiring the filesystem to be mounted when
> > resuming. We just need to store the bdev and block numbers in the image
> > header.
> 
> Uh, and then you pass something like resume=/dev/hda5@BLOCKID on
> command line? Okay, that could work.
> 
> Does this look fair?
> 
> Q: Why can't we suspend to a swap file?
> 
> A: Because accessing swap file needs the filesystem mounted, and
> filesystem might do something wrong (like replaying the journal)
> during mount.
> 
> There are few ways to get that fixed:
> 
> 1) Probably could be solved by modifying every filesystem to support
> some kind of "really read-only!" option. Patches welcome.
> 
> 2) suspend2 gets around that by storing absolute positions in on-disk
> image, with resume parameter pointing directly to suspend header.

And a block size. (It affects the interpretation of the block number).

Apart from that, yes.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

