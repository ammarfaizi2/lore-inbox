Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263388AbVCDXvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbVCDXvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVCDXrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:47:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:59559 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263135AbVCDWXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:23:03 -0500
Date: Fri, 4 Mar 2005 14:22:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Richard Purdie" <rpurdie@rpsys.net>
Cc: rmk+lkml@arm.linux.org.uk, davej@redhat.com, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050304142219.1e7ecfee.akpm@osdl.org>
In-Reply-To: <039001c520e0$4ea3fbe0$0f01a8c0@max>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<20050302230634.A29815@flint.arm.linux.org.uk>
	<42265023.20804@pobox.com>
	<Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org>
	<20050303002733.GH10124@redhat.com>
	<20050302203812.092f80a0.akpm@osdl.org>
	<20050304105247.B3932@flint.arm.linux.org.uk>
	<20050304032632.0a729d11.akpm@osdl.org>
	<20050304113626.E3932@flint.arm.linux.org.uk>
	<01ef01c520b7$94bebf80$0f01a8c0@max>
	<20050304132535.A9133@flint.arm.linux.org.uk>
	<039001c520e0$4ea3fbe0$0f01a8c0@max>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard Purdie" <rpurdie@rpsys.net> wrote:
>
> As an experiment I ran "bitbake meta-sdk" on my copy of openemedded. A while 
> later I have these in the deploy directory amongst other things.
> 
> http://www.rpsys.net/openzaurus/arm-cross/binutils-cross-sdk-2.15.91.0.2-r5.tar.gz 
> (3.8MB)
> http://www.rpsys.net/openzaurus/arm-cross/gcc-cross-sdk-3.4.2-r0.tar.gz 
> (17.5MB)

Bless you.  I just built an arm kernel!

That compiler is *fast*.  47 seconds.  Weird.

For reference, untar the above in / and use


#!/bin/sh
export ARCH=arm
export CROSS_COMPILE=arm-linux-
W=/usr/local/arm/oe/bin

MAKE="make"

if [ -z "$1" ]
then
	WHAT="vmlinux"
else
	WHAT="$1"
fi

nr_cpus=$(grep processor /proc/cpuinfo|wc -l)
j=$(expr $nr_cpus \* 3 / 2)

MAKE_ARGS="ARCH=$ARCH CROSS_COMPILE=$W/arm-linux-"

if [ x"$DISTCC_HOSTS" != x ]
then
	$MAKE -j 12 CC="ccache distcc --ccache-skip $W/$CROSS_COMPILE""gcc" $MAKE_ARGS $WHAT 2>/tmp/log
else
	$MAKE -j $j $MAKE_ARGS CC="$W/$CROSS_COMPILE""gcc" $WHAT 2>/tmp/log
fi
cat /tmp/log


That's now eight architectures I'll compile-test mm kernels on.
