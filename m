Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbVCERz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbVCERz4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbVCERzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:55:55 -0500
Received: from tim.rpsys.net ([194.106.48.114]:37346 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261688AbVCERt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:49:57 -0500
Message-ID: <02c101c521ab$bd4e0ba0$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Jan Dittmer" <jdittmer@ppp0.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "David Greaves" <david@dgreaves.com>
References: <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max> <20050304132535.A9133@flint.arm.linux.org.uk> <039001c520e0$4ea3fbe0$0f01a8c0@max> <20050304181110.A16178@flint.arm.linux.org.uk>
Subject: Re: RFD: Kernel release numbering
Date: Sat, 5 Mar 2005 17:49:44 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King:
> Two things - are you sure that openembedded contains the patches to
> fix the two biggest binutils issues we have, as documented on
> http://www.arm.linux.org.uk/developer/toolchain/ ?

I've checked and it contains the tc-arm.c.patch but does not have the ARM
mapping symbols fix. As recent kernels have fixes for that, its not so much
of a problem as it was however it should be staightforward to add into oe
and I will aim to do that.

> Secondly, are you seriously suggesting people like Jan Dittmer, who
> provide a cross-architecture service should jump through some loops
> just to get a working toolchain for the ARM architecture?

You said nobody was willing/interested in maintaining a toolchain. I'm
saying that a toolchain is maintained within openembedded and that pointing
people at that is better than nothing. Maintaining a set of patches to
ensure bugs in binutils etc are fixed is easy within oe's framework. (To add
the above patch, in theory I just need to add a line to a file).

Jan Dittmer:
> As long it is documented and it _works_ that's no problem. But it was
> quite a hassle to get working cross-compilers for all 23 archs
> to build, because for some there is no real documentation which
> target is the correct one and upstream gcc and/or binutils sometimes
> don't compile.

This is why openembedded exists - it tracks known working build
configurations of every bit of software needed to make complete linux
distributions.

> How much work is it to set-up an openembedded environment anyways?

I've written a quick and dirty set of instructions on setting up
openembedded below. Please note that oe is used for building complete linux
distributions so there is a lot of functionality being unused here (as you
can imagine from my statement above). bitbake is a known memory hog (it can
use up to 1GB of ram) - we all know this is appalling and a rewrite to
address this is in progress.

cd /work/
svn co svn://svn.berlios.de/bitbake/trunk/bitbake
export PATH=/work/bitbake/bin:$PATH

bk clone bk://openembedded.bkbits.net/openembeded
export BBPATH=/work/build:/work/openembedded

mkdir build
mkdir build/conf/
cp openembedded/conf/local.conf.sample build/conf/local.conf

Edit local.conf as appropriate. local.conf.sample has details about what
the variables do. My local.conf to generate the arm toolchain has:

DL_DIR="/work/sources"
BBFILES="/work/openembedded/packages/*/*.bb"
TARGET_ARCH="arm"
TARGET_OS="linux"
INHERIT="package_tar"

(everything else is left unchanged)

cd build
bitbake binutils-cross-sdk
bitbake gcc-cross-sdk

Output ends up in /work/build/tmp/deploy

Richard

