Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268280AbUIWFKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268280AbUIWFKv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268281AbUIWFKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:10:51 -0400
Received: from peabody.ximian.com ([130.57.169.10]:29325 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268280AbUIWFKs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:10:48 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Edgar Toernig <froese@gmx.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095915177.4101.63.camel@orca.madrabbit.org>
References: <1095652572.23128.2.camel@vertex>
	 <1095744091.2454.56.camel@localhost>
	 <20040921173404.0b8795c9.froese@gmx.de>
	 <41504C21.3090506@nortelnetworks.com>  <1095820046.22558.4.camel@vertex>
	 <1095904012.11637.81.camel@orca.madrabbit.org>
	 <1095910956.9652.2.camel@vertex>
	 <1095915177.4101.63.camel@orca.madrabbit.org>
Content-Type: text/plain
Date: Thu, 23 Sep 2004 01:10:47 -0400
Message-Id: <1095916247.2454.188.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 (1.5.94.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 21:52 -0700, Ray Lee wrote:

> 	[*] Here's one of those things that makes me think that I'm
> 	talking out my tush. The comments claim that only the filename
> 	will be returned to userspace, but later on another comment says
> 	that the size might technically fly up to PATH_MAX. Wassup?

Technically speaking, a single filename can be as large as PATH_MAX-1.
The comment is just a warning, though, to explain the dreary theoretical
side of the world.  Pragmatism demands that we just use
INOTIFY_FILENAME_MAX, which is a more reasonable 256.

> BTW:
> <pedantic>
> +	unsigned long		bitmask[MAX_INOTIFY_DEV_WATCHERS/BITS_PER_LONG];
> 
> would be more correct if written
> 
>   unsigned long bitmask[(MAX_INOTIFY_DEV_WATCHERS + BITS_PER_LONG - 1) / BITS_PER_LONG];
> 
> </pedantic>

Indeed!  Although we define MAX_INOTIFY_DEV_WATCHERS right above and it
is a power of two.

> BTW #2: 'mask' is variously declared as an unsigned long and other times
> as an int. Granted, the two base declarations seem to live in different
> structs, but I can't figure out when a mask-like thing would want to be
> signed. Please consider either changing the name or, more likely,
> changing all usages to unsigned. My single linear reading through the
> patch hasn't quite clarified the usage to me.

Probably should just be an 'unsigned int' everywhere.

But there are a few variables that have the same name in various
structures.  That confuses me to no end, but I am jumpy like that.

> P.s. Have I mentioned that I like the inotify idea a heck of a lot
> better than dnotify? Ghu save us from people who think signals are a
> wonderful way to communicate complex information.

Oh, dude, inotify is a godsend.

	Robert Love


