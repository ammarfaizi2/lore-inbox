Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWAKIj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWAKIj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWAKIj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:39:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:14009 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932588AbWAKIj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:39:26 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Subject: 2.6.15 make fails with multiple targets in parallel
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 11 Jan 2006 19:39:11 +1100
Message-ID: <13394.1136968751@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running make on the kernel tree with multiple targets on the command
line and in parallel mode gets errors.  The prepare targets are run
several times, once for each target on the command line.  Sometimes the
result is sensible, sometimes the prepare commands overwrite each other
with either garbage or missing files.

make -j12 compressed modules vmlinux
  Using /foo/linux as source for kernel
  Using /foo/linux as source for kernel
  Using /foo/linux as source for kernel
  GEN    /foo/obj/Makefile
  CHK     include/linux/version.h
  GEN    /foo/obj/Makefile
  GEN    /foo/obj/Makefile
  CHK     include/linux/version.h
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  UPD     include/linux/version.h
  UPD     include/linux/version.h
mv: cannot stat `include/linux/version.h.tmp': No such file or directory
make[1]: *** [include/linux/version.h] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [vmlinux] Error 2
make: *** Waiting for unfinished jobs....

I know that the command above is equivalent to 'make -j12' but that is
irrelevant, make is supposed to handle multiple targets without
repeating commands.

Is this where we mention http://www.google.com/search?q=cache:HwuX7YF2uBIJ:aegis.sourceforge.net/auug97.pdf&hl=en ?

