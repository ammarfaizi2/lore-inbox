Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265485AbTFRS6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 14:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbTFRS6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 14:58:31 -0400
Received: from palrel12.hp.com ([156.153.255.237]:1702 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265485AbTFRS63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 14:58:29 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.47509.643668.116939@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 12:12:21 -0700
To: linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org, roland@redhat.com
Subject: common name for the kernel DSO
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both x86 and ia64 now provide a dynamically shared object (DSO) for
system call purposes (e.g., to speed up system calls and for signal
trampoline/sigreturn purposes).  At the moment, the names of these
DSOs are different:

	x86:	linux-vsyscall.so.1
	ia64:	linux-gate.so.1

I think there is some value in using the same name on all platforms
that support such a DSO.  vsyscall makes no sense for ia64, since
there are no virtual syscalls (instead, ia64 linux provides a fast
system call convention which, when coupled with light-weight system
call handlers, provide full syscall semantics at more or less the
speed of virtual system calls).

Not surprisingly, I like the name "linux-gate", since that is really
what this DSO is all about: it's a gateway between user and kernel
space.  However, if this name isn't appropriate for x86, perhaps we
can find another name which will be acceptable to everybody.

I already checked with Roland McGrath (cc'd), and he agrees that a
common name would be good and said that he doesn't care about the
particular name that will be used.

Does anyone have any strong feelings about this?  If not, I plan to
submit a patch to rename the x86 DSO to linux-gate.so.1.

Thanks,

	--david
