Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267806AbUHPPsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267806AbUHPPsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUHPPpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:45:18 -0400
Received: from web14925.mail.yahoo.com ([216.136.225.11]:5822 "HELO
	web14925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267809AbUHPPmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:42:45 -0400
Message-ID: <20040816154240.54747.qmail@web14925.mail.yahoo.com>
Date: Mon, 16 Aug 2004 08:42:40 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: your mail
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graphics drivers in the kernel are broken. The kernel was never
designed to have two device drivers trying to control the same piece of
hardware. 
I have posted a long list of 25 points that we are working towards to
unify things. http://lkml.org/lkml/2004/8/2/111 The PCI ROM patch that
has been posted recently addresses the first one.

In the meanwhile we have to transition somehow between what we have and
where we are going. Since fbdev has taken the path to pretend that DRM
doesn't exist DRM has to go through a lot of trouble to work when fbdev
is in the system. DRM also has to work when fbdev is not in the system.

DRM is being reworked into a first class driver with full support for
2.6 and hotplug. Part of being a first class driver means that DRM has
to register itself with the kernel like a real driver and claim all of
it's resources. I'm also fixing the driver to use 2.6 module parameters
and to support dynamic assignment of minors. Sysfs support is in the
patch being discussed.

But DRM still has to live with existing fbdev drivers. The same DRM
code is used in 2.4 and 2.6 so existing fbdev drivers are not going
away anytime soon. When DRM detects a fbdev it will revert back into
stealth mode where is attaches itself to the hardware without telling
the kernel that it is doing so. DRM can not use stealth mode when
running without fbdev present since it will mess up hotplug by not
marking the resources in use.

I don't believe the ordering between fbdev and DRM is an issue. If you
are using fbdev you likely have it compiled in. In that case fbdev
always loads first and DRM second. In the non-ppc world, most of us
have x86 boxes which don't use fbdev. In those machines DRM needs to be
a first class driver. In the real world I don't know anyone other than
a developer who would load DRM first and then fbdev. If this is a
problem you will need to fixed fbdev to fall back into stealth mode
like DRM does.

I would like to encourage you to work towards the points on the above
referenced list. It has been widely distributed and commented on. It
has been posted to lkml, dri-dev, fb-dev and xorg lists and discussed
at OLS. 

Sorry, but I can't add an In-Reply-To header in the middle of thread on
yahoo. cc me on a reply to the main thread so that I will pick up the header.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
