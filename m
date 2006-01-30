Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWA3Rhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWA3Rhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWA3Rhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:37:33 -0500
Received: from mail.gmx.de ([213.165.64.21]:20665 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964834AbWA3Rhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:37:33 -0500
X-Authenticated: #428038
Date: Mon, 30 Jan 2006 18:37:22 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       cdwrite@other.debian.org
Subject: Request to stop cdrecord's bogus accusations of Linux.
Message-ID: <20060130173722.GC3973@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	cdwrite@other.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörg,

with this open letter, I officially request that you stop your
misrepresentations in cdrecord that claim Linux were noncompliant in a
place where it is conforming to POSIX.

I am not speaking on behalf of any other party here, this is purely my
personal opinion that is supposed to make sure both sides play fair.

<ftp://ftp.berlios.de/pub/cdrecord/alpha/AN-2.01.01a05>
(dated 2006-01-29 20:20" states

  "-  Trying to work around a noncompliance (modified interface) present
  on newer Linux kernels that causes cdrecord to be unable to allocate a
  SCSI transfer buffer.

  Newer Linux kernels do not honor a contract from mlockall(MCL_FUTURE)
  after cdrecord turned off euid == 0 from a suid root installation.
  Instead of honoring mlockall(MCL_FUTURE), Linux checks each mmap() and
  compares against getrlimit(RLIMIT_MEMLOCK"

There is no such contract that would promise future allocations to
always succeed after MCL_FUTURE.

POSIX explicitly allows operating systems to fail later allocations if
the limit of mappable memory exceeds a certain limit, quoting the
mlockall() description from IEEE Std 1003.1-2001, 2004 edition:

  "If MCL_FUTURE is specified, and the automatic locking of future
  mappings eventually causes the amount of locked memory to exceed the
| amount of available physical memory or any other
| implementation-defined limit, the behavior is implementation-defined.
| The manner in which the implementation informs the application of
| these situations is also implementation-defined."

Linux is therefore POSIX compliant here. MCL_FUTURE succeeds and the
RLIMIT_MEMLOCK interface that you are whining about is this
"implementation-defined limit", and the implementation-defined behavior
refusing the allocation.

You had been told much earlier in linux-kernel@ that Linux is POSIX
compliant here, yet your document repeats this slander.

You are correct that Linux changed behavior beginning with release
2.6.9, but that change does not make Linux noncompliant with applicable
standards. I suggest to reword the quoted paragraph as

  "Working around a new behavior in Linux since 2.6.9 that causes
   cdrecord to be unable to allocate a SCSI transfer buffer.

   These Linux kernel versions impose a tighter RLIMIT_MEMLOCK limit
   than earlier versions that cause the allocation failure."

-- 
Matthias Andree
