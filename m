Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTDYVFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264458AbTDYVFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:05:20 -0400
Received: from palrel11.hp.com ([156.153.255.246]:48286 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264446AbTDYVFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:05:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16041.42469.529671.272810@napali.hpl.hp.com>
Date: Fri, 25 Apr 2003 14:17:25 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 vsyscall DSO implementation
In-Reply-To: <b8c7m5$u3u$1@cesium.transmeta.com>
References: <3EA8942D.4050201@pobox.com>
	<200304250210.h3P2AoU12348@magilla.sf.frob.com>
	<16041.24730.267207.671647@napali.hpl.hp.com>
	<b8c7m5$u3u$1@cesium.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 25 Apr 2003 14:00:53 -0700, "H. Peter Anvin" <hpa@zytor.com> said:

  hpa> Followup to: <16041.24730.267207.671647@napali.hpl.hp.com> By
  hpa> author: David Mosberger <davidm@napali.hpl.hp.com> In
  hpa> newsgroup: linux.dev.kernel

  >>  I like this.  Even better would be if all platforms could do the
  >> same.  I'm definitely interested in doing something similar for
  >> ia64 (the getunwind() syscall was always just a stop-gap
  >> solution).

  >> I assume that these kernel ELF images would then show up in
  >> dl_iterate_phdr()?

  >> To complete the picture, it would be nice if the kernel ELF
  >> images were mappable files (either in /sysfs or /proc) and would
  >> show up in /proc/PID/maps.  That way, a distributed application
  >> such as a remote debugger could gain access to the kernel unwind
  >> tables on a remote machine (assuming you have a remote
  >> filesystem).

  hpa> How about /boot?

You mean a regular file?  I'm not sure whether this could be made to
work.  The /proc/PID/maps entry (really: the vm_area for the kernel
ELF images) would have to be created by the kernel, at a time when no
real filesystem is available.  Also, since the kernel needs to store
the data in kernel-memory anyhow, I don't think there is much point in
storing it on disk as well.

	--david
