Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbTDFHMv (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTDFHMv (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:12:51 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53554 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262853AbTDFHMt (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 03:12:49 -0400
Date: Sun, 6 Apr 2003 03:24:22 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pete Zaitcev <zaitcev@redhat.com>
Subject: 2.5 uses 4 times more page tables
Message-ID: <20030406032422.A7165@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I observed a strange phenomemum. On a certain kind of sparc(32),
the amount of page tables is accounted, and 2.5.66 seems to use
about 4 times more page tables than 2.4.20.

I am talking about these kinds of numbers. On a 28MB box,
an idle 2.4 used about 57600 bytes of pagetables, which equals
to 14400 PTEs, or about enough to map 50 MB of RAM. Obviously,
there were partially filled tables, and also processes mapped
some shared memory with non-shared page tables.

On 2.5, the same system uses 273664 bytes of page tables.
If they weren't shared, and were completely used (and not
full of invalid PTEs, for instance), they would map 267MB of RAM.
Sounds kinda wasteful, for a 32MB box.

Truth to be told, I would not worry about a mere 270K of pagetables,
but the sparc port as it is uses so-called "nocache" memory,
which is preallocated on boot. OK, I know it's broken. Blame
Anton. I plan to fix it some time in the future. But currently,
my box runs out of nocache and panics. Developer's itch, you see...

So, does anyone have a handy patch or tool or something, which
prints page table statistics? Does anyone have ready numbers
on other architectures? I would appreciate other insights, too.

Thanks,
-- Pete
