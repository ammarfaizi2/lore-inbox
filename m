Return-Path: <linux-kernel-owner+w=401wt.eu-S1752731AbWLXU32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbWLXU32 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbWLXU3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:29:03 -0500
Received: from mail3.panix.com ([166.84.1.74]:51626 "EHLO mail3.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbWLXU24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:28:56 -0500
Message-Id: <20061224202207.150596681@panix.com>
User-Agent: quilt/0.45-1
Date: Sun, 24 Dec 2006 12:22:07 -0800
From: Zack Weinberg <zackw@panix.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, jmorris@namei.org,
       Chris Wright <chrisw@sous-sol.org>, Vincent Legoll <vlegoll@9online.fr>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/4] /proc/kmsg permissions, take four
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's yet another revision of the /proc/kmsg permissions patch
series.  To recap, the point is to allow klogd to drop privileges
and continue reading from /proc/kmsg (currently, even if klogd has a
legitimately opened fd on /proc/kmsg, it cannot read from it unless
it has CAP_SYS_ADMIN asserted).  SELinux's pickier and finer-grained
privilege rules for /proc/kmsg are unchanged.

There are two significant changes from the previous revision.  First,
in keeping with the recommended style, I have eliminated the
security_syslog_or_fail() macro.  Instead there is a static array mapping
KLOG_* opcodes to LSM_KLOG_* privilege classes.  This requires slightly
different coding in the security hooks but I think it's clearer overall.
Second, I've incorporated Vincent Legoll's kerneldoc comment for sys_syslog
(nee do_syslog) with some wording improvements and expansion to cover the
klog_* functions introduced part-way through the patch.  I don't think
proc/kmsg.c needs kerneldoc, it's very simple after this patch series.

I've been through Documentation/CodingStyle and satisfied myself that
everything is now in the proper mode.  I don't suppose anyone has comments
on the *content* of the changes...?

zw

