Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWF1CTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWF1CTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 22:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWF1CTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 22:19:54 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:786 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S1030337AbWF1CTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 22:19:52 -0400
In-Reply-To: <klibc.200606251757.00@tazenda.hos.anvin.org>
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
Message-Id: <29ea762c2af4a4dc3168b6bd980bbf67@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [klibc 00/43] klibc as a historyless patchset
Date: Tue, 27 Jun 2006 13:59:17 -0500
To: LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a historyless patchset, this gets the merge all wrong.

If the reason to put this in tree is to keep the kernel just working
then there is a great big hole of 40 patches for git bisect to find.

On Jun 25, 2006, at 8:10 PM, H. Peter Anvin wrote:

> changes to the
> main kernel code taken straight from the git history (as it is rather
> few patches), and additions, grouped by rough divisions.

If they are in the wrong order then that is not good enough.
The patch names and descriptions are wrong because the are from
the klibc git tree.

> 01-add-klibckinit-to-maintainers-file.patch
> 02-remove-root-mounting-code-from-the-kernel-.patch
> 03-remove-parts-moved-to-kinit.patch
> 04-support-klibcarch-being-different-from-the-main-arch.patch
This looks to be 04-powerpc-set-klibc-arch

> 05-need-to-export-ranlib-from-the-top-makefile.patch
> 06-re-create-root-dev-too-many-architectures-need-it-.patch
Make the "move stuff i need" and make it first

> 07-eliminate-unnecessary-whitespace-delta-vs-linus-tree.patch

I didn't look, this corrects whitespace before patching? ok early

> 08-klibc-default-initramfs-content-stored-in-usrinitramfs-default.patch
> 09-kbuild-support-single-targets-for-klibc-and-klibc-programs.patch
> 10-remove-prototype-for-name-to-dev-t.patch
> 11-enable-klibc-errlist.patch
What does this do?  No Help, no description, and doesn't trigger
anything in this patch.

> 12-enable-config-klibc-zlib-now-required-to-build-kinit.patch
What does this do?  No Help, no description, and doesn't do anything
in the curreent patch

> 13-uml-the-klibc-architecture-is-the-underlying-architecture.patch
> 14-remove-in-kernel-nfsroot-code.patch
> 15-default-klibcarch--arch.patch
> 16-sparc64-transmit-arch-specific-options-to-kinit-via-arch-cmd.patch
> 17-sparc32-transfer-arch-specific-options-to-arch-cmd.patch
	where is x86 and x86_64 ?
	oh you deleted and did not put that back

> 18-klibc-inkernel-merge-s390s390x-4.patch
	This patchname is meaningless.
	The description in the patch is worse.
	It looks like it should be 18-s390-set-klibcarch

Hmm... i didn't find the patch removig usr/Makefile, just adding
usr/Kbuild.   usr/Kbuild should be a diff against the existing
usr/Makefile, whcih can be renamed.

As a guess here would be my order and renames:

07-eliminate-unnecessary-whitespace-delta-vs-linus-tree.patch
	This should be making the delta the right way
06-re-create-root-dev-too-many-architectures-need-it-.patch
	nee do-mounts-is-goiing-move-root-dev
	I think initramfs.c might be a temporary home
16-sparc64-transmit-arch-specific-options-to-kinit-via-arch-cmd.patch
17-sparc32-transfer-arch-specific-options-to-arch-cmd.patch
	keep the global varables, make the arch_initcall global, and keep
	the code in x86 and x86-64 setup.c
	"export-arch-set-ramdiskflags-to-early-userspace"
08-klibc-default-initramfs-content-stored-in-usrinitramfs-default.patch

05-need-to-export-ranlib-from-the-top-makefile.patch
15-default-klibcarch--arch.patch
04-support-klibcarch-being-different-from-the-main-arch.patch
	powerpc-set-klibcarch
18-klibc-inkernel-merge-s390s390x-4.patch
	s390-set-klibcarch
13-uml-the-klibc-architecture-is-the-underlying-architecture.patch
xx-rename-usr-Makefile-usr-Kbuild	

19-klibc-basic-build-infrastructure.patch
09-kbuild-support-single-targets-for-klibc-and-klibc-programs.patch

01-add-klibckinit-to-maintainers-file.patch
20-37,39
11-enable-klibc-errlist.patch
12-enable-config-klibc-zlib-now-required-to-build-kinit.patch
40,38,41-43

02-remove-root-mounting-code-from-the-kernel-.patch
	minus the x86 setup stuff
03-remove-parts-moved-to-kinit.patch
	remove-power-disk.c-resume-parts-moved ...
10-remove-prototype-for-name-to-dev-t.patch
14-remove-in-kernel-nfsroot-code.patch

