Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272163AbTG3JEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 05:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272823AbTG3JEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 05:04:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3713 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272163AbTG3JEH (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 05:04:07 -0400
Date: Wed, 30 Jul 2003 10:11:17 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, Riley@Williams.Name
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Cc: Linux-Kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > - I do prefer BROKEN, Alan prefers OBSOLETE
>  >   a s/BROKEN/OBSOLETE/g is acceptable for me
>
> To me at least, BROKEN and OBSOLETE have different meanings,
> and choice of which to use should depend on the circumstances.

I totally agree.

> Here's my choice of definitions for the cases that I can see:
>
>  * Driver has been replaced by a newer driver, and the old
>    driver is currently retained for cases that don't yet
>    work with the replacement. Driver will be removed in a
>    future kernel once the replacement handles all reported
>    cases.
>
> 		CONFIG_OBSOLETE

Infact, all you need to justify CONFIG_OBSOLETE is:

The driver _will_ be removed in a future kernel.

I.E. it has been decided for whatever reason, that it is going, but
too many people still rely on it.  This could be because there is a
replacement, there is no known physical hardware in existance, or it
is very old, and nobody uses it anybody - E.G. if a serious bug has
gone unnoticed for 2 major kernel revisions.

>  * Driver is for hardware that is not supported in modern
>    computers, and is retained for use with older computers
>    only. Driver will not be removed, but is not expected to
>    be compiled by most users.
>
> 		CONFIG_ANTIQUE

No need for this - either it works, or doesn't.  If nobody uses it for
a long time, it becomes a candidate for CONFIG_OBSOLETE.

>  * Driver does not work, and is thus disabled. If it is not
>    fixed in the near future, it will be considered to be
>    OBSOLETE as well.
>
> 		CONFIG_BROKEN

Please do _NOT_ do this - there is a far more important and worthwhile
reason to have a CONFIG_BROKEN than to simply save the few minutes of
inconvenience that including a non-compiling option in a kernel build
causes.

Imagine the situation where a driver such as a SCSI driver builds
successfully, but it silently corrupts data under certain, (possibly
rare), circumstances.

In that case, it's important to warn people that it's broken, because
it's not necessarily obvious, and could case significant data loss.
If something doesn't compile, it already gives you an error message.
The only problem is a few minutes of wasted time.

>  * Driver works on uniprocessor but not on SMP and is thus
>    disabled when compiling for SMP. It is assumed that the
>    driver will be fixed for SMP if relevant.
>
> 		CONFIG_BROKEN_ON_SMP

Please _don't_ do this either.  It implies that if
CONFIG_BROKEN_ON_SMP isn't set, then it's SMP safe - a lot of drivers
will NOT have been tested on SMP, so it's a bad thing to assume that
is the case.

>  * Driver was BROKEN some considerable number of releases
>    ago, and has never been fixed. It is thus assumed that
>    the driver is for some device that none of the kernel
>    developers is using. The driver will be removed in the
>    transition to the next major release if it retains this
>    status.
>
> 		CONFIG_BROKEN && CONFIG_OBSOLETE

See above for CONFIG_BROKEN.

> Personally, I'd like to see CONFIG_ANTIQUE (defaulting to "n")
> as a dependency for all drivers matching the description above
> simply to cut down on the amount of irrelevant choices in the
> configuration process.

Why?  Some of us are more interested in what _doesn't_ compile.

Adding layers of abstraction often appears to help in the short term,
but for experienced users, it often just gets in the way.

John.
