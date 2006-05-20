Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWETWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWETWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWETWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 18:23:27 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:63386 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S1751331AbWETWX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 18:23:27 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200605202218.k4KMIIUX007492@wildsau.enemy.org>
Subject: Re: pktcdvd major contradicts <linux/Documentation/devices.txt>
In-Reply-To: <20060520213506.GC7930@mipter.zuzino.mipt.ru>
To: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sun, 21 May 2006 00:18:18 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Fixed is in -git since Mon May 15 09:44:40 2006 -0700.

aha. I'm only working with 2.6.16.16.

anyway. As I just started with the pkt-writing module, I noticed
another strange behaviour (at least, it seems strange to me, but YMMV),
and I wonder if this is has already been fixed in some -git or -mm
prepatch or snapshot or subsubsub-release-canditate ...

<linux/Documentation/cdrom/packet-writing.txt> says:

- Setup your writer
        # pktsetup dev_name /dev/hdc

Therefore, I do "pktsetup node0 /dev/hdc", which gives:

# pktsetup node0 /dev/hdc
ctl open: Not a directory

strace shows that pktsetup is trying to open /dev/pktcdvd/control,
which it cannot, since /dev/pktcdvd is a char device obviously
created upon "modprobe pktcdvd". The char device has major 10 minor
63, which seems to be missing in devices.txt.

Once I remove the char-device, pktsetup will work and create
/dev/pktcdvd/control and /dev/pktcdvd/node0. Now I try to figure
out how the rest of "packet-writing.txt" works ...

kind regards,
h.rosmanith

