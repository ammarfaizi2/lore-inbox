Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135605AbRAGCsH>; Sat, 6 Jan 2001 21:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135644AbRAGCr7>; Sat, 6 Jan 2001 21:47:59 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:5573 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S135605AbRAGCrr>; Sat, 6 Jan 2001 21:47:47 -0500
Message-ID: <3A57DA3E.6AB70887@uow.edu.au>
Date: Sun, 07 Jan 2001 13:53:50 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>
Subject: low-latency scheduling patch for 2.4.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A patch against kernel 2.4.0 final which provides low-latency
scheduling is at

	http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads

Some notes:

- Worst-case scheduling latency with *very* intense workloads is now
  0.8 milliseconds on a 500MHz uniprocessor.

  For normal workloads you can expect to achieve better than 0.5
  milliseconds for ever.  For example, worst-case latency between entry
  to an interrupt routine and activation of a usermode process during a
  `make clean && make bzImage' is 0.35 milliseconds.  This is one to
  three orders of magnitude better than BeOS, MacOS and the Windowses.

- Low latency is enabled from the `Processor type and features'
  kernel configuration menu for all architectures.  It would be nice to
  hear from non-x86 users.

- The SMP problem hasn't been addressed.  Enabling low-latency for
  SMP works well under normal workloads but comes unstuck under very
  heavy workloads.  I'll be taking a further look at this.

- The supporting tools `rtc_debug' and `amlat' have been updated. 
  These are quite useful tools for providing accurate measurement of
  latencies.  They may also be used to identify the causes of poor
  latency in the kernel.

- Remaining problem areas (the Don't Do That list) is pretty small:

  - Scrolling the fb console.
  - Running hdparm.
  - Using LILO
  - Starting the X server

- Low latency will probably only be achieved when using the ext2 and
  NFS filesystems.

- If you care about latency, be *very* cautious about upgrading to
  XFree86 4.x.  I'll cover this issue in a separate email, copied
  to the XFree team.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
