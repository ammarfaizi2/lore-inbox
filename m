Return-Path: <linux-kernel-owner+w=401wt.eu-S1763148AbWLKWEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763148AbWLKWEt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763151AbWLKWEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:04:49 -0500
Received: from ozlabs.org ([203.10.76.45]:33282 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763141AbWLKWEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:04:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17789.54777.283849.950002@cargo.ozlabs.ibm.com>
Date: Tue, 12 Dec 2006 09:04:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Olaf Hering <olaf@aepfle.de>, Herbert Poetzl <herbert@13thfloor.at>,
       Andy Whitcroft <apw@shadowen.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org>
	<20061211163333.GA17947@aepfle.de>
	<Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
	<Pine.LNX.4.64.0612110852010.12500@woody.osdl.org>
	<20061211180414.GA18833@aepfle.de>
	<20061211181813.GB18963@aepfle.de>
	<Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
	<20061211182908.GC7256@MAIL.13thfloor.at>
	<Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
	<20061211185536.GA19338@aepfle.de>
	<Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> On Mon, 11 Dec 2006, Olaf Hering wrote:
> > 
> > arch/powerpc/boot/wrapper:156:    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
> 
> This is also obviously broken (and really sad), but actually ends up being 
> better than what get_kernel_version apparently does, by at least adding 
> the requirement that the string "Linux version" be slightly more correct.
> 
> However, it's also TOTALLY BROKEN. 

It's the minimum effort for the barely acceptable outcome. :)

The wrapper script, although it currently lives in arch/powerpc/boot,
is designed and intended to be standalone, so that people can use it
outside the kernel tree, and possibly even without having the kernel
source easily to hand.  Therefore I didn't want to use any kernel
header files.

Apparently the only reason "mkimage" wants to know the kernel version
is to put it as a comment in the image, which can be displayed to the
user when booting with u-boot (the bootloader used on some embedded
platforms).  So it's not critical if the grep fails, and it's slightly
more useful to do the grep than it would be to not even try to provide
any version string to mkimage.

If there is a reliable way to get the version string, great, I'll use
that.

Paul.
