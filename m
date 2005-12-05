Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVLEX0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVLEX0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVLEXZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:25:45 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:18608 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964861AbVLEXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:25:31 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: ncunningham@cyclades.com
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Mon, 5 Dec 2005 23:28:01 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@ucw.cz>, Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <1133791084.3872.53.camel@laptop.cunninghams>
In-Reply-To: <1133791084.3872.53.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052328.01999.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 5 December 2005 14:58, Nigel Cunningham wrote:
> On Mon, 2005-12-05 at 22:17, Pavel Machek wrote:
> > > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> > > GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> > > seconds or less, and writing out the swap image took less than 5
> > > seconds, so within 15 seconds of running my suspend script power was
> > > off.
> > 
> > So suspend took 15 second, and boot another 5 to read the image + 20
> > first time desktops are switched. ... ~40 second total.
> 
> Plus what is mentioned in the next paragraph.

Indeed.  Yet, the point has been made and backed up with some numbers:
There's at least one swsusp user (Andy) who would apparently _prefer_ if more
memory were freed during suspend.  The reason is the amount of
RAM in the Andy's box.

}-- snip --{ 
> > * and of course you can apply one very big patch and do all of the
> > above :-).
> 
> Could you stop being nasty, please?
> 
> Yes, suspend2 is bigger, but let's keep things in perspective. Including
> comments and so on, it's about 12000 lines. fs/ext3 contains 15000 lines
> and fs/xfs is just below 115000 lines. For those 12000 lines you get a
> clean internal api, support for compression, encryption, swap
> partitions, swap files and ordinary files. You get asynchronous I/O and
> read ahead where I/O needs to be synchronous. You get saving a full
> image of memory and support for a nice user interface (mostly in
> userspace). It's not 12000 lines of bloat, but real functionality that
> people are using right now.

Let me say I think you're doing a great job with maintaining suspend2.
It looks like a really difficult thing to do, particularly in recent times.
Moreover, you have solved many very difficult problems and I respect
that very much.  Still, I don't agree with some points you are making.

First, I don't think that saving a full image of memory is generally a good
idea.  It is - for systems with relatively small RAM, but for systems with
more than, say, 512 MB that's questionable.  Of course that depends a lot
on the usage patterns of particular system, but having 768 MB of RAM
in my box I wouldn't like it to save more than a half of it during suspend,
for performance reasons.

Second, IMHO, some things you are doing in suspend2, like image encryption,
or accessing ordinary files, should not be implemented in the kernel.

That said, I think at least some of the functionalities you have already
implemented in suspend2 are needed and generally can be shared between
your code and swsusp.  I've been going to look for such possibilities for some
time, but unfortunately, in its downloadable form, your patch is
quite difficult to follow, so if you have a version that is organized in a more
functionality-oriented way, could you please point me to it?

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

