Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUGFV2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUGFV2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 17:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUGFV2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 17:28:40 -0400
Received: from palrel13.hp.com ([156.153.255.238]:29625 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264560AbUGFV2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 17:28:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16619.6526.367058.311714@napali.hpl.hp.com>
Date: Tue, 6 Jul 2004 14:28:30 -0700
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: Table of mmap PROT_* implementations by architecture
In-Reply-To: <20040701033620.GB1564@mail.shareable.org>
References: <20040701033620.GB1564@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 1 Jul 2004 04:36:20 +0100, Jamie Lokier <jamie@shareable.org> said:

  >> From a study of Linux 2.6.5 source code, and some patches.
  Jamie> This is based on studying the source, not running tests, so
  Jamie> there may be errors.

  Jamie> This table shows expected page protections, for different
  Jamie> values of PROT_READ, PROT_WRITE and PROT_EXEC passed to
  Jamie> mmap() and mprotect().

  Jamie> (As noted in a recent mail from me, real behaviour isn't
  Jamie> quite this simple.  Reading from a write-only page will
  Jamie> *sometimes* raise a signal, and sometimes not, possibly
  Jamie> dependent on background paging decisions.  Therefore some of
  Jamie> these entries should say "!w!" instead of "rwx", and "!w-"
  Jamie> instead of "rw-".  Perhaps there are other combinations too,
  Jamie> depending on architecture-specific fault handlers).


  Jamie> ==============================================================
  Jamie> Requested PROT flags | --- R-- -W- RW- --X    R-X -WX RWX
  Jamie> ==============================================================
  Jamie> ia64                 | --- r-- rw- rw- --x(1) r-x rwx rwx
  Jamie> --------------------------------------------------------------

  Jamie> (1) - In kernel, maybe these pages are readable using
  Jamie> "write()"?

That's correct for ia64.  The architecture does not support an
"execute-only at all privilege levels" protection per se, so this
behavior is the easiest (most efficient) to implement.  If we really
cared about the "read execute-only at kernel-level", we could use
"probe" instructions in the __access_ok() macro to verify (user-level)
access permission.

	--david
