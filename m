Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRBUCph>; Tue, 20 Feb 2001 21:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131419AbRBUCpU>; Tue, 20 Feb 2001 21:45:20 -0500
Received: from brule.borg.umn.edu ([160.94.232.10]:9809 "EHLO
	brule.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S130388AbRBUCpH>; Tue, 20 Feb 2001 21:45:07 -0500
From: Peter Bergner <bergner@borg.umn.edu>
Date: Tue, 20 Feb 2001 21:08:02 -0600
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: bergner@us.ibm.com
Subject: Different CFLAGS for arch and non-arch files.
Message-ID: <20010220210802.A451159@brule.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully someone can point me in the right direction here.
I need to use different CFLAGS options depending on whether
I'm compiling arch dependent code or arch independent code.
It seems the arch/XXX/Makefile only adds extra options to
CFLAGS and doesn't allow me specify options I want to apply
only to arch dependent code and others I'd like to apply
only to arch independent code.  Has anyone done such a thing?

I guess I'd like to have CFLAGS, CFLAGS_ARCH and CFLAGS_NONARCH
vars that would be set in the arch/XXX/Makefile and then break
up the SUBDIRS var in the toplevel Makefile into SUBDIRS and
ARCHSUBDIRS so we could iterate over them with the different
CFLAGS options (ie, CFLAGS + CFLAGS_NONARCH for the arch independent
files and CFLAGS + CFLAGS_ARCH for the arch dependent files).

My reason for doing this is that our new architecture's ABI
specifies the use of a TOC (table of contents) and we're running
into a TOC overflow problem.  I can use GCC's -mminimal-toc option,
but not for routines that will be called before relocation is turned
on (the global TOC contains virtual addrs of the private TOCs).
My idea is to compile all the arch dependent code without the
-minimal-toc option and all the arch independent code with the
-minimal-toc option.

Any clues on what I can/need to do would be appreciated.

Peter

--
Peter Bergner
SLIC Optimizing Translator Development / Linux PPC64 Kernel Development
IBM Rochester, MN
bergner@us.ibm.com

