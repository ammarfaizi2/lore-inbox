Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUCCCYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 21:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbUCCCYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 21:24:51 -0500
Received: from waste.org ([209.173.204.2]:13016 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262322AbUCCCYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 21:24:48 -0500
Date: Tue, 2 Mar 2004 20:24:44 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kpatchup 0.02 kernel patching script
Message-ID: <20040303022444.GA3883@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first release of kpatchup, a script for managing switching
between kernel releases via patches with some smarts:

 - understands -pre and -rc version numbering
 - aware of various external trees
 - automatically patch between any tree in an x.y release
 - automatically download and cache patches on demand
 - automatically determine the latest patch in various series
 - optionally print version strings or URLs for patches

Currently it knows about 2.4, 2.4-pre, 2.6, 2.6-pre, 2.6-bk, 2.6-mm,
and 2.6-tiny.

Example usage:

 $ head Makefile
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 2
 EXTRAVERSION =-rc2
 [...]
 $ kpatchup 2.6-mm
 2.6.2-rc2 -> 2.6.4-rc1-mm1
 Applying patch-2.6.2-rc2.bz2 -R
 Applying patch-2.6.2.bz2
 Applying patch-2.6.3.bz2
 Downloading patch-2.6.4-rc1.bz2...
 Applying patch-2.6.4-rc1.bz2
 Downloading 2.6.4-rc1-mm1.bz2...
 Applying 2.6.4-rc1-mm1.bz2
 $ head Makefile
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 4
 EXTRAVERSION =-rc1-mm1
 NAME=Feisty Dunnart
 [...] 
 $ kpatchup -q 2.6.3-rc1
 $ head Makefile
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 3
 EXTRAVERSION =-rc1
 NAME=Feisty Dunnart
 [...]
 $ kpatchup -s 2.6-bk
 2.6.4-rc1-bk3
 $ kpatchup -u 2.4-pre
 http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-2.4.26-pre1.bz2


This is an alpha release for people to experiment with. Feedback and
patches encouraged. Grab your copy today at:

 http://selenic.com/kpatchup/

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
