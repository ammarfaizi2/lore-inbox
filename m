Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbTLITDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 14:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbTLITDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 14:03:20 -0500
Received: from palrel10.hp.com ([156.153.255.245]:54723 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266108AbTLITDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 14:03:19 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16342.7283.350878.950554@napali.hpl.hp.com>
Date: Tue, 9 Dec 2003 11:03:15 -0800
To: Paul Menage <menage@google.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI global lock macros
In-Reply-To: <3FD61CA5.6050203@google.com>
References: <F760B14C9561B941B89469F59BA3A8470255EFB3@orsmsx401.jf.intel.com>
	<3FD61CA5.6050203@google.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 09 Dec 2003 11:04:05 -0800, Paul Menage <menage@google.com> said:

  Paul> Grover, Andrew wrote:

  >> BTW, i386, x86_64 and ia64 all have this macro, so these all might need
  >> to be looked at.


  Paul> Yes, it was the differences between the i386 and x86_64
  Paul> versions that made me notice this problem. The ia64 version is
  Paul> in C, so looks safer.  Ideally there would be a common C
  Paul> definition - the only arch-specific part should be the locked
  Paul> cmpxchg, unless this lock is likely to be taken/released so
  Paul> often that it's performance critical.

As far as ia64 is concerned, you could replace ia64_cmpxchg4_acq()
with cmpxchg().  That should just work.  Of course, as you point out,
that wouldn't work on x86 UP because of the missing "lock" prefix.
Sounds like you'd need to add something along the lines of
device_atomic_cmpxchg() or something like that...

	--david
