Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267743AbUG3QyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267743AbUG3QyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 12:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267741AbUG3QyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 12:54:18 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:22679 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267744AbUG3Qxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 12:53:40 -0400
Message-ID: <20040730165339.76945.qmail@web14929.mail.yahoo.com>
Date: Fri, 30 Jul 2004 09:53:39 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Exposing ROM's though sysfs
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We talked at OLS about exposing adapter ROMs via sysfs. I have some
time to work on this but I'm not sure about the right places to hook
into the kernel.

The first problem is recording the boot video device. This is needed
for laptops that compress their video and system ROMs together into a
single ROM. When sysfs exposes the ROM for these adapters it needs to
know the boot video device so that it can return the ROM image at
C000:0 instead of trying to find an actual ROM. What is the right
kernel structure for recording the boot video device? Where should this
code live? It is probably x86 specific but have non-x86 laptops done
the same trick?

What about ISA support. Should we make an attempt to return ROM
contents from ISA cards?

Note that not just video cards can have ROMs. Disk adapters commonly
have them too. We probably want to expose these ROMs too.

Do we want to expose the system ROM via sysfs? Where should it appear?

Some Radeon cards have a bug where they forgot to clear a latch which
makes the ROMs visible. Where should a fix for things like this go? I
can put it in the radeon driver but if you try to read the ROM before
the driver is loaded, the ROM won't be visible.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
