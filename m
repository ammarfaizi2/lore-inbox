Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266532AbUGKJmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266532AbUGKJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUGKJmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:42:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31179 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266532AbUGKJmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:42:03 -0400
Date: Sun, 11 Jul 2004 05:39:23 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: davidm@hpl.hp.com
cc: suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Jul 2004, Ingo Molnar wrote:

> ok, agreed. I'll check that it still does the right thing on x86.

it doesnt seem to do the right thing for !PT_GNU_STACK applications on 
x86:

$ uname -a
Linux saturn 2.6.7-mm7 #13 SMP Sun Jul 11 10:20:45 CEST 2004 i686 athlon 
i386 GNU/Linux

$ ./cat-verylowaddress /proc/self/maps
00048000-0004c000 r-xp 00000000 03:41 1046754    /home/mingo/noexec/cat-verylowaddr
0004c000-0004d000 rw-p 00003000 03:41 1046754    /home/mingo/noexec/cat-verylowaddr
0004d000-0006e000 rw-p 0004d000 00:00 0
00aca000-00adf000 r-xp 00000000 03:41 3434109    /lib/ld-2.3.3.so
00adf000-00ae0000 r--p 00014000 03:41 3434109    /lib/ld-2.3.3.so
00ae0000-00ae1000 rw-p 00015000 03:41 3434109    /lib/ld-2.3.3.so
00ae3000-00bf8000 r-xp 00000000 03:41 3434110    /lib/tls/libc-2.3.3.so
00bf8000-00bfa000 r--p 00115000 03:41 3434110    /lib/tls/libc-2.3.3.so
00bfa000-00bfc000 rw-p 00117000 03:41 3434110    /lib/tls/libc-2.3.3.so
00bfc000-00bfe000 rw-p 00bfc000 00:00 0
b7db5000-b7db6000 r--p 00cfd000 03:41 3735973    /usr/lib/locale/locale-archive
b7db6000-b7de3000 r--p 00ccc000 03:41 3735973    /usr/lib/locale/locale-archive
b7de3000-b7de9000 r--p 00cc3000 03:41 3735973    /usr/lib/locale/locale-archive
b7de9000-b7fe9000 r--p 00000000 03:41 3735973    /usr/lib/locale/locale-archive
b7fe9000-b7fea000 rw-p b7fe9000 00:00 0
bfffe000-c0000000 rw-p bfffe000 00:00 0
ffffe000-fffff000 ---p 00000000 00:00 0

i'll come up with a patch that solves the ia64 problem and keeps x86
working too (unless you beat me to it).

	Ingo
