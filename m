Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVK0Vsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVK0Vsm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVK0Vsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:48:41 -0500
Received: from hera.cwi.nl ([192.16.191.8]:32974 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751163AbVK0Vsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:48:41 -0500
Date: Sun, 27 Nov 2005 22:48:39 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200511272148.jARLmdn08633@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: user mounting
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Many distributions are willing to let a user mount her own
floppy or CDROM or memory stick, where it is not intended
that a user can crash the system or subvert security.

However, at present an fstab line with "auto" for filesystem type,
allows the user to come with her own maliciously constructed
filesystem, and crash the system - there are many filesystem
types, and the more obscure ones among them are full of bugs.

Less obscure filesystem types still allow an easy denial of service -
for example, if the kernel does a printk() for every filesystem error,
one can keep syslog busy for hours or days, where very little else
happens.

The ext2 filesystem allows one to specify what happens upon error,
for example "panic on error". Now mounting a corrupt ext2 filesystem image
with this bit set causes the kernel to panic voluntarily.

I mentioned such things some time ago to a few people, but they
did not seem impressed.

Still, I think we should try to design a better behaviour.

Part of my proposal for a solution lives in kernel space.
Introduce a mount flag "user mounted". When it is set,
the kernel will not do a printk() for this filesystem,
and certainly will not panic.

On the user space side of things, distributions using "auto" today
might consider changing that into explicit comma-separated lists
of alternatives, so that adding new untested filesystems to the kernel
does not increase the risk of running that kernel.

Andries
