Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTJXDrE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 23:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTJXDrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 23:47:04 -0400
Received: from web14915.mail.yahoo.com ([216.136.225.228]:49281 "HELO
	web14915.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261959AbTJXDrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 23:47:02 -0400
Message-ID: <20031024034701.16514.qmail@web14915.mail.yahoo.com>
Date: Thu, 23 Oct 2003 20:47:01 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Multiple drivers for same hardware:, was: DRM and pci_driver conversion
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Eric Anholt <eta@lclark.edu>,
       kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <3F987E18.9080606@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What about the fundamental question? We have several pairs of device drivers
that want to control the same hardware. One example would be radeon DRM and
radeon Framebuffer. How should these drivers coordinate probing and claiming
resources?

What should be the policy for multiple drivers?
1) try new probe first and fall back to old scheme. First driver that loads
gets the new probe, second gets the old. First driver reserves resources.
2) Require a mini driver that handles probing. Then both drivers attach to the
mini driver.
3) Declare it illegal and make the drivers merge.
4) Declare it illegal and only allow first one loaded to run.

Right now radeonfb handles probing and resource reservation. DRM works in
stealth mode. DRM uses all of the resources and never tells the kernel, that's
how it avoids conflicting with framebuffer.

DRM and framebuffer trade off control at VT switch. 2D state is save and
restored. There is an assumption that framebuffer won't mess with the 3D state.
 I'm not sure that suspend/resume are coordinated in any way.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
