Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTJUFCu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 01:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbTJUFCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 01:02:50 -0400
Received: from smtp1.pacifier.net ([64.255.237.171]:11207 "EHLO
	smtp1.pacifier.net") by vger.kernel.org with ESMTP id S262953AbTJUFCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 01:02:48 -0400
Date: Mon, 20 Oct 2003 22:02:44 -0700
From: "B. D. Elliott" <bde@nwlink.com>
To: linux-kernel@vger.kernel.org
Subject: Slram doesn't work
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Message-Id: <20031021050245.9083A6F661@smtp1.pacifier.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an old (x86) machine that does not cache the upper half of memory.
Under 2.4.x, I used "slram=slr0,64M,+64M" to reserve that half, and then
used it as a swap device.

This fails on 2.6.0-test8, with an "ioremap failed" message during booting.
The boot messages plus capturing the page flags in ioremap() shows the
following:

...
slram: devname = slr0
slram: devstart = 64M
slram: devlength = +64M
slram: devname=slr0, devstart=0x4000000, devlength=0x4000000
.. ioremap failed: line 145 (approximately)
.. phys_addr: 04000000 t_addr: c4000000 t_end: c7ffffff page0: c10a0000 page: c10a0000
.. page-1 flags: 01000000
.. page   flags: 01000080
.. page+1 flags: 01000080
.. page+2 flags: 01000080
.. page+3 flags: 01000080
.. PageReserved(page): 0
slram: ioremap failed
...

The failure occurs where "PageReserved" is checked.  "page0" is the address
of the first page entry for the region, which is also where it failed.
("PageReserved" is bit 11.)  Apparently, "PageReserved" is no longer set
when slram initialization occurs.

-- 
B. D. Elliott   bde@nwlink.com
