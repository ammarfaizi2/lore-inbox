Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135538AbRDSEA6>; Thu, 19 Apr 2001 00:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135539AbRDSEAu>; Thu, 19 Apr 2001 00:00:50 -0400
Received: from tinylinux.tip.CSIRO.AU ([130.155.192.102]:51460 "EHLO
	mobilix.atnf.CSIRO.AU") by vger.kernel.org with ESMTP
	id <S135538AbRDSEAm>; Thu, 19 Apr 2001 00:00:42 -0400
Date: Thu, 19 Apr 2001 14:00:13 +1000
Message-Id: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU>
From: Richard Gooch <rgooch@atnf.csiro.au>
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
In-Reply-To: <20010418233445.A28628@thyrsus.com>
In-Reply-To: <20010418233445.A28628@thyrsus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond writes:
> So.  I've written a cross-reference analyzer for the configuration symbol
> namespace.  It's included with CML 1.2.0, which I just released.  The
> main reason I wrote it was to detect broken symbols.
> 
> A symbol is non-broken when:
> 	* It is used in either code or a Makefile
> 	* It is set in a (CML1) configuration file
> 	* It is either derived from other non-broken symbols 
>           or described in Configure.help

Ouch! You've got a number of false positives here. Some that struck
me:

> CONFIG_APM_IGNORE_SUSPEND_BOUNCE: arch/i386/kernel/apm.c
> CONFIG_DEVFS_TTY_COMPAT: Documentation/filesystems/devfs/ChangeLog
> CONFIG_DEVFS_BOOT_OPTIONS: Documentation/filesystems/devfs/ChangeLog
> CONFIG_DEVFS_DISABLE_OLD_NAMES: Documentation/filesystems/devfs/ChangeLog
> CONFIG_DEVFS_DISABLE_OLD_TTY_NAMES: Documentation/filesystems/devfs/ChangeLog
> CONFIG_DEVFS_ONLY: Documentation/filesystems/devfs/ChangeLog
> CONFIG_DEVFS: Documentation/filesystems/devfs/ChangeLog

These are options that used to be used, and now only reside in
documentation, ChangeLogs or in comments. These should not be removed
from the tree, irrespective of whether they cause your broken symbol
code to detect them.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
