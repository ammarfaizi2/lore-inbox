Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUISTtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUISTtN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUISTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 15:49:13 -0400
Received: from smtp-4.hut.fi ([130.233.228.94]:25015 "EHLO smtp-4.hut.fi")
	by vger.kernel.org with ESMTP id S262574AbUISTtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 15:49:08 -0400
Date: Sun, 19 Sep 2004 22:49:06 +0300
From: Tuomas Heino <iheino+lkml@cc.hut.fi>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: vfs hacking q: implementing "sectorfs" - hints?
Message-ID: <20040919194906.GB307761@kosh.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (smtp-4.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Being faced with the problem of data recovery from broken hard drives 
once again one of the ancient *ix:ish ideas crossed my mind.

Everything(*) is a file.

Thinking more of it, why couldn't harddisk sectors be files themselves?
That'd give me the power to use several userspace tools on those 
sectors without writing any unnecessarily complex glue software to 
accomplish the same goal. So I could do something like this to analyze 
the contents of the drive (mounting tmp file instead of real h/w
because actually mounting something on a piece of broken h/w sounds
too damn risky):

# dd if=/dev/sda of=try001.sda bs=512 conv=noerror 2>try001.err
# mount -t sectorfs -o loop try001.sda /mnt/mnt1
# find /mnt/mnt1 -type f -print0 | xargs -0 file > try001.contents

And thus get an approximate list of what is contained in each sector;
each virtual file would contain just the contents of one sector.
So, on to my actual questions: Assuming this idea hasn't been shot down 
before, where should I start? Would such a relatively simple "fs" fit 
in the kernel land better than in the userland?

As most hard drives nowadays have several millions of sectors, such 
a fs would need some levels of hierarchy for efficiency reasons. 
A natural idea would be using real harddisk geometry as a basis for the 
directories but recent drives tend to abstract the real geometry away 
from the casual observer :-(

Any ideas on what could actually be a useful directory structure?
If I'd actually start to write such a thing in the kernelspace, 
should I be aware of some common pitfalls? Or does this already exist 
in some other form that managed to escape my & google's imagination?

-- 
Tuomas Heino <iheino+lkml@cc.hut.fi>
*: Every rule has an exception. Except... you know :-)
