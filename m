Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVCQPSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVCQPSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVCQPSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:18:34 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:54185 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262156AbVCQPSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:18:14 -0500
Date: Thu, 17 Mar 2005 10:18:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.11.2
In-reply-to: <20050309083953.GB20461@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503171018.12682.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050309083923.GA20461@kroah.com>
 <20050309083953.GB20461@kroah.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 March 2005 03:39, Greg KH wrote:
>diff -Nru a/Makefile b/Makefile
>--- a/Makefile 2005-03-09 00:13:29 -08:00
>+++ b/Makefile 2005-03-09 00:13:29 -08:00
>@@ -1,7 +1,7 @@
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 11
>-EXTRAVERSION = .1
>+EXTRAVERSION = .2
> NAME=Woozy Numbat
>
> # *DOCUMENTATION*
>diff -Nru a/fs/eventpoll.c b/fs/eventpoll.c
>--- a/fs/eventpoll.c 2005-03-09 00:13:29 -08:00
>+++ b/fs/eventpoll.c 2005-03-09 00:13:29 -08:00
>@@ -619,6 +619,7 @@
>  return error;
> }
>
>+#define MAX_EVENTS (INT_MAX / sizeof(struct epoll_event))
>
> /*
>  * Implement the event wait interface for the eventpoll file. It is
> the kernel @@ -635,7 +636,7 @@
>        current, epfd, events, maxevents, timeout));
>
>  /* The maximum number of event must be greater than zero */
>- if (maxevents <= 0)
>+ if (maxevents <= 0 || maxevents > MAX_EVENTS)
>   return -EINVAL;
>
>  /* Verify that the area passed by the user is writeable */
>-

Greg, I have now pretty well confirmed that this patch is what caused 
the tvtime audio breakage I was observing here.  Rebooting to 
2.6.11.1, everything works, rebooting to 2.6.11.2, and its broken.  
ditto for .3 and .4, so last night I built a .5 (had to patch the 
Makefiles EXTRAVERSION & rebuild before it would boot after the 
build) but I built it *without* this patch, and everything works.

This patch looks good to me except for the added MAX_EVENTS define.  
Did anyone actually put in a printk at that point and see what 
MAX_EVENTS actually was by that define?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
