Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270019AbUIDArc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270019AbUIDArc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 20:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUIDAqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 20:46:32 -0400
Received: from web14921.mail.yahoo.com ([216.136.225.5]:28859 "HELO
	web14921.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270011AbUIDAoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 20:44:24 -0400
Message-ID: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
Date: Fri, 3 Sep 2004 17:44:24 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: New proposed DRM interface design
To: Dave Airlie <airlied@linux.ie>, dri-devel@lists.sf.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0409040107190.18417@skynet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I might move stuff like AGP support into the core. The core is the most
OS specific piece of code. So anything that is very specific to the
kernel API should be in it.

I would split like this:
drm_core - OS specific code, all global things
drm_library - shared code, not OS specific
driver

Then drm_core would always be bundled with the OS.

Is there any real advantage to spliting core/library and creating three
interface compatibily problems?

Stuff like this should probably be an inline...
#if LINUX_VERSION_CODE <= 0x020402
                        up( &current->mm->mmap_sem );
#else
                        up_write( &current->mm->mmap_sem );
#endif

What about the VM page fault routines with 2.4 vs 2.6 differences?
How about HAS_WORKQUEUE?


=====
Jon Smirl
jonsmirl@yahoo.com


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush
