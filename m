Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTLaWUe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265266AbTLaWUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:20:34 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:45759 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265264AbTLaWUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:20:33 -0500
Subject: Re: udev and devfs - The final word
From: Rob Love <rml@ximian.com>
To: Nathan Conrad <lk@bungled.net>
Cc: Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <20031231220107.GC11032@bungled.net>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local>
	 <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur>
	 <20031231220107.GC11032@bungled.net>
Content-Type: text/plain
Message-Id: <1072909218.11003.24.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 31 Dec 2003 17:20:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-31 at 17:01, Nathan Conrad wrote:

> One thing that I'm confused about with respect to device files is how
> kernel arguments are supposed to work. Now, we _seem_ to have a
> mish-mash of different ways to tell the kernel which device to open as
> a console, which device to use as a suspend device, etc.... Now, all
> of the device names are being migrated to userland. How is the kernel
> supposed to determine which device to use when it is told use
> /dev/hda3 or /dev/ide/host0/something/part3 as the suspend partition?
> The kernel no longer knows to which device this string this device is
> connected.

Uh, Unix systems (Linux included) do not use the filename of the device
node at all.  Those are just names for you, the user.

The kernel uses the device number to understand what device user-space
is trying to access.  The kernel associates the device with a device
number.  Normally that number is static, and known a priori, so we just
create a huge /dev directory with all possible devices and their
assigned numbers (you can see these numbers with ls -la).

But if the kernel _tells_ user-space what the device number is, for each
device as it is created, we do not need a static /dev directory.  We can
assemble the directory on the fly and device numbers really no longer
matter.  This is what udev does.

	Rob Love


