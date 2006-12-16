Return-Path: <linux-kernel-owner+w=401wt.eu-S1161109AbWLPQQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWLPQQ3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 11:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWLPQQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 11:16:29 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:36658 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161109AbWLPQQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 11:16:29 -0500
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 11:16:29 EST
Date: Sat, 16 Dec 2006 16:50:44 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Recent mm changes leading to filesystem corruption?
Message-ID: <20061216155044.GA14681@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debian recently applied a number of mm changes that went into 2.6.19
to their 2.6.18 kernel for LSB 3.1 compliance (msync() had problems
before).  Since then, some filesystem corruption has been observed
which can be traced back to these mm changes.  Is anyone aware of
problems with these patches?

The patches that were applied are:

   - mm: tracking shared dirty pages
   - mm: balance dirty pages
   - mm: optimize the new mprotect() code a bit
   - mm: small cleanup of install_page()
   - mm: fixup do_wp_page()
   - mm: msync() cleanup

With these applied to 2.6.18, the Debian installer on a slow ARM
system fails because a program segfaults due to filesystem corruption:
http://bugs.debian.org/401980  This problem also occurs if you only
apply the "mm: tracking shared dirty pages" patch to 2.6.18 from the
series of 5 patches listed above.

Another problem has been reported related to libtorrent: according to
http://bugs.debian.org/402707 someone also saw this with non-Debian
2.6.19 but obviously it's hard to say whether the bugs are really
related.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=394392;msg=24 shows
some dmesg messages but again it's not 100% clear it's the same bug.

Has anyone else seen problems or is aware of a fix to the patches
listed above that I'm unaware of?  It's possible the problem only
shows up on slow systems. (The corruption is reproducible on a slow
NSLU2 ARM system with 32 MB ram, but it doesn't happen on a faster ARM
box with more RAM.)
-- 
Martin Michlmayr
http://www.cyrius.com/
