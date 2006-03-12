Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWCLVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWCLVpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWCLVpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 16:45:05 -0500
Received: from main.gmane.org ([80.91.229.2]:49883 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751082AbWCLVpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 16:45:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: mtime (default) resolution and why is it such?
Date: Mon, 13 Mar 2006 05:41:09 +0900
Message-ID: <dv2115$46a$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060209)
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There were some discussions on the subversion dev list about "svn and
shell scripts: managing properties" that boiled down to very quick
changes to a file (by sed) without changing its mtime ...

So I started to dig the kernel code to see what exactly is the mtime
resolution...

I could pin it down to include/linux:824

	/* Granuality of c/m/atime in ns.
	   Cannot be worse than a second */
	u32		   s_time_gran;

*** I feel this comment is wrong, should be granuLARity, submitting
*** a patch separately: 
*** [PATCH][TRIVIAL] Fix comments in 2.6.16-rc6: s/granuality/granularity/

But looking further down, I found fs/super.c:88

		s->s_time_gran = 1000000000;

So it seems that the default s_time_gran is 1 second... I was interested
for reiserfs, as that is the main fs I use.

Some filesystems use 1ns (nfs, jfs, xfs...), some 100ns (cifs, ntfs,
smbfs)... 

So I have quite a few questions popping in my head:

1. Is there any particular design concern with this?

2. Would speed performance be drowning if I (later we) play with the
   default, or at least patch reiserfs to use say 0.001s ?

3. What could be affected and how do I measure performance drop?

I understand that is not the root couse for the subversion problem, but
it may help me understand the problem better, so if you can spare a bit
of time to answer my quiestions I'd be gratefull.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


