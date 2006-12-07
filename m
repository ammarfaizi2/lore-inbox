Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162564AbWLGRfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162564AbWLGRfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162580AbWLGRfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:35:51 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:41884
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1162564AbWLGRfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:35:51 -0500
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19 build hangs while running git for no reason...
Date: Thu, 7 Dec 2006 12:35:40 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612071235.41252.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right at the start of the build:

scripts/kconfig/conf -s arch/arm/Kconfig
  CHK     include/linux/version.h
  SYMLINK include/asm-arm/arch -> include/asm-arm/arch-integrator
  Generating include/asm-arm/mach-types.h

  CHK     include/linux/utsrelease.h
  UPD     include/linux/utsrelease.h

Where there's a one line gap the build hangs for five minutes (eating no CPU, 
blocked one something).  I hit "enter" and it resumes again.  It does this 
reproducibly for me.

It seems to be blocked running:
   6983 pts/3    S+     0:00 /bin/sh /usr/bin/git rev-parse --verify HEAD

Which is odd because this is the release version and hasn't got .git stuff in 
it.  I did an "rm /usr/bin/git" (I don't use it, I dunno why ubuntu decided 
to install it) and the hang went away.  Why is the build even _calling_ git 
on a release version?

The invocation was:
  make ARCH="${KARCH}" CROSS_COMPILE="${CROSS_TARGET}"- &&

Where KARCH=arm and CROSS_TARGET is a cross compile toolchain that built a 
working copy of uClibc.

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
