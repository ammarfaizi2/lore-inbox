Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUEBNZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUEBNZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 09:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUEBNZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 09:25:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:4275 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263062AbUEBNZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 09:25:24 -0400
X-Authenticated: #20450766
Date: Sun, 2 May 2004 15:24:40 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Filesystem with multiple mount-points
Message-ID: <Pine.LNX.4.44.0405021508210.834-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Disclaimer: I am not a filesystem expert, so, what's below might be
absolute nonsense.

There are systems, where it is desirable to make some partitions,
possibly, including root, read-only, and some other, like, e.g., /var,
/home, /lib/modules read-writable. Those writable filesystems may be quite
small, so, putting them on separate partitions creates too much overhead
for filesystem metadata, journals... Making those directories soft-links
into one writable partition would work, but is not too nice.

So, how about adding a multiple mount-point option to some filesystem?
They would share metadata, journals, would be represented by several
directory-trees, and be mountable with, e.g.

mount -otree1 /dev/hda1 /var

or

mount /dev/hda1:1 /var

which, however, would be incompatible with older versions. /proc/mounts
would show something like

/dev/hda1:1 /var ...

df might just show tree1 - to maintain backwards compatibility. Later
mount and df could be tought to support this option natively.

Makes any sense at all?

Thanks
Guennadi
---
Guennadi Liakhovetski


