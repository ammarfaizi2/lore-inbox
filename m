Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263063AbSJBMHc>; Wed, 2 Oct 2002 08:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263064AbSJBMHc>; Wed, 2 Oct 2002 08:07:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:53213 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263063AbSJBMHb>; Wed, 2 Oct 2002 08:07:31 -0400
Date: Wed, 2 Oct 2002 14:12:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel makefiles broken?
In-Reply-To: <20021002114028.C24770@flint.arm.linux.org.uk>
Message-ID: <Pine.NEB.4.44.0210021410150.10143-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Oct 2002, Russell King wrote:

> Hi,

Hi Russell,

> I've noticed on two machines now that the kernel makefiles seem to have
> changed their behaviour.  One x86 RH-based, and one parisc debian based.
>
> make seems to ignores errors from gcc, and only stops when trying to link.
> On a PARISC box, I've seen the build get all the way though to successfully
> linking vmlinux, even with compilation failures.  Obviously not ideal,
> since vmlinux may not reflect reality.
>...

known bug, already fixed in Linus' BK tree, patch is below.

cu
Adrian


--- a/Rules.make	Tue Oct  1 21:00:23 2002
+++ b/Rules.make	Tue Oct  1 21:00:23 2002
@@ -517,13 +517,6 @@
   include $(cmd_files)
 endif

-# Emacs compile mode works best with relative paths to find files (OK
-# if verbose, as it tracks the make[1] entries and exits, etc.)
-
-ifneq ($(KBUILD_VERBOSE),1)
-  filter-output = 2>&1 | sed 's \(^[^/][A-Za-z0-9_./-]*:[ 0-9]\) $(RELDIR)/\1 '
-endif
-
 # function to only execute the passed command if necessary

 if_changed = $(if $(strip $? \
@@ -543,7 +536,7 @@
 			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
-	$(cmd_$(1)) $(filter-output); \
+	$(cmd_$(1)); \
 	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)

