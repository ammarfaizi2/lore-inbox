Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTJIWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTJIWQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:16:57 -0400
Received: from pat.uio.no ([129.240.130.16]:15584 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261270AbTJIWQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:16:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16261.56894.8109.858323@charged.uio.no>
Date: Thu, 9 Oct 2003 18:16:30 -0400
To: Ulrich Drepper <drepper@redhat.com>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: statfs() / statvfs() syscall ballsup...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

  We appear to have a problem with the new statfs interface
in 2.6.0...

The problem is that as far as userland is concerned, 'struct statfs'
reports f_blocks, f_bfree,... in units of the "optimal transfer size":
f_bsize (backwards compatibility).

OTOH 'struct statvfs' reports the same values in units of the fragment
size (the blocksize of the underlying filesyste): f_frsize. (says
Single User Spec v2)

Both are apparently supposed to syscall down via sys_statfs()...

Question: how we're supposed to reconcile the two cases for something
like NFS, where these 2 values are supposed to differ?

Note that f_bsize is usually larger than f_frsize, hence conversions
from the former to the latter are subject to rounding errors...

Cheers,
  Trond
