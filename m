Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbTFQSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbTFQSr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:47:28 -0400
Received: from palrel13.hp.com ([156.153.255.238]:26346 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264888AbTFQSr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:47:27 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16111.25976.768140.306522@napali.hpl.hp.com>
Date: Tue, 17 Jun 2003 12:01:12 -0700
To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
Cc: "David S. Miller" <davem@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
       davidm@hpl.hp.com, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
Newsgroups: fa.linux.kernel
In-Reply-To: <3EEEBB1F.70609@digital.com>
References: <fa.it5uct2.s4s8om@ifi.uio.no>
	<fa.gvpfoqi.ngk8p2@ifi.uio.no>
	<3EEEBB1F.70609@digital.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 17 Jun 2003 12:24:23 +0530, "Aneesh Kumar K.V" <aneesh.kumar@digital.com> said:

  Aneesh> I was facing a simillar problem with ptrace on Alpha (ptrace
  Aneesh> on alpha expect the pt_regs at current + 2*PAGE_SIZE for
  Aneesh> 2.4. kernel ) w.r.t www.openssi.org project. What i found
  Aneesh> was that even after we return to user space subsequent
  Aneesh> syscalls are not putting pt_regs at that offset. I guess
  Aneesh> while entering the kernel kernel stack pointer always point
  Aneesh> to value stored in thread_struct.ksp ?

If a platform doesn't start with an empty kernel stack on entry from
user-space, that platform will be wasting (precious) stack space and
ptrace() most likely won't work reliably.  Personally, I'd consider
such behavior a bug, but I suppose it is to some degree a
platform-choice.

	--david
