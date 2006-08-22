Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWHVVXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWHVVXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 17:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWHVVXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 17:23:11 -0400
Received: from hera.kernel.org ([140.211.167.34]:19902 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751299AbWHVVXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 17:23:10 -0400
Date: Tue, 22 Aug 2006 21:23:00 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mtosatti@redhat.com, "Patrick J. Volkerding" <volkerdi@slackware.com>,
       Grant Coady <gcoady.lk@gmail.com>
Subject: Linux 2.4.33.2
Message-ID: <20060822212300.GA30360@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

Linux 2.4.33.2 is out. It fixes a local privilege escalation in SCTP
(CVE-2006-3745). Also included are a fix for a bad address check in
binfmt_elf (already in 2.6), and a fix for build on some non-sparc
architectures which I broke in 2.4.33.1 when trying to fix the memchr()
export (problem reported by Mikael Pettersson).

If does not contain the UDF fix which went in 2.6.17.10. I will check
whether it applies to 2.4 and will backport it for a future release.

### Important note for users of Slackware 10.2 ###

Grant Coady informed me that 2.4.33.1 did not boot for him. After a long
series of tests from him and Pat Volkerding, it appeared that the problem
is caused by glibc 2.3.6 wrongly detecting kernel version as 4.33.1 and
mistakenly using the NTPL libs instead.

Patrick has fixed the problem and will (has ?) send the fix to the glibc
team. By now people using Slackware 10.2 must upgrade their glibc to
glibc-solibs-2.3.5-i486-6_slack10.2.tgz if they want to run a 2.4.33.x
kernel (user glibc-2.3.6 build -5 for -current). A workaround is either
to rename /lib/tls or to rename the kernel to something different than
4 numbers separated by dots. Since the problem is fixed, I don't intend
to change the numbering.

I dont think that this problem might affect many other distros since those
shipping an NPTL-enabled libc with both 2.4 and 2.6 mainline are rare. If
anyone else encounters the problem, Pat has the fix.


Regards,
Willy



Summary of changes from v2.4.33.1 to v2.4.33.2
============================================

Ernie Petrides:
      binfmt_elf.c : fix checks for bad address

Sridhar Samudrala:
      [SCTP] Local privilege elevation - CVE-2006-3745

Willy Tarreau:
      Revert "export memchr() which is used by smbfs and lp driver."
      [SPARC] export memchr() which is used by smbfs and lp driver.
      Change VERSION to 2.4.33.2


