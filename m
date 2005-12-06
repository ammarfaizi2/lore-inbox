Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVLFBiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVLFBiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVLFBiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:38:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60907 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964902AbVLFBiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:38:17 -0500
Date: Tue, 6 Dec 2005 02:37:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051206013759.GI1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams> <200512052328.01999.rjw@sisk.pl> <1133831242.6360.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133831242.6360.15.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > First, I don't think that saving a full image of memory is generally a good
> > idea.  It is - for systems with relatively small RAM, but for systems with
> > more than, say, 512 MB that's questionable.  Of course that depends a lot
> > on the usage patterns of particular system, but having 768 MB of RAM
> > in my box I wouldn't like it to save more than a half of it during suspend,
> > for performance reasons.
> 
> I agree that whether it's a good idea varies according to individual
> tastes and usage. That's why I've made it configurable. The other point
> to remember is that suspend2's I/O performance is much better. My
> desktop here at work, for example, writes the image at 72MB/s and reads
> it back at 116MB/s. (3GHz P4 with a Maxtor 6Y120L0). Writing 1GB at
> these rates is not a problem.

Andy reported 20MB/sec on hdparm. I do not think it is possible to
write faster than that. And that seems about ok for notebooks, X32
(pretty new) has:

root@amd:~# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  108 MB in  3.01 seconds =  35.85 MB/sec

> > Second, IMHO, some things you are doing in suspend2, like image encryption,
> > or accessing ordinary files, should not be implemented in the kernel.
> 
> Image encryption is just done using cryptoapi - I just expose the
> parameters and optionally save them in the image; there's no nous in
> suspend2 regarding encryption beyond that.

Unfortunately all these "small things" add up.

> Regarding accessing ordinary files, it's really just a variation on the
> swapwriter in that we bmap the storage and then use the blocks we're
> given. There were two reasons for adding this - first removing the
> dependency on available swapspace, and secondly working towards better
> support for embedded (write the image to a file and include the file in
> place of a ramdisk image). The second reason might sound like fluff, but
> I can assure you as an embedded developer myself that embedded people
> are really interested in seeing if this technique will be a viable way
> of speeding up boot times.

Interesting use, but for embedded app, they can just reserve partition
as well. [I have seen some patches doing that.]
								Pavel
-- 
Thanks, Sharp!
