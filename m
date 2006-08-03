Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWHCETe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWHCETe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHCETe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:19:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12978 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932331AbWHCETd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:19:33 -0400
Message-ID: <44D17957.10209@engr.sgi.com>
Date: Wed, 02 Aug 2006 21:19:35 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, Shailabh Nagar <nagar@watson.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: [patch 0/3] System accounting and taskstats update
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This posting is to replace the "CSA accounting and taskstats
update" patches i posted on 7/31.

This set of patches would provide basic system accounting
and extended system accounting data to userland using the
taskstats interface.

Patches are created against 2.6.18-rc2.

taskstats-rev2.patch
taskstats-acct.patch
bsd-to-xacct.patch

Regards,
  Jay Lan <jlan@sgi.com>

ChageLog:
  Feedbacks from Shailabh Nagar
  - realign new fields, and rename some fields names
  - keep ac_ prefix for basic accounting fields but
    remove prefix on extended accounting fields.
  - fix typos
  - use timespec_sub() routine simplify code
  - fix compilation issue if some CONFIG flags off
  - use 'static inlines' on CONFIG flag '#else' cases

  Feedbacks from Balbir Singh
  - use 'BUILD_DEBUG_ON' to check TS_COMM_LEN value
  - use portable cputime_to_msecs() API
  - set system time to 1 usec if both stime and utime
    are less than 1 usec.

  Since most of the accounting data required by CSA
  are also used in BSD Process Accounting, i initially
  named those accounting fields handling as "basic
  accounting" and the rest as "CSA extension". However,
  there is not really much left in CSA. Thus, it makes
  sense to eliminate CSA from the kernel all together.

  However, Shailabh liked to separate the taskstats
  interface part from the accounting data part and i
  agreed that it was the right thing to do.

  Thus, there will be kernel/tsacct.c and
  include/linux/tsacct_kern.h to become home of the
  accounting data handling code. A new config flag
  "CONFIG_TASK_XACCT" is added so that three routines
  dealing with extended accouting can be defined
  as dummy.

