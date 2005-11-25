Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbVKYBso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbVKYBso (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 20:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbVKYBsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 20:48:43 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28056 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1161085AbVKYBsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 20:48:43 -0500
Date: Fri, 25 Nov 2005 02:48:41 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
In-Reply-To: <200511241145.24037.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511250022330.1609@scrub.home>
References: <200511170629.42389.rob@landley.net> <200511211006.48289.rob@landley.net>
 <Pine.LNX.4.61.0511241212030.1609@scrub.home> <200511241145.24037.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 24 Nov 2005, Rob Landley wrote:

> > On Mon, 21 Nov 2005, Rob Landley wrote:
> > > Add "make miniconfig", plus documentation, plus the script that creates a
> > > minimal mini.config from a normal .config file.
> >
> > The difference between miniconfig and allnoconfig is IMO too small to be
> > really worth it right now.
> 
> I disagree, fairly strongly.  The technical difference may be small, but the 
> conceptual difference is huge.

I don't really disagree, a proper implementation of the concept would also 
be technically quite different. Hacking it into conf.c is the wrong to go 
(or to even start).

> > which is only read by kconfig.
> 
> So it would be different from the format of the busybox .config file, the 
> uClibc .config file, or anybody else out there who's adopted the kernel's 
> format over the past decade-plus?

Did I say it would go away? No.
It actually makes quite some sense to separate the .config used by kbuild 
from the config used by kconfig.
.config isn't always correctly reread after a manual edit. The syntax 
rules needed by kbuild are more strict than needed for kconfig. The "is 
not set" syntax is not exactly user friendly and all the derived symbols 
aren't needed by kconfig.
My current plan is to somewhere create a copy of .config replacing 
the include/config/MARKER mechanism, which then is also used by kbuild.
In a second step it then would be simple to allow an alternative name 
or even formats for the primary config file.

> However, you seem to be forgetting that .config is read by the kernel build 
> infrastructure.  The tools are generating what _used_ to be a human editable 
> file. 

Oh, really?

> So how would you make use of this new minimized version, then?  If somebody 
> file attached one in a linux kernel message and a developer wanted to debug 
> their issue?

$ cp ... linux/config
$ make

> I don't personally _care_ about the other config targets.

Well, that's the problem, I do care about them. I want to keep it working 
without obfuscating it with thousands little features, so we have to 
figure out how to integrate it properly into the big picture.

bye, Roman
