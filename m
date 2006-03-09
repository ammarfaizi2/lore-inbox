Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWCIHlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWCIHlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 02:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWCIHlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 02:41:12 -0500
Received: from ozlabs.org ([203.10.76.45]:20156 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750767AbWCIHlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 02:41:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.56336.993754.818818@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 18:41:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <200603082036.19811.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
	<17423.42185.78767.837295@cargo.ozlabs.ibm.com>
	<200603082036.19811.jbarnes@virtuousgeek.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes writes:

> Hm, a static checker should be able to find this stuff, shouldn't it?

Good idea.  I wonder if sparse could be extended to do it.

Alternatively, it wouldn't be hard to check dynamically.  Just have a
per-cpu count of outstanding MMIO stores.  Zero it in spin_lock and
mmiowb, increment it in write*, and grizzle if spin_unlock finds it
non-zero.  Should be very little overhead.

Paul.
