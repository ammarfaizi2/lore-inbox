Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136329AbRDWBzh>; Sun, 22 Apr 2001 21:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136330AbRDWBz2>; Sun, 22 Apr 2001 21:55:28 -0400
Received: from leng.mclure.org ([64.81.48.142]:62215 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S136329AbRDWBzQ>; Sun, 22 Apr 2001 21:55:16 -0400
Date: Sun, 22 Apr 2001 18:55:14 -0700
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Subject: Kernel hang on multi-threaded X process crash
Message-ID: <20010422185514.A981@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, this is what I get for being on the cutting edge... :-(

I'm now running into problems where the machine will totally hang (no
network, no SysRq, no nothin') regularly. The triggers seem to be running
aviplay or mozilla.

Symptoms will be that I am running aviplay or mozilla, and the machine will
suddenly hang and need to be hard-reset. I can trigger it 100% by telling
aviplay to zoom 2x.

I finally managed to reproduce it while I was on a console (I telneted in
from another machine, and ran aviplay on the X display that was on console
7 while the machine was displaying console 1) - the only message before the
hang was "Trying to vfree() nonexistent vm area (d0992000)" - no Oops was
shown.

Whenever this happens, the e2fsck step at reboot shows a
"Entry 'core.XXXX' in <dir> (XXXXXX) had deleted/unused inode XXXXXX.
CLEARED" message. The core file is always in whatever directory I was
running the process that seems to cause the crash. It seems like either the
core is a symptom of the underlying problem, or the process coredumping is
causing the hang.

The machine is an Athlon Thunderbird 900MHz with 256M of PC133 DRAM on an
MSI K7T Turbo R motherboard. I am running 2.4.3-ac12 currently, 2.4.3-ac11
and 2.4.3-ac5 hung the same way at least once each before I started
tracking this down. I am running Red Hat 7.1, and am using the
XFree86-4.0.3 RPMs that come with RH71 with the CVS DRI trunk installed
over it. The kernel was built with kgcc, a gcc-2.96 built kernel has the
same problem.

Any ideas?

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

