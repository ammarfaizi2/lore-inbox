Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUCRXWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUCRXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:21:42 -0500
Received: from waste.org ([209.173.204.2]:46479 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263306AbUCRXKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:10:15 -0500
Date: Thu, 18 Mar 2004 17:10:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: [CFT] inflate.c rework arch testing needed
Message-ID: <20040318231006.GK11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've reworked the mess that is lib/inflate.c, including:

- proper formatting
- killing a ton of legacy code
- cleaning up IO and CRC handling
- eliminating all the global variables
- using __init for the core kernel
- proper linking rather than the #include "../lib/inflate.c" hack
- lots of minor cleanups along the way

This drops a ton of support code from all the users of this code as
well:

 arch/arm/boot/compressed/Makefile    |    5
 arch/arm/boot/compressed/misc.c      |  244 --
 arch/i386/boot/compressed/Makefile   |    6
 arch/i386/boot/compressed/misc.c     |  224 --
 arch/x86_64/boot/compressed/Makefile |    6
 arch/x86_64/boot/compressed/misc.c   |  212 --
 include/linux/inflate.h              |    9
 init/do_mounts_rd.c                  |  129 -
 init/initramfs.c                     |  139 -
 lib/Makefile                         |    4
 lib/inflate.c                        | 3047 ++++++++++++++++-----------------
 11 files changed, 1688 insertions(+), 2337 deletions(-)

I've converted only some of the users, and currently only tested x86.
Additional x86 testing as well as testing my current ARM and x86_64
support and doing the fixups for the other arches would be
appreciated.

Current patch rollup against 2.6.5-rc1 is at:

 http://selenic.com/inflate-work.patch.bz2

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
