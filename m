Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264184AbUFNUkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUFNUkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUFNUko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:40:44 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:21601 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264184AbUFNUjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:39:22 -0400
Date: Mon, 14 Jun 2004 22:48:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] kbuild: external module build doc
Message-ID: <20040614204809.GF15243@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614204029.GA15243@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/14 22:21:46+02:00 sam@mars.ravnborg.org 
#   kbuild: Add external module documentation
#   
#   Add first version of a document describing how to build external modules.
#   This is not yet finished, but includes information that is nice to have
#   documented in the kernel even in a less complete form.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Documentation/kbuild/extmodules.txt
#   2004/06/14 22:21:32+02:00 sam@mars.ravnborg.org +168 -0
# 
# Documentation/kbuild/extmodules.txt
#   2004/06/14 22:21:32+02:00 sam@mars.ravnborg.org +0 -0
#   BitKeeper file /home/sam/bk/kbuild/Documentation/kbuild/extmodules.txt
# 
# Documentation/kbuild/00-INDEX
#   2004/06/14 22:21:32+02:00 sam@mars.ravnborg.org +2 -0
#   Added extmodules.txt
# 
diff -Nru a/Documentation/kbuild/00-INDEX b/Documentation/kbuild/00-INDEX
--- a/Documentation/kbuild/00-INDEX	2004-06-14 22:25:21 +02:00
+++ b/Documentation/kbuild/00-INDEX	2004-06-14 22:25:21 +02:00
@@ -6,3 +6,5 @@
 	- developer information for linux kernel makefiles
 modules.txt
 	- how to build modules and to install them
+extmodules.txt
+	- specific information about external modules
diff -Nru a/Documentation/kbuild/extmodules.txt b/Documentation/kbuild/extmodules.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/kbuild/extmodules.txt	2004-06-14 22:25:21 +02:00
@@ -0,0 +1,168 @@
+Building external modules
+=========================
+kbuild offers functionality to build external modules, with the
+prerequisite that there is a pre-built kernel avialable with full source.
+A subset of the targets available when building the kernel is available
+when building an external module.
+
+
+Building the module
+-------------------
+The command looks like his:
+
+	make -C <path to kernel src> M=`pwd`
+
+For the above command to succeed the kernel must have been built with
+modules enabled.
+
+To install the modules just being built:
+
+	make -C <path to kernel src> M=`pwd` modules_install
+
+More complex examples later, the above should get you going in most cases.
+
+
+Available targets
+- - - - - - - - - 
+$KDIR refer to path to kernel src
+
+make -C $KDIR M=`pwd`
+	Will build the module(s) located in current directory. All output
+	files will be located in the same directory as the module source.
+	No attemps are made to update the kernel source, and it is
+	expected that a successfully make has been executed
+	for the kernel.
+
+make -C $KDIR M=`pwd` modules
+	Same as if no target was specified. See description above.
+
+make -C $KDIR M=$PWD modules_install
+	Install the external module(s)
+
+make -C $KDIR M=$PWD clean
+	Remove all generated files in for the module - not the kernel
+
+make -C $KDIR M=`pwd` help
+	help will list the available target when building external
+	modules.
+
+Available options:
+- - - - - - - - - 
+$KDIR refer to path to kernel src
+
+make -C $KDIR
+	Used to specify where to find the kernel source.
+	'$KDIR' represent the directory where the kernel source is.
+	Make will actually change directory to the specified directory
+	when executed but change back when finished.
+
+make -C $KDIR M=`pwd`
+	M= is used to tell kbuild that an external module is being built.
+	The option given to M= is the directory where the external
+	module is located.
+	When an external module is being built only a subset of the
+	usual targets are avialable.
+
+make -C $KDIR SUBDIRS=`pwd`
+	Same as M=. The SUBDIRS= syntax is kept for backwards compatibility.
+
+
+A more advanced example
+- - - - - - - - - - - -
+This example shows a setup where a distribution has wisely decided
+to separate kernel source and output files:
+
+Kernel src:
+/usr/src/linux-<kernel-version>/
+
+Output from a kernel compile, including .config:
+/lib/modules/linux-<kernel-version>/build/
+
+External module to be compiled:
+/home/user/module/src/
+
+To compile the module located in the directory above use the
+following command:
+
+	cd /home/user/module/src
+	make -C /usr/src/linux-<kernel-version> \
+	O=/lib/modules/linux-<kernel-version>/build \
+	M=`pwd`
+
+Then to install the module use the following command:
+
+	make -C /usr/src/linux-<kernel-version> \
+		O=/lib/modules/linux-<kernel-version>/build \
+		M='pwd` modules_install
+
+The above are rather long commands, and the following chapter
+lists a few tricks to make it all easier.
+
+Tricks to make it easy
+---------------------
+TODO: .... This need to be rewritten......
+
+A make line with several parameters becomes tiresome and errorprone
+and what follows here is a little trick to make it possible to build
+a module only using a single 'make' command.
+
+Create a makefile named 'Makefile' with the following content:
+---> Makefile:
+
+all:
+	$(MAKE) -C /home/sam/src/kernel/v2.6 M=`pwd` \
+			$(filter-out all,$(MAKECMDGOALS))
+
+obj-m := module.o
+---> End of Makefile
+
+When make is invoked it will see the all: rule, and simply call make again with the right parameters.
+
+If a driver is being developed that is targeted for inclusion in the main kernel, an idea is to seperate out the all: rule to a Makefile nemed makefile (lower capital m) like this:
+
+---> makefile
+all:
+	$(MAKE) -f Makefile -C /home/sam/src/kernel/v2.6 \
+	        M=$(PWD) $(MAKECMDGOALS)
+
+---> End of makefile
+
+The kbuild makefile will include only a single statement:
+---> Makefile:
+
+obj-m := module.o
+
+---> End of Makefile
+When executing make, it looks for a file named makefile, before a
+file named Makefile. Therefor make will pick up the file named with lower capital 'm'.
+
+
+Prepare the kernel for building external modules
+------------------------------------------------
+When building external modules the kernel is expected to be prepared.
+This includes the precense of certain binaries, the kernel configuration
+and the symlink to include/asm.
+To do this a convinient target is made:
+
+	make modules_prepare
+
+For a typical distribution this would look like the follwoing:
+
+	make modules_prepare O=/lib/modules/linux-<kernel version>/build
+
+
+TODO: Fill out the following chapters
+
+Module versioning
+-----------------
+
+Include files targeted towards kernel include/...
+-------------------------------------------------
+
+Local include files
+-------------------
+
+Binary only .o files
+--------------------
+Use _shipped.
+
