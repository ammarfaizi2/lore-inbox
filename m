Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWHPKwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWHPKwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 06:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWHPKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 06:52:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751100AbWHPKws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 06:52:48 -0400
Date: Wed, 16 Aug 2006 12:52:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Tony Ernst <tee@sgi.com>
Subject: Re: [patch 2/3] add CSA accounting to taskstats
Message-ID: <20060816105222.GA10764@elf.ucw.cz>
References: <44CE5847.8050706@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CE5847.8050706@sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Signed-off-by:  Jay Lan <jlan@sgi.com>
> 

> Index: linux/include/linux/taskstats.h
> ===================================================================
> --- linux.orig/include/linux/taskstats.h	2006-07-31 11:42:10.000000000 -0700
> +++ linux/include/linux/taskstats.h	2006-07-31 11:50:00.412433042 -0700
> @@ -107,6 +107,21 @@ struct taskstats {
>  	__u64	ac_utime;		/* User CPU time [usec] */
>  	__u64	ac_stime;		/* SYstem CPU time [usec] */
>  	/* Basic Accounting Fields end */
> +
> + 	/* CSA accounting fields start */
> + 	__u16	csa_revision;		/* CSA Revision */
> + 	__u16	csa_pad[3];		/* Unused */

I guess you have way too many TLAs here...

> +config CSA_ACCT
> +	bool "Enable CSA Job Accounting (EXPERIMENTAL)"
> +	depends on TASKSTATS
> +	help

"Enable Comprehensive System Accounting Job Accounting" . Ouch. So you
do not even know how to use those accronyms correctly.

I guess you should invent some better naming.


> +	  Comprehensive System Accounting (CSA) provides job level
> +	  accounting of resource usage.  The accounting records are
> +	  written by the kernel into a file.  CSA user level scripts
> +	  and commands process the binary accounting records and
> +	  combine them by job identifier within system boot uptime
> +	  periods.  These accounting records are then used to produce
> +	  reports and charge fees to users.
> +
> +	  Say Y here if you want job level accounting to be compiled
> +	  into the kernel.  Say M here if you want the writing of
> +	  accounting records portion of this feature to be a loadable
> +	  module.  Say N here if you do not want job level accounting
> +	  (the default).
> +
> +	  The CSA commands and scripts package needs to be installed
> +	  to process the CSA accounting records.  See
> +	  http://oss.sgi.com/projects/csa for further information
> +	  about CSA and download instructions for the CSA commands
> +	  package and documentation.

...long text and it *still* does not tell me what it is good for.

> +/*
> + * Record revision levels.
> + *
> + * These are incremented to indicate that a record's format has changed since
> + * a previous release.
> + *
> + * History:     05000   The first rev in Linux
> + *              06000   Major rework to clean up unused fields and features.
> + *                      No binary compatibility with earlier rev.
> + *		07000	Convert to taskstats interface
> + */
> +#define REV_CSA		07000	/* Kernel: CSA base record */

We normally drop back compatibility at merge...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
