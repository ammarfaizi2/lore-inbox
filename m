Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWHaUT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWHaUT6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 16:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWHaUT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 16:19:58 -0400
Received: from hera.kernel.org ([140.211.167.34]:10715 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932342AbWHaUT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 16:19:57 -0400
Date: Thu, 31 Aug 2006 20:19:52 +0000
From: Willy Tarreau <wtarreau@hera.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mtosatti@redhat.com
Subject: Linux 2.4.34-pre2
Message-ID: <20060831201952.GA25445@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This is Linux 2.4.34-pre2. It fixes several security issues which are
already solved in -stable. It also adds a few cleanups and minor fixes. 
Issues have calmed down, I believe it was the right moment to tag it.

Everything should build without trouble. After discussing the pros and
cons of merging Mikael Petterson's portability fixes to support gcc4, it
looks like people still using 2.4 were interested in this merge, while
those who had already fully moved to 2.6 expressed mixed opinions. The
fixes to support gcc 4 are mostly either obvious or pending bugs waiting
for some victim. Right now, the fixed tree is known to build with gcc 4.1
and run on the following architectures :

  i386 (UP/SMP), x86_64 (UP/SMP), PPC, sparc64 (UP/SMP)

Additionally, sparc is known to at least build, but possibly not all
drivers yet since it's harder to produce all config combinations.

The goal for 2.4.34-pre3 will be to merge those fixes and try to catch
the last remaining build errors if any. Since GCC4 also produces lots
of very interesting warnings, I'm interested in patches to silent them
(real fixes, not erroneous type casts to hide bugs). Patches to fix
other archs will be welcome (one patch per error with the capture of
the error in the commit please), and after a few pre-releases, the
gcc version check will be restored to prevent accidental build of
unsupported archs.

Also, keep in mind that we're still in preview versions. There are about
70 one-liner fixes, and I'm not going to run after every maintainer to
ask them for individual confirmation for mostly obvious fixes. If some
maintainer want to review some patches before the merge, please raise
your hand. Everything is available here anyway :

  http://www.kernel.org/git/?p=linux/kernel/git/wtarreau/linux-2.4-gcc4.git;a=summary 

During this time, 2.4.33-stable will still provide fixes, of course, so
even if in the extreme case, we broke a few pre-releases, it would not
be a problem at all.

Best regards,
Willy


Summary of changes from v2.4.34-pre1 to v2.4.34-pre2
============================================

dann frazier:
      drivers/scsi/sg.c : fix CVE-2006-1528
      [SCTP] Fix sctp_primitive_ABORT() call in sctp_close()
      Fix possible UDF deadlock and memory corruption (CVE-2006-4145)

Ernie Petrides:
      binfmt_elf.c : fix checks for bad address

Jeff Mahoney:
      [DISKLABEL] SUN: Fix signed int usage for sector count

PaX Team:
      cciss: do not mark cciss_scsi_detect __init
      i386 : fix exception processing in early boot

Solar Designer:
      crypto : prevent cryptoloop from oopsing on stupid ciphers
      loop.c: kernel_thread() retval check

Sridhar Samudrala:
      [SCTP] Local privilege elevation - CVE-2006-3745

Willy Tarreau:
      powerpc: Clear HID0 attention enable on PPC970 at boot time
      Revert "export memchr() which is used by smbfs and lp driver."
      [SPARC] export memchr() which is used by smbfs and lp driver.
      Change VERSION to 2.4.34-pre2

