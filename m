Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUBSSwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUBSSvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:51:51 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:4870 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S267481AbUBSSv3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:51:29 -0500
Date: Thu, 19 Feb 2004 20:04:36 +0100
To: Paulo Marques <pmarques@grupopie.com>
Cc: tridge@samba.org, "Theodore Ts'o" <tytso@mit.edu>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
Message-ID: <20040219190436.GA32480@hh.idb.hist.no>
References: <1qIwr-5GB-11@gated-at.bofh.it> <1qIwr-5GB-9@gated-at.bofh.it> <1qIQ1-5WR-27@gated-at.bofh.it> <1qIZt-6b9-11@gated-at.bofh.it> <1qJsF-6Be-45@gated-at.bofh.it> <E1Atbi7-0004tf-O7@localhost> <16436.2817.900018.285167@samba.org> <20040219024426.GA3901@thunk.org> <16436.11148.231014.822067@samba.org> <4034A7F4.6000402@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4034A7F4.6000402@grupopie.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 12:11:32PM +0000, Paulo Marques wrote:
> tridge@samba.org wrote:
> 
> >Currently dnotify doesn't give you the filename that is being
> >added/deleted/renamed. It just tells you that something has happened,
> >but not enough to actually maintain a name cache in user space.
> 
> This might be a crazy / stupid idea, so flame at will :)
> 
> Wouldn't it be possible to do a samba "super-server" mode, in which samba 
> would assume that it controlled the directories it is exporting?
> 
> In this mode a "corporate" Samba server, serving Windows clients, could 
> improve performance by assuming that its cache was always up-to-date.
> 
> If if we wanted to access the directory locally we could always mount 
> locally using samba, and access the files anyway, albeit a lot slower and 
> without linux permissions, etc.
> 
You don't really need to go to such extremes.  Samba can use dnotify,
and run with caching and great performance as long as nobody touch
the files in other ways.  There is no need to _enforce_ it though,
samba can cope by invalidating the cache on those rare occations
the files are accessed in other ways. It won't happen often, because:

1. Linux/nfs people have no business in a directory full of
   windows .dll's and .exe's
2. On a corporate server you simply tell people to stay out.
   nfs may export another set of homedirs for the unix people.

> What we would gain was the ability to say "I want to give priority to my 
> samba server" (and set it to "super-server" mode) or "my priority is to the 
> linux native filesystem, and just want to share my files with windows users 
> anyway" (and keep using samba as always).
>
Thanks to dnotify even the "linux priority" setup will be able to benefit
from a cache.  Particularly if we can get a dnotify that doesn't trip
when samba is the one making changes.  


Helge Hafting
