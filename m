Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269985AbUIDBUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269985AbUIDBUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 21:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270005AbUIDBUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 21:20:15 -0400
Received: from web14927.mail.yahoo.com ([216.136.225.85]:13906 "HELO
	web14927.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269985AbUIDBUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 21:20:08 -0400
Message-ID: <20040904012008.81382.qmail@web14927.mail.yahoo.com>
Date: Fri, 3 Sep 2004 18:20:08 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: New proposed DRM interface design
To: Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409040145240.25475@skynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Dave Airlie <airlied@linux.ie> wrote:
> Yes we only have one binary interface, between the core and module,
> this interface is minimal, so AGP won't go in it... *ALL* the core
> does is deal with the addition/removal of modules, the idea being 
> that the interface is very minor and new features won't change it...

If you're Nvidia you ship the library source (since it is GPL) and a
binary driver. You compile the library on your kernel so that kernel
API IFDEF's get executed and then link to the binary driver. This model
won't work with IFDEF'd inline functions that are used in a binary
driver. They will have to be real functions in the library.

Things like this from the i830 driver will need to be library functions
#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,2)
#define down_write down
#define up_write up
#endif

With the right set of library functions it should be possible to write
a video driver that is OS independent.

How big is the library that is going to get duplicated? Note that it
only gets duplicated for different cards not multiple instances of the
same card family. 

Are you going to hide the exported symbols so that we don't need the
DRM() macros?

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
