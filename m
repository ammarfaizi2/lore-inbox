Return-Path: <linux-kernel-owner+w=401wt.eu-S932621AbWLOAq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932621AbWLOAq7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWLOAqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:46:38 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:60448 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932621AbWLOAqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:46:36 -0500
Message-Id: <20061215001639.988521000@panix.com>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 16:16:39 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/4] /proc/kmsg permissions, take three
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a re-revised version of my patch set to allow klogd to drop
privileges and continue reading from /proc/kmsg (currently, even if klogd
has a legitimately opened fd on /proc/kmsg, it cannot read from it unless
it has CAP_SYS_ADMIN asserted).  SELinux's pickier and finer-grained
privilege rules for /proc/kmsg are unchanged.

The major change from the previous patchset
[q.v. http://comments.gmane.org/gmane.linux.kernel/466034 ] is that,
as Arjan van de Ven requested, the new header linux/klog.h contains only
userspace-visible definitions (the constants for sys_syslog()).  Thanks to
Alexey Dobriyan for telling me the proper place to put the KLOGSEC_*
constants (now renamed LSM_KLOG_* in keeping with other such constants).
They have also been rediffed versus yesterday's git.  They should be
applied in sequence; each step compiles, and the complete set has been
booted and tested to work as intended.

Any comments, as usual, appreciated.  I would very much like to see this
in 2.6.20.

zw

