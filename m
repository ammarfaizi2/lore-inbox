Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUIUQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUIUQov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267826AbUIUQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:44:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30427 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267808AbUIUQor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:44:47 -0400
Subject: Re: Design for setting video modes, ownership of sysfs attributes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040921085669c2dcd7@mail.gmail.com>
References: <9e47339104091811431fb44254@mail.gmail.com>
	 <20040921124507.GC2383@elf.ucw.cz>
	 <9e473391040921085669c2dcd7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095781340.31269.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 16:42:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-21 at 16:56, Jon Smirl wrote:
> > "Driver decides to either do it itself in kernel, or call userspace
> > helper if that would be too complex".

It is

> The driver almost always needs to go to user space to get the file of
> mode line overrides that the user can create. But there is nothing
> stopping you from building everything in the kernel.

For random PC cards this is true. If you take something like the
voodoo1 which essentially has two fixed modes, or vesafb its obviously 
a bit different (ditto a lot of embedded devices)

You also want one mode embedded in every driver so that if the user
space fails, aliens eat your network connection, it panics while mode
switch computing or the like you can get a mode to see what went bang.
Thats probably "single console 640x480 vga timings" for the general case
and also does for boot up until userspace on disk (or initrd) has the
video initialized the way the user wants it in the end.

We also mooted caching settings when it made sense (eg when the
computation is hard and the mmio whacking trivial) to get better mode
change performance on vt flip.
 
Alan

