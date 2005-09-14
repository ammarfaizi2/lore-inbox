Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVINW0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVINW0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVINW0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:26:23 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50593
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965064AbVINW0W (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:26:22 -0400
Date: Wed, 14 Sep 2005 15:26:10 -0700 (PDT)
Message-Id: <20050914.152610.15194310.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: nickpiggin@yahoo.com.au, zippel@linux-m68k.org,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 5/5] remove HAVE_ARCH_CMPXCHG
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050914230352.G30746@flint.arm.linux.org.uk>
References: <Pine.LNX.4.61.0509141829050.3743@scrub.home>
	<432854B6.1020408@yahoo.com.au>
	<20050914230352.G30746@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Wed, 14 Sep 2005 23:03:53 +0100

> What business has userspace got of telling whether cmpxchg works on
> an architecture by looking at kernel headers?

Russell, please don't fly off the handle like this.

Nick is talking about something slightly different.

Things, for example, like DRM assume there is a cmpxchg()
they can use in the kernel and userland for interlocking.

DRM doesn't actually _check_ anything to see if this is the case, it
just so happens to only get enabled on platforms where cmpxchg() is
available in this fashion.

What Nick is suggesting is to actually move HAVE_ARCH_CMPXCHG or
something like it into the Kconfig so that things like DRM can
actually do the correct dependency check.  If you want something like
"HAVE_ARCH_CMPXCHG_WHICH_CAN_INTERFACE_WITH_USERSPACE" that DRM can
check too, all the better.

It's not about whether userspace can include some kernel header
and get cmpxchg(), it's whether there is some way that a cmpxchg()
shared semaphore between userspace and kernel is possible, which
things like DRM depend upon having available.
