Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTDYQJi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTDYQJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:09:38 -0400
Received: from palrel10.hp.com ([156.153.255.245]:8117 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263372AbTDYQJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:09:37 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16041.24730.267207.671647@napali.hpl.hp.com>
Date: Fri, 25 Apr 2003 09:21:46 -0700
To: Roland McGrath <roland@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] i386 vsyscall DSO implementation
In-Reply-To: <200304250210.h3P2AoU12348@magilla.sf.frob.com>
References: <3EA8942D.4050201@pobox.com>
	<200304250210.h3P2AoU12348@magilla.sf.frob.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like this.  Even better would be if all platforms could do the same.
I'm definitely interested in doing something similar for ia64 (the
getunwind() syscall was always just a stop-gap solution).

I assume that these kernel ELF images would then show up in
dl_iterate_phdr()?

To complete the picture, it would be nice if the kernel ELF images
were mappable files (either in /sysfs or /proc) and would show up in
/proc/PID/maps.  That way, a distributed application such as a remote
debugger could gain access to the kernel unwind tables on a remote
machine (assuming you have a remote filesystem).

	--david

>>>>> On Thu, 24 Apr 2003 19:10:50 -0700, Roland McGrath <roland@redhat.com> said:

  >> We already embed a cpio archive into __initdata space.  What
  >> about putting the images in there, and either copying the data
  >> out of initramfs, or, directly referencing the pages that store
  >> each image?

  Roland> It doesn't matter to me, but I don't see the benefit to
  Roland> doing that.  It's rather unlike what initramfs is used for
  Roland> now and would need a bunch of extra code to accomplish
  Roland> something very simple.

  Roland> The DSO images are not stored page-aligned and padded in the
  Roland> kernel image, so the pages can't be used directly.  Storing
  Roland> them that way would use more space in the kernel image on
  Roland> disk, and then you'd want to free initdata page containing
  Roland> the unused one.
