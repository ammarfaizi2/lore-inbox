Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTFGBhB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 21:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbTFGBhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 21:37:01 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:36550 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262464AbTFGBg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 21:36:59 -0400
Date: Fri, 06 Jun 2003 21:43:25 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: RE: /proc/bus/pci
In-reply-to: <Pine.LNX.4.44.0306061730380.31112-100000@home.transmeta.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, davem@redhat.com,
       bcollins@debian.org, wli@holomorphy.com, tom_gall@vnet.ibm.com,
       anton@samba.org
Message-id: <1054950205.796.49.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0306061730380.31112-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out I picked up "hose" from the PowerPC code.
I always thought of it as something that sprays data.

To be really clear, "superbus" is descriptive.
While "bridge" is no good, "hostbridge" works.

Anyway, how about some substance?

I suppose sysfs can just change, since there wasn't
a sysfs filesystem in the 2.4.xx kernels.

Fixing up /proc/bus/pci isn't terribly bad,
assuming the PCI structs could hold per-bar
proc filesystem entries. I hope there isn't
an objection to that.

For mmap, I'm thinking this:

#define MAP_MMIO (MAP_ARCH_FOO | MAP_ARCH_BAR)

That is, MAP_MMIO is defined in terms of
arch-specific flags that are appropriate for
typical memory-mapped IO. The old ioctl()
takes priority.

Another way to do this is via filename, which
is kind of ugly but great for non-mmap usage.


