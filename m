Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265164AbRFUTpV>; Thu, 21 Jun 2001 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265163AbRFUTpL>; Thu, 21 Jun 2001 15:45:11 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:60575 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S265158AbRFUTpH>; Thu, 21 Jun 2001 15:45:07 -0400
Message-ID: <3B324F1B.5AFA437B@idcomm.com>
Date: Thu, 21 Jun 2001 13:46:35 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: Is this part of newer filesystem hierarchy?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found on my newer Redhat 7.1 distribution that glibc is being placed
differently than just /lib/. Here is the structure I found:

/lib/ has:
libc-2.2.2.so (hard link)
libc.so.6     (sym link to above)

A new directory appears, /lib/i686/ (uname -m is i686):
libc-2.2.2.so (a full hard link copy of /lib/ version)
libc.so.6     (sym link to hard link in this directory)

The file size of /lib/libc-2.2.2.so is around 1.2 MB, while the size of
/lib/i686/libc-2.2.2.so is over 5 MB. The 5 MB version has symbols,
while the 1.2 MB version is stripped.

Here is the peculiar part that I need to find out about. My
/lib/ld.so.conf does not contain the i686 directory in its path. Nor do
any local LD environment variables. Even so, "ldconfig -p" lists *only*
the libc.so.6 sym link, not the libc-2.2.2.so, and the one listed is for
the i686 subdirectory, not the /lib/ directory. How is it possible that
the i686 directory is being checked if it is not listed in ld.so.conf
and not part of any LD path variable? I am using a non-Redhat kernel
(patched 2.4.6-pre1), so I know it isn't a Redhat-ism related to the
kernel itself. My ld version:
~# ld --version
GNU ld 2.10.91
Copyright 2001 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms
of
the GNU General Public License.  This program has absolutely no
warranty.
  Supported emulations:
   elf_i386
   i386linux
   elf_i386_glibc21

Possibly Redhat altered ld? According to the man page, this directory
should not be found since it is not part of ld.so.conf, and also the
/lib/ version *should* be found (but isn't). What has changed, is it a
standard for filesystem hierarchy, or is it something distribution
specific? (I need to pass the answer along to someone working on
customized boot software that is currently being confused by this
distinction; there is a need to find a proper means to detect libc and
linker information)

D. Stimits, stimits@idcomm.com
