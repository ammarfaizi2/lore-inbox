Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWHPRXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWHPRXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWHPRXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:23:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46478 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751205AbWHPRXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:23:03 -0400
Message-ID: <44E3546A.1020902@sgi.com>
Date: Wed, 16 Aug 2006 10:22:50 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jes Sorensen <jes@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Tony Ernst <tee@sgi.com>
Subject: Re: [patch 2/3] add CSA accounting to taskstats
References: <44CE5847.8050706@sgi.com> <20060816105222.GA10764@elf.ucw.cz>
In-Reply-To: <20060816105222.GA10764@elf.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!

Hi Pavel,

Thanks much for your feedback.

However, the patchset you commented on was replaced by a new
patchset posted on 8/03:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115457888801994&w=2

Thanks,
  - jay

> 
> 
>>Signed-off-by:  Jay Lan <jlan@sgi.com>
>>
> 
>>Index: linux/include/linux/taskstats.h
>>===================================================================
>>--- linux.orig/include/linux/taskstats.h	2006-07-31 11:42:10.000000000 -0700
>>+++ linux/include/linux/taskstats.h	2006-07-31 11:50:00.412433042 -0700
>>@@ -107,6 +107,21 @@ struct taskstats {
>> 	__u64	ac_utime;		/* User CPU time [usec] */
>> 	__u64	ac_stime;		/* SYstem CPU time [usec] */
>> 	/* Basic Accounting Fields end */
>>+
>>+ 	/* CSA accounting fields start */
>>+ 	__u16	csa_revision;		/* CSA Revision */
>>+ 	__u16	csa_pad[3];		/* Unused */
> 
> 
> I guess you have way too many TLAs here...
> 
> 
>>+config CSA_ACCT
>>+	bool "Enable CSA Job Accounting (EXPERIMENTAL)"
>>+	depends on TASKSTATS
>>+	help
> 
> 
> "Enable Comprehensive System Accounting Job Accounting" . Ouch. So you
> do not even know how to use those accronyms correctly.
> 
> I guess you should invent some better naming.
> 
> 
> 
>>+	  Comprehensive System Accounting (CSA) provides job level
>>+	  accounting of resource usage.  The accounting records are
>>+	  written by the kernel into a file.  CSA user level scripts
>>+	  and commands process the binary accounting records and
>>+	  combine them by job identifier within system boot uptime
>>+	  periods.  These accounting records are then used to produce
>>+	  reports and charge fees to users.
>>+
>>+	  Say Y here if you want job level accounting to be compiled
>>+	  into the kernel.  Say M here if you want the writing of
>>+	  accounting records portion of this feature to be a loadable
>>+	  module.  Say N here if you do not want job level accounting
>>+	  (the default).
>>+
>>+	  The CSA commands and scripts package needs to be installed
>>+	  to process the CSA accounting records.  See
>>+	  http://oss.sgi.com/projects/csa for further information
>>+	  about CSA and download instructions for the CSA commands
>>+	  package and documentation.
> 
> 
> ...long text and it *still* does not tell me what it is good for.
> 
> 
>>+/*
>>+ * Record revision levels.
>>+ *
>>+ * These are incremented to indicate that a record's format has changed since
>>+ * a previous release.
>>+ *
>>+ * History:     05000   The first rev in Linux
>>+ *              06000   Major rework to clean up unused fields and features.
>>+ *                      No binary compatibility with earlier rev.
>>+ *		07000	Convert to taskstats interface
>>+ */
>>+#define REV_CSA		07000	/* Kernel: CSA base record */
> 
> 
> We normally drop back compatibility at merge...
> 									Pavel
> 

