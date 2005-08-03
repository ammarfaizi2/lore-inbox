Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVHCBF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVHCBF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVHCBF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:05:57 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:17341 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261867AbVHCBFy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:05:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PuDgEeVZKJs/o3WqDzo/i9W/SkrwJ7NyfGIy1SNwP5LyH6+ud2qznBBN4XbAIqpVAJYDYb43A9kH5nJnOMwTzsvlp8d9wv5YnmmXH9lderwXoWDh0njr9QkzBaMow0zNrynC+1owQsUKVw5dNOG5E08RbWYmtYln9VFe0pQ9ed0=
Message-ID: <c25b253205080218051d5dd2e2@mail.gmail.com>
Date: Wed, 3 Aug 2005 01:05:53 +0000
From: Richard Hubbell <richard.hubbell@gmail.com>
Reply-To: Richard Hubbell <richard.hubbell@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Documentation - how to apply patches for various trees
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200508022332.21380.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508022332.21380.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you!  I agree that having a link off of kernel.org makes sense.

Richard

On 8/2/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Hi,
> 
> How to apply the -rc, -git, -mm and the 2.6.x.y (-stable) patches is a quite
> frequently asked question on LKML and elsewhere.
> Since so many people seem to be confused by this I gathered it ought to be
> properly documented once and for all so we  a) get more people testing those
> trees  and  b) get asked this question less often.
> So, I sat down and wrote such a document.
> 
> Below is a patch to add a new file "applying-patches.txt" to Documentation/
> This document describes each of the trees and gives examples on how to apply
> the various patches.
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
> --- linux-2.6.13-rc5-orig/Documentation/applying-patches.txt    1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.13-rc5/Documentation/applying-patches.txt 2005-08-02 23:17:13.000000000 +0200
> @@ -0,0 +1,221 @@
> +
> +       Applying Patches To The Linux Kernel
> +       ------------------------------------
> +
> +       (Written by Jesper Juhl, August 2005)
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
> +
> +
> +How do I apply a patch?
> +---
> + You apply a patch with the `patch' program. The patch program reads a diff
> +(or patch) file and makes the changes to the source tree described in it.
> +Patches for the Linux kernel are generated releative to the parent directory
> +holding the kernel source dir. This means that paths to files inside the
> +patch file contain the name of the kernel source dirs it was generated
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
> +Once a new 2.6.x base kernel is released, a patch is made available that is
> +a delta between the previous 2.6.x kernel and the new one.
> +To apply a patch moving from 2.6.11 to 2.6.12 you'd do the following (note
> +that such patches do *NOT* apply on top of 2.6.x.y kernels but on top of the
> +base 2.6.x kernel - if you need to move from 2.6.x.y to 2.6.x+1 you need to
> +first revert the 2.6.x.y patch).
> +
> +# moving from 2.6.11 to 2.6.12
> +$ cd ~/linux-2.6.11                    # change to kernel source dir
> +$ patch -p1 < ../patch-2.6.12          # apply the 2.6.12 patch
> +$ cd ..
> +$ mv linux-2.6.11 linux-2.6.12         # rename source dir
> +
> +# moving from 2.6.11.1 to 2.6.12
> +$ cd ~/linux-2.6.11.1                  # change to kernel source dir
> +$ patch -p1 -R < ../patch-2.6.11.1     # revert the 2.6.11.1 patch
> +                                       # source dir is now 2.6.11
> +$ patch -p1 < ../patch-2.6.12          # apply new 2.6.12 patch
> +$ cd ..
> +$ mv linux-2.6.11.1 inux-2.6.12                # rename source dir
> +
> +
> +The 2.6.x.y kernels
> +---
> + Kernels with 4 digit versions are -stable kernels. They contain small(ish)
> +critical fixes for security problems or significant regressions discovered
> +in a given 2.6.x kernel. This is the recommended branch for users who want
> +the most recent stable kernel and are not interrested in helping test
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
> +$ cd ~/linux-2.6.12.2                  # change into the kernel source dir
> +$ patch -p1 -R < ../patch-2.6.12.2     # revert the 2.6.12.2 patch
> +$ patch -p1 < ../patch-2.6.12.3                # apply the new 2.6.12.3 patch
> +$ cd ..
> +$ mv linux-2.6.12.2 linux-2.6.12.3     # rename the kernel source dir
> +
> +
> +The -rc kernels
> +---
> + These are ReleaseCandidate kernels. These are development kernels released
> +by Linus whenever he deems the current git (the kernels source management
> +tool) tree to be in a resonably sane state adequate for testing. These
> +kernels are not stable and you should expect occasional breakage if you
> +intend to run them. This is however the most stable of the main development
> +branches and is also what will eventually turn into the next stable kernel,
> +so it is important that it be tested by as many people as possible.
> +This is a good branch to run for people who want to help out testing
> +development kernel but do not want to run some of the really experimental
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
> +$ cd ~/linux-2.6.12                    # change into the 2.6.12 source dir
> +$ patch -p1 < ../patch-2.6.13-rc3      # apply the 2.6.13-rc3 patch
> +$ cd ..
> +$ mv linux-2.6.12 linux-2.6.13-rc3     # rename the source dir
> +
> +# now let's move from 2.6.13-rc3 to 2.6.13-rc5
> +$ cd ~/linux-2.6.13-rc3                        # change into the 2.6.13-rc3 dir
> +$ patch -p1 -R < ../patch-2.6.13-rc3   # revert the 2.6.13-rc3 patch
> +$ patch -p1 < ../patch-2.6.13-rc5      # apply the new 2.6.13-rc5 patch
> +$ cd ..
> +$ mv linux-2.6.13-rc3 linux-2.6.13-rc5 # rename the source dir
> +
> +# finally let's try and move from 2.6.12.3 to 2.6.13-rc5
> +$ cd ~/linux-2.6.12.3                  # change to the kernel source dir
> +$ patch -p1 -R < ../patch-2.6.12.3     # revert the 2.6.12.3 patch
> +$ patch -p1 < ../patch-2.6.13-rc5      # apply new 2.6.13-rc5 patch
> +$ cd ..
> +$ mv linux-2.6.12.3 linux-2.6.13-rc5   # rename the kernel source dir
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
> +2.6.x kernel or a base 2.6.x-rc kernel - you can see which from their name,
> +a patch named 2.6.12-git1 applies to the 2.6.12 kernel source and a patch
> +named 2.6.13-rc3-git2 applies to the source of the 2.6.13-rc3 kernel.
> +Here are some examples of how to apply these patches
> +
> +# moving from 2.6.12 to 2.6.12-git1
> +$ cd ~/linux-2.6.12                    # change to the kernel source dir
> +$ patch -p1 < ../patch-2.6.12-git1     # apply the 2.6.12-git1 patch
> +$ cd ..
> +$ mv linux-2.6.12 linux-2.6.12-git1    # rename the kernel source dir
> +
> +# moving from 2.6.12-git1 to 2.6.13-rc2-git3
> +$ cd ~/linux-2.6.12-git1               # change to the kernel source dir
> +$ patch -p1 -R < ../patch-2.6.12-git1  # revert the 2.6.12-git1 patch
> +                                       # we now have a 2.6.12 kernel
> +$ patch -p1 < ../patch-2.6.13-rc2      # apply the 2.6.13-rc2 patch
> +                                       # the kernel is now 2.6.13-rc2
> +$ patch -p1 < ../patch-2.6.13-rc2-git3 # apply the 2.6.13-rc2-git3 patch
> +                                       # the kernel is now 2.6.13-rc2-git3
> +$ cd ..
> +$ mv linux-2.6.12-git1 linux-2.6.13-rc2-git3   # rename source dir
> +
> +
> +The -mm kernels
> +---
> + These are experimental kernels released by Andrew Morton. The -mm tree
> +serves as a sort of proving ground for new features and other experimental
> +patches. Once a patch has proved its worth in -mm for a while Andrew pushes
> +it on to Linus for inclusion in mainline. This branch is in constant flux
> +and contains many experimental features, a lot of debugging patches not
> +appropriate for mainline etc and is the most experimental of the branches
> +described in this document. These kernels are not appropriate for use on
> +systems that are supposed to be stable and they a more risky to run than any
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
> +been released yet) or to a Linus -rc kernel.
> +Here are some examples of applying the -mm patches
> +
> +# moving from 2.6.12 to 2.6.12-mm1
> +$ cd ~/linux-2.6.12                    # change to the 2.6.12 source dir
> +$ patch -p1 < ../2.6.12-mm1            # apply the 2.6.12-mm1 patch
> +$ cd ..
> +$ mv linux-2.6.12 linux-2.6.12-mm1     # rename the source appropriately
> +
> +# moving from 2.6.12-mm1 to 2.6.13-rc3-mm3
> +$ cd ~/linux-2.6.12-mm1
> +$ patch -p1 -R < ../2.6.12-mm1         # revert the 2.6.12-mm1 patch
> +                                       # we now have a 2.6.12 source
> +$ patch -p1 < ../patch-2.6.13-rc3      # apply the 2.6.13-rc3 patch
> +                                       # we now have a 2.6.13-rc3 source
> +$ patch -p1 < ../2.6.13-rc3-mm3                # apply the 2.6.13-rc3-mm3 patch
> +$ cd ..
> +$ mv linux-2.6.12-mm1 linux-2.6.13-rc3-mm3     # rename the source dir
> +
> +
> +This concludes this list of explanations of the various kernel trees and I
> +hope you are now crystal clear on how to apply the various patches and help
> +testing the kernel.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
