Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVHBWiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVHBWiv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 18:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVHBWiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 18:38:51 -0400
Received: from xenotime.net ([66.160.160.81]:61825 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S261607AbVHBWiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 18:38:50 -0400
Date: Tue, 2 Aug 2005 15:38:46 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Documentation - how to apply patches for various trees
In-Reply-To: <200508022332.21380.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.50.0508021510050.26698-100000@shark.he.net>
References: <200508022332.21380.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005, Jesper Juhl wrote:

> Hi,
>
> Looking forward to your feedback (and possible inclusion).
>
> I guess this document could also be placed somewhere on kernel.org and linked
> to from the front page so that people downloading the various patches will
> have this information available at their fingertips.
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> ---
>
>  Documentation/applying-patches.txt |  221 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 221 insertions(+)
>
> diff -uP linux-2.6.13-rc5-orig/Documentation/applying-patches.txt linux-2.6.13-rc5/Documentation/applying-patches.txt
> --- linux-2.6.13-rc5-orig/Documentation/applying-patches.txt	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.13-rc5/Documentation/applying-patches.txt	2005-08-02 23:17:13.000000000 +0200
> @@ -0,0 +1,221 @@
> +
> +	Applying Patches To The Linux Kernel
> +	------------------------------------
> +
> +	(Written by Jesper Juhl, August 2005)
> +
> +
> +A frequently asked question on the Linux Kernel Mailing List is how to apply
> +a patch to the kernel or, more specifically, what base kernel a patch for
> +one of the many trees/branches should be applied to. Hopefully this document
> +will explain this to you.
> +
> +
> +What is a patch?
> +---
> + A patch is a small text document containing a delta of changes between two
> +different versions of a source tree. Patches are created with the `diff'
> +program.
> +To correctly apply a patch you need to know what base it was generated from
> +and what new version the patch will change the source tree into.
+These should both be present in the patch file metadata.

> +
> +
> +How do I apply a patch?
> +---
> + You apply a patch with the `patch' program. The patch program reads a diff
> +(or patch) file and makes the changes to the source tree described in it.
> +Patches for the Linux kernel are generated releative to the parent directory
                                              relative
> +holding the kernel source dir. This means that paths to files inside the
> +patch file contain the name of the kernel source dirs it was generated
                                                    directories
> +against - since this is unlikely to match the name of the kernel source dir
> +on your local machine (but is often useful info to see what version an
> +otherwise unlabeled patch was generated against) you should change into your
> +kernel source directory and then strip the first element of the path from
> +filenames in the patch file when applying it (the -p1 argument to `patch'
> +does this). To revert a previously applied patch, use the -R argument to
> +patch.
> +
> +
> +Where can I download the patches?
> +---
> +The patches are available at http://kernel.org/
> +Most recent patches are linked from the front page, but they also have
> +specific homes.
> +The 2.6.x.y (-stable) and 2.6.x patches live at
> + ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
or ftp.cc.kernel.org, where cc is a country code.

> +The -rc patches live at
> + ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/
> +The -git patches live at
> + ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/
> +The -mm kernels live at
> +ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
> +
> +
> +The 2.6.x kernels
> +---
> + These are the base stable releases released by Linus. The highest numbered
> +release is the most recent. If regressions or other serious flaws are found
> +then a -stable fix patch will be released (see below) on to of this base.
                                                            top
> +Once a new 2.6.x base kernel is released, a patch is made available that is
> +a delta between the previous 2.6.x kernel and the new one.
> +To apply a patch moving from 2.6.11 to 2.6.12 you'd do the following (note
> +that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
> +base 2.6.x kernel - if you need to move from 2.6.x.y to 2.6.x+1 you need to
> +first revert the 2.6.x.y patch).
> +
> +# moving from 2.6.11 to 2.6.12
> +$ cd ~/linux-2.6.11			# change to kernel source dir
> +$ patch -p1 < ../patch-2.6.12		# apply the 2.6.12 patch
> +$ cd ..
> +$ mv linux-2.6.11 linux-2.6.12		# rename source dir
> +
> +# moving from 2.6.11.1 to 2.6.12
> +$ cd ~/linux-2.6.11.1			# change to kernel source dir
> +$ patch -p1 -R < ../patch-2.6.11.1	# revert the 2.6.11.1 patch
> +					# source dir is now 2.6.11
> +$ patch -p1 < ../patch-2.6.12		# apply new 2.6.12 patch
> +$ cd ..
> +$ mv linux-2.6.11.1 inux-2.6.12		# rename source dir
> +
> +
> +The 2.6.x.y kernels
> +---
> + Kernels with 4 digit versions are -stable kernels. They contain small(ish)
> +critical fixes for security problems or significant regressions discovered
> +in a given 2.6.x kernel. This is the recommended branch for users who want
> +the most recent stable kernel and are not interrested in helping test
                                             interested
> +development/experimental versions. If no 2.6.x.y kernel is available, then
> +the highest numbered 2.6.x kernel is the current stable kernel.
> +These patches are not incremental, meaning that for example the 2.6.12.3
> +patch does not apply on top of the 2.6.12.2 kernel source, but rather on top
> +of the base 2.6.12 kernel source.
> +So, in order to apply the 2.6.12.3 patch to your existing 2.6.12.2 kernel
> +source you have to first back out the 2.6.12.2 patch (so you are left with a
> +base 2.6.12 kernel source) and then apply the new 2.6.12.3 patch.
> +Here's a small example
> +
> +$ cd ~/linux-2.6.12.2			# change into the kernel source dir
> +$ patch -p1 -R < ../patch-2.6.12.2	# revert the 2.6.12.2 patch
> +$ patch -p1 < ../patch-2.6.12.3		# apply the new 2.6.12.3 patch
> +$ cd ..
> +$ mv linux-2.6.12.2 linux-2.6.12.3	# rename the kernel source dir
> +
> +
> +The -rc kernels
> +---
> + These are ReleaseCandidate kernels. These are development kernels released
              "release-candidate" ?
> +by Linus whenever he deems the current git (the kernels source management
                                                   kernel's
> +tool) tree to be in a resonably sane state adequate for testing. These
                         reasonably
> +kernels are not stable and you should expect occasional breakage if you
> +intend to run them. This is however the most stable of the main development
> +branches and is also what will eventually turn into the next stable kernel,
> +so it is important that it be tested by as many people as possible.
> +This is a good branch to run for people who want to help out testing
> +development kernel but do not want to run some of the really experimental
               kernels
> +stuff (such people should see the sections about -git and -mm kernels below).
> +The -rc patches are not incremental, they apply to a base 2.6.x kernel, just
> +like the 2.6.x.y patches described above. The kernel version before the -rcN
> +suffix denotes the version of the kernel that this -rc kernel will eventually
> +turn into. So, 2.6.13-rc5 means that this is the fifth release candidate for
> +the 2.6.13 kernel and the patch should be applied on top of the 2.6.12
> +kernel source.
> +Here are 3 examples of how to apply these patches
> +
> +# first an example of moving from 2.6.12 to 2.6.13-rc3
> +$ cd ~/linux-2.6.12			# change into the 2.6.12 source dir
> +$ patch -p1 < ../patch-2.6.13-rc3	# apply the 2.6.13-rc3 patch
> +$ cd ..
> +$ mv linux-2.6.12 linux-2.6.13-rc3	# rename the source dir
> +
> +# now let's move from 2.6.13-rc3 to 2.6.13-rc5
> +$ cd ~/linux-2.6.13-rc3			# change into the 2.6.13-rc3 dir
> +$ patch -p1 -R < ../patch-2.6.13-rc3	# revert the 2.6.13-rc3 patch
> +$ patch -p1 < ../patch-2.6.13-rc5	# apply the new 2.6.13-rc5 patch
> +$ cd ..
> +$ mv linux-2.6.13-rc3 linux-2.6.13-rc5	# rename the source dir
> +
> +# finally let's try and move from 2.6.12.3 to 2.6.13-rc5
> +$ cd ~/linux-2.6.12.3			# change to the kernel source dir
> +$ patch -p1 -R < ../patch-2.6.12.3	# revert the 2.6.12.3 patch
> +$ patch -p1 < ../patch-2.6.13-rc5	# apply new 2.6.13-rc5 patch
> +$ cd ..
> +$ mv linux-2.6.12.3 linux-2.6.13-rc5	# rename the kernel source dir
> +
> +
> +The -git kernels
> +---
> + These are daily snapshots of Linus' kernel tree (managed in a git
> +repository, hence the name).
> +These patches are usually released daily and represent the current state of
> +Linus' tree. They are more experimental than -rc kernels since they are
> +generated automatically and have not been looked over and deemed worthy of
> +-rc status yet. -git patches are not incremental and apply either to a base
I think that this implies a little too much for -rc's regarding their
review and readiness.

> +2.6.x kernel or a base 2.6.x-rc kernel - you can see which from their name,
> +a patch named 2.6.12-git1 applies to the 2.6.12 kernel source and a patch
> +named 2.6.13-rc3-git2 applies to the source of the 2.6.13-rc3 kernel.
> +Here are some examples of how to apply these patches
> +
> +# moving from 2.6.12 to 2.6.12-git1
> +$ cd ~/linux-2.6.12			# change to the kernel source dir
> +$ patch -p1 < ../patch-2.6.12-git1	# apply the 2.6.12-git1 patch
> +$ cd ..
> +$ mv linux-2.6.12 linux-2.6.12-git1	# rename the kernel source dir
> +
> +# moving from 2.6.12-git1 to 2.6.13-rc2-git3
> +$ cd ~/linux-2.6.12-git1		# change to the kernel source dir
> +$ patch -p1 -R < ../patch-2.6.12-git1	# revert the 2.6.12-git1 patch
> +					# we now have a 2.6.12 kernel
> +$ patch -p1 < ../patch-2.6.13-rc2	# apply the 2.6.13-rc2 patch
> +					# the kernel is now 2.6.13-rc2
> +$ patch -p1 < ../patch-2.6.13-rc2-git3	# apply the 2.6.13-rc2-git3 patch
> +					# the kernel is now 2.6.13-rc2-git3
> +$ cd ..
> +$ mv linux-2.6.12-git1 linux-2.6.13-rc2-git3	# rename source dir
> +
> +
> +The -mm kernels
> +---
> + These are experimental kernels released by Andrew Morton. The -mm tree
> +serves as a sort of proving ground for new features and other experimental
> +patches. Once a patch has proved its worth in -mm for a while Andrew pushes
> +it on to Linus for inclusion in mainline. This branch is in constant flux
or other subsystem maintainers push their own patches to Linus, even
though (or after) they have been merged and tested in -mm.

> +and contains many experimental features, a lot of debugging patches not
> +appropriate for mainline etc and is the most experimental of the branches
> +described in this document. These kernels are not appropriate for use on
> +systems that are supposed to be stable and they a more risky to run than any
                                                  are
> +of the other branches (make sure you have up-to-date backups - that goes for
> +any experimental kernel but even more so for -mm kernels). These kernels in
> +addition to all the other experimental patches they contain usually also
> +contain any changes in the mainline -git kernels available at the time of
> +release.
> +Testing of -mm kernels is greatly appreciated since the whole point of the
> +tree is to weed out regressions, crashes, data corruption bugs, build
> +breakage (and any other bug in general) before changes are merged into the
> +more stable mainline Linus tree. But testers of -mm should be aware that
> +breakage in this tree is more common than in any other tree.
> +The -mm kernels are not released on a fixed schedule, but usually a few -mm
> +kernels are released in between each -rc kernel (1 to 3 is common).
> +The mm kernels apply to either a base 2.6.x kernel (when no -rc kernels have
      -mm
> +been released yet) or to a Linus -rc kernel.
> +Here are some examples of applying the -mm patches
> +
> +# moving from 2.6.12 to 2.6.12-mm1
> +$ cd ~/linux-2.6.12			# change to the 2.6.12 source dir
> +$ patch -p1 < ../2.6.12-mm1		# apply the 2.6.12-mm1 patch
> +$ cd ..
> +$ mv linux-2.6.12 linux-2.6.12-mm1	# rename the source appropriately
> +
> +# moving from 2.6.12-mm1 to 2.6.13-rc3-mm3
> +$ cd ~/linux-2.6.12-mm1
> +$ patch -p1 -R < ../2.6.12-mm1		# revert the 2.6.12-mm1 patch
> +					# we now have a 2.6.12 source
> +$ patch -p1 < ../patch-2.6.13-rc3	# apply the 2.6.13-rc3 patch
> +					# we now have a 2.6.13-rc3 source
> +$ patch -p1 < ../2.6.13-rc3-mm3		# apply the 2.6.13-rc3-mm3 patch
> +$ cd ..
> +$ mv linux-2.6.12-mm1 linux-2.6.13-rc3-mm3	# rename the source dir
> +
> +
> +This concludes this list of explanations of the various kernel trees and I
> +hope you are now crystal clear on how to apply the various patches and help
> +testing the kernel.
> -

-- 
~Randy
