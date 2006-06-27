Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWF0TNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWF0TNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWF0TNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:13:15 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22723 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932254AbWF0TNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:13:14 -0400
Message-ID: <44A18335.7020706@zytor.com>
Date: Tue, 27 Jun 2006 12:12:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [klibc 00/43] klibc as a historyless patchset
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <29ea762c2af4a4dc3168b6bd980bbf67@bga.com>
In-Reply-To: <29ea762c2af4a4dc3168b6bd980bbf67@bga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Miller wrote:
> As a historyless patchset, this gets the merge all wrong.
> 
> If the reason to put this in tree is to keep the kernel just working
> then there is a great big hole of 40 patches for git bisect to find.
> 
> On Jun 25, 2006, at 8:10 PM, H. Peter Anvin wrote:
> 
>> changes to the
>> main kernel code taken straight from the git history (as it is rather
>> few patches), and additions, grouped by rough divisions.
> 
> If they are in the wrong order then that is not good enough.
> The patch names and descriptions are wrong because the are from
> the klibc git tree.
> 
>> 01-add-klibckinit-to-maintainers-file.patch
>> 02-remove-root-mounting-code-from-the-kernel-.patch
>> 03-remove-parts-moved-to-kinit.patch
>> 04-support-klibcarch-being-different-from-the-main-arch.patch
> This looks to be 04-powerpc-set-klibc-arch
> 
>> 05-need-to-export-ranlib-from-the-top-makefile.patch
>> 06-re-create-root-dev-too-many-architectures-need-it-.patch
> Make the "move stuff i need" and make it first
> 
>> 07-eliminate-unnecessary-whitespace-delta-vs-linus-tree.patch
> 
> I didn't look, this corrects whitespace before patching? ok early
> 
>> 08-klibc-default-initramfs-content-stored-in-usrinitramfs-default.patch
>> 09-kbuild-support-single-targets-for-klibc-and-klibc-programs.patch
>> 10-remove-prototype-for-name-to-dev-t.patch
>> 11-enable-klibc-errlist.patch
> What does this do?  No Help, no description, and doesn't trigger
> anything in this patch.
> 
>> 12-enable-config-klibc-zlib-now-required-to-build-kinit.patch
> What does this do?  No Help, no description, and doesn't do anything
> in the curreent patch

usr/klibc/Kbuild:

libc-$(CONFIG_KLIBC_ZLIB)    += \
         zlib/adler32.o zlib/compress.o zlib/crc32.o zlib/gzio.o \
         zlib/uncompr.o zlib/deflate.o zlib/trees.o zlib/zutil.o \
         zlib/inflate.o zlib/infback.o zlib/inftrees.o zlib/inffast.o

At this point, this is required by kinit, which is why it is not 
possible to disable.

>> 13-uml-the-klibc-architecture-is-the-underlying-architecture.patch
>> 14-remove-in-kernel-nfsroot-code.patch
>> 15-default-klibcarch--arch.patch
>> 16-sparc64-transmit-arch-specific-options-to-kinit-via-arch-cmd.patch
>> 17-sparc32-transfer-arch-specific-options-to-arch-cmd.patch
>     where is x86 and x86_64 ?
>     oh you deleted and did not put that back

That's correct; I went around and talked to both x86 and sparc people, 
and the x86 people uniformly announced rdev support as being obsolete; 
the sparc people, however, continue to rely on being able to get data 
from openprom.


>> 18-klibc-inkernel-merge-s390s390x-4.patch
>     This patchname is meaningless.
>     The description in the patch is worse.
>     It looks like it should be 18-s390-set-klibcarch
> 
> Hmm... i didn't find the patch removig usr/Makefile, just adding
> usr/Kbuild.   usr/Kbuild should be a diff against the existing
> usr/Makefile, whcih can be renamed.

True.  Git could work this out.

I have been reluctant to spend too much time on packaging, because I've 
still had the issue of continue to maintain the out-of-tree distribution 
(which includes usr/Kbuild) indefinitely.  I need to spend some more 
time scripting.

	-hpa

