Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVHCV2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVHCV2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVHCV2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:28:20 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:13153 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVHCV2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:28:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=auzatImUxBtr5Lv8QOaKMi/PV85kbajyWlgjDqNi95sNwcoe0aHQmf0OjaIne8bbV9AfvdzUnc3X5b8ubUBh91wWcw8UTY3giuwLygFVb4ya51Yxr1sBGKW43rv5NNFFYG2lUalDub0ebHQwv8V13KRsuqWw+DAZ9DPkClWmFAo=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Documentation - how to apply patches for various trees
Date: Wed, 3 Aug 2005 23:28:06 +0200
User-Agent: KMail/1.8.2
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       Bodo Eggert <7eggert@gmx.de>, Gene Heskett <gene.heskett@verizon.net>,
       "H. Peter Anvin" <hpa@zytor.com>, David Brown <dmlb2000@gmail.com>,
       Puneet Vyas <vyas.puneet@gmail.com>,
       Richard Hubbell <richard.hubbell@gmail.com>, webmaster@kernel.org
References: <200508022332.21380.jesper.juhl@gmail.com> <200508032251.07996.jesper.juhl@gmail.com> <Pine.LNX.4.58.0508031400390.3258@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508031400390.3258@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508032328.07727.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 23:08, Linus Torvalds wrote:
> 
> On Wed, 3 Aug 2005, Jesper Juhl wrote:
> >
> > Here's an updated version of my document that attempts to give a short 
> > explanation of the various kernel trees and how to apply their patches.
> > It incorporates all the feedback I've gotten (thanks guys). 
> 
> Can we have more whitespace?
> 
Certainly.

<snip long explanation, which makes sense, of why shorter paragraphs and more whitespace is good>

> And since we have a single empty line implying paragraph breaks, feel free 
> to use multiple empty lines to imply "bigger" breaks (you seem to do this 
> already).
> 

Here's an updated version with more whitespace.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/applying-patches.txt |  323 +++++++++++++++++++++++++++++++++++++
 1 files changed, 323 insertions(+)

diff -uP linux-2.6.13-rc5-orig/Documentation/applying-patches.txt linux-2.6.13-rc5/Documentation/applying-patches.txt
--- linux-2.6.13-rc5-orig/Documentation/applying-patches.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13-rc5/Documentation/applying-patches.txt	2005-08-03 23:23:24.000000000 +0200
@@ -0,0 +1,323 @@
+
+	Applying Patches To The Linux Kernel
+	------------------------------------
+
+	(Written by Jesper Juhl, August 2005)
+
+
+
+A frequently asked question on the Linux Kernel Mailing List is how to apply
+a patch to the kernel or, more specifically, what base kernel a patch for
+one of the many trees/branches should be applied to. Hopefully this document
+will explain this to you.
+
+
+What is a patch?
+---
+ A patch is a small text document containing a delta of changes between two
+different versions of a source tree. Patches are created with the `diff'
+program.
+To correctly apply a patch you need to know what base it was generated from
+and what new version the patch will change the source tree into. These
+should both be present in the patch file metadata.
+
+
+How do I apply a patch?
+---
+ You apply a patch with the `patch' program. The patch program reads a diff
+(or patch) file and makes the changes to the source tree described in it.
+
+Patches for the Linux kernel are generated relative to the parent directory
+holding the kernel source dir.
+
+This means that paths to files inside the patch file contain the name of the
+kernel source directories it was generated against.
+Since this is unlikely to match the name of the kernel source dir on your
+local machine (but is often useful info to see what version an otherwise
+unlabeled patch was generated against) you should change into your kernel
+source directory and then strip the first element of the path from filenames
+in the patch file when applying it (the -p1 argument to `patch' does this).
+To revert a previously applied patch, use the -R argument to patch.
+
+
+How do I feed a patch/diff file to `patch'?
+---
+ This (as usual with Linux and other UNIX like operating systems) can be
+done in several different ways.
+In all the examples below I feed the file (in uncompressed form) to patch
+via stdin using the following syntax:
+	patch -p1 < path/to/patch-x.y.z
+
+but patch can also get the name of the file to use via the -i argument, like
+this:
+	patch -p1 -i path/to/patch-x.y.z
+
+If your patch file is compressed with gzip or bzip2 and you don't want to
+uncompress it before applying it, then you can feed it to patch like this
+instead:
+	zcat path/to/patch-x.y.z.gz | patch -p1
+	bzcat path/to/patch-x.y.z.bz2 | patch -p1
+
+If you wish to uncompress the patch file by hand first before applying it
+(what I assume you've done in the examples below), then you simply run
+gunzip or bunzip2 on the file - like this:
+	gunzip patch-x.y.z.gz
+	bunzip2 patch-x.y.z.bz2
+
+Which will leave you with a plain text patch-x.y.z file that you can feed to
+patch via stdin or the -i argument, as you prefer.
+
+
+Are there any alternatives to `patch'?
+---
+ Yes there are alternatives. You can use the `interdiff' program
+(http://cyberelk.net/tim/patchutils/) to generate a patch representing the
+differences between two patches and then apply the result.
+This will let you move from something like 2.6.12.2 to 2.6.12.3 in a single
+step. The -z flag to interdiff will even let you feed it patches in gzip or
+bzip2 compressed form directly without the use of zcat or bzcat or manual
+uncompression.
+
+Here's how you'd go from 2.6.12.2 to 2.6.12.3 in a single step:
+	interdiff -z ../patch-2.6.12.2.bz2 ../patch-2.6.12.3.gz | patch -p1
+
+Although interdiff may save you a step or two you are generally adviced to
+do the additional steps since interdiff can get things wrong in some cases.
+
+ Another alternative is `ketchup', which is a python script for automatic
+downloading and applying of patches (http://www.selenic.com/ketchup/).
+
+
+Where can I download the patches?
+---
+The patches are available at http://kernel.org/
+Most recent patches are linked from the front page, but they also have
+specific homes.
+
+The 2.6.x.y (-stable) and 2.6.x patches live at
+ ftp://ftp.kernel.org/pub/linux/kernel/v2.6/
+
+The -rc patches live at
+ ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/
+
+The -git patches live at 
+ ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/
+
+The -mm kernels live at 
+ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
+
+In place of ftp.kernel.org you can use ftp.cc.kernel.org, where cc is a
+country code. This way you'll be downloading from a mirror site that's most
+likely geographically closer to you, resulting in faster downloads for you,
+less bandwith used globally and less load on the main kernel.org servers -
+these are good things, do use mirrors when possible.
+
+
+The 2.6.x kernels
+---
+ These are the base stable releases released by Linus. The highest numbered
+release is the most recent.
+
+If regressions or other serious flaws are found then a -stable fix patch
+will be released (see below) on top of this base. Once a new 2.6.x base
+kernel is released, a patch is made available that is a delta between the
+previous 2.6.x kernel and the new one.
+
+To apply a patch moving from 2.6.11 to 2.6.12 you'd do the following (note
+that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
+base 2.6.x kernel - if you need to move from 2.6.x.y to 2.6.x+1 you need to
+first revert the 2.6.x.y patch).
+
+Here are some examples:
+
+# moving from 2.6.11 to 2.6.12
+$ cd ~/linux-2.6.11			# change to kernel source dir
+$ patch -p1 < ../patch-2.6.12		# apply the 2.6.12 patch
+$ cd ..
+$ mv linux-2.6.11 linux-2.6.12		# rename source dir
+
+# moving from 2.6.11.1 to 2.6.12
+$ cd ~/linux-2.6.11.1			# change to kernel source dir
+$ patch -p1 -R < ../patch-2.6.11.1	# revert the 2.6.11.1 patch
+					# source dir is now 2.6.11
+$ patch -p1 < ../patch-2.6.12		# apply new 2.6.12 patch
+$ cd ..
+$ mv linux-2.6.11.1 inux-2.6.12		# rename source dir
+
+
+The 2.6.x.y kernels
+---
+ Kernels with 4 digit versions are -stable kernels. They contain small(ish)
+critical fixes for security problems or significant regressions discovered
+in a given 2.6.x kernel.
+
+This is the recommended branch for users who want the most recent stable
+kernel and are not interested in helping test development/experimental
+versions.
+
+If no 2.6.x.y kernel is available, then the highest numbered 2.6.x kernel is
+the current stable kernel.
+
+These patches are not incremental, meaning that for example the 2.6.12.3
+patch does not apply on top of the 2.6.12.2 kernel source, but rather on top
+of the base 2.6.12 kernel source.
+So, in order to apply the 2.6.12.3 patch to your existing 2.6.12.2 kernel
+source you have to first back out the 2.6.12.2 patch (so you are left with a
+base 2.6.12 kernel source) and then apply the new 2.6.12.3 patch.
+
+Here's a small example:
+
+$ cd ~/linux-2.6.12.2			# change into the kernel source dir
+$ patch -p1 -R < ../patch-2.6.12.2	# revert the 2.6.12.2 patch
+$ patch -p1 < ../patch-2.6.12.3		# apply the new 2.6.12.3 patch
+$ cd ..
+$ mv linux-2.6.12.2 linux-2.6.12.3	# rename the kernel source dir
+
+
+The -rc kernels
+---
+ These are release-candidate kernels. These are development kernels released
+by Linus whenever he deems the current git (the kernel's source management
+tool) tree to be in a reasonably sane state adequate for testing.
+
+These kernels are not stable and you should expect occasional breakage if
+you intend to run them. This is however the most stable of the main
+development branches and is also what will eventually turn into the next
+stable kernel, so it is important that it be tested by as many people as
+possible. 
+
+This is a good branch to run for people who want to help out testing
+development kernels but do not want to run some of the really experimental
+stuff (such people should see the sections about -git and -mm kernels below).
+
+The -rc patches are not incremental, they apply to a base 2.6.x kernel, just
+like the 2.6.x.y patches described above. The kernel version before the -rcN
+suffix denotes the version of the kernel that this -rc kernel will eventually
+turn into.
+So, 2.6.13-rc5 means that this is the fifth release candidate for the 2.6.13
+kernel and the patch should be applied on top of the 2.6.12 kernel source.
+
+Here are 3 examples of how to apply these patches:
+
+# first an example of moving from 2.6.12 to 2.6.13-rc3
+$ cd ~/linux-2.6.12			# change into the 2.6.12 source dir
+$ patch -p1 < ../patch-2.6.13-rc3	# apply the 2.6.13-rc3 patch
+$ cd ..
+$ mv linux-2.6.12 linux-2.6.13-rc3	# rename the source dir 
+
+# now let's move from 2.6.13-rc3 to 2.6.13-rc5
+$ cd ~/linux-2.6.13-rc3			# change into the 2.6.13-rc3 dir
+$ patch -p1 -R < ../patch-2.6.13-rc3	# revert the 2.6.13-rc3 patch
+$ patch -p1 < ../patch-2.6.13-rc5	# apply the new 2.6.13-rc5 patch
+$ cd ..
+$ mv linux-2.6.13-rc3 linux-2.6.13-rc5	# rename the source dir
+
+# finally let's try and move from 2.6.12.3 to 2.6.13-rc5
+$ cd ~/linux-2.6.12.3			# change to the kernel source dir
+$ patch -p1 -R < ../patch-2.6.12.3	# revert the 2.6.12.3 patch
+$ patch -p1 < ../patch-2.6.13-rc5	# apply new 2.6.13-rc5 patch
+$ cd ..
+$ mv linux-2.6.12.3 linux-2.6.13-rc5	# rename the kernel source dir
+
+
+The -git kernels
+---
+ These are daily snapshots of Linus' kernel tree (managed in a git
+repository, hence the name).
+
+These patches are usually released daily and represent the current state of
+Linus' tree. They are more experimental than -rc kernels since they are
+generated automatically without even a cursory glance to see if they are
+sane.
+
+-git patches are not incremental and apply either to a base 2.6.x kernel or
+a base 2.6.x-rc kernel - you can see which from their name.
+A patch named 2.6.12-git1 applies to the 2.6.12 kernel source and a patch
+named 2.6.13-rc3-git2 applies to the source of the 2.6.13-rc3 kernel.
+
+Here are some examples of how to apply these patches:
+
+# moving from 2.6.12 to 2.6.12-git1
+$ cd ~/linux-2.6.12			# change to the kernel source dir
+$ patch -p1 < ../patch-2.6.12-git1	# apply the 2.6.12-git1 patch
+$ cd ..
+$ mv linux-2.6.12 linux-2.6.12-git1	# rename the kernel source dir
+
+# moving from 2.6.12-git1 to 2.6.13-rc2-git3
+$ cd ~/linux-2.6.12-git1		# change to the kernel source dir
+$ patch -p1 -R < ../patch-2.6.12-git1	# revert the 2.6.12-git1 patch
+					# we now have a 2.6.12 kernel
+$ patch -p1 < ../patch-2.6.13-rc2	# apply the 2.6.13-rc2 patch
+					# the kernel is now 2.6.13-rc2
+$ patch -p1 < ../patch-2.6.13-rc2-git3	# apply the 2.6.13-rc2-git3 patch
+					# the kernel is now 2.6.13-rc2-git3
+$ cd ..
+$ mv linux-2.6.12-git1 linux-2.6.13-rc2-git3	# rename source dir
+
+
+The -mm kernels
+---
+ These are experimental kernels released by Andrew Morton.
+
+The -mm tree serves as a sort of proving ground for new features and other
+experimental patches.
+Once a patch has proved its worth in -mm for a while Andrew pushes it on to
+Linus for inclusion in mainline.
+
+Although it's encouraged that patches flow to Linus via the -mm tree, this
+is not always enforced.
+Subsystem maintainers (or individuals) sometimes push their patches directly
+to Linus, even though (or after) they have been merged and tested in -mm (or
+sometimes even without prior testing in -mm). 
+
+You should generally strive to get your patches into mainline via -mm to
+ensure maximum testing.
+
+This branch is in constant flux and contains many experimental features, a
+lot of debugging patches not appropriate for mainline etc and is the most
+experimental of the branches described in this document.
+
+These kernels are not appropriate for use on systems that are supposed to be
+stable and they are more risky to run than any of the other branches (make
+sure you have up-to-date backups - that goes for any experimental kernel but
+even more so for -mm kernels).
+
+These kernels in addition to all the other experimental patches they contain
+usually also contain any changes in the mainline -git kernels available at
+the time of release.
+
+Testing of -mm kernels is greatly appreciated since the whole point of the
+tree is to weed out regressions, crashes, data corruption bugs, build
+breakage (and any other bug in general) before changes are merged into the
+more stable mainline Linus tree. 
+But testers of -mm should be aware that breakage in this tree is more common
+than in any other tree.
+
+The -mm kernels are not released on a fixed schedule, but usually a few -mm
+kernels are released in between each -rc kernel (1 to 3 is common).
+The -mm kernels apply to either a base 2.6.x kernel (when no -rc kernels
+have been released yet) or to a Linus -rc kernel.
+
+Here are some examples of applying the -mm patches:
+
+# moving from 2.6.12 to 2.6.12-mm1
+$ cd ~/linux-2.6.12			# change to the 2.6.12 source dir
+$ patch -p1 < ../2.6.12-mm1		# apply the 2.6.12-mm1 patch
+$ cd ..
+$ mv linux-2.6.12 linux-2.6.12-mm1	# rename the source appropriately
+
+# moving from 2.6.12-mm1 to 2.6.13-rc3-mm3
+$ cd ~/linux-2.6.12-mm1
+$ patch -p1 -R < ../2.6.12-mm1		# revert the 2.6.12-mm1 patch
+					# we now have a 2.6.12 source
+$ patch -p1 < ../patch-2.6.13-rc3	# apply the 2.6.13-rc3 patch
+					# we now have a 2.6.13-rc3 source
+$ patch -p1 < ../2.6.13-rc3-mm3		# apply the 2.6.13-rc3-mm3 patch
+$ cd ..
+$ mv linux-2.6.12-mm1 linux-2.6.13-rc3-mm3	# rename the source dir
+
+
+This concludes this list of explanations of the various kernel trees and I
+hope you are now crystal clear on how to apply the various patches and help
+testing the kernel.
+


