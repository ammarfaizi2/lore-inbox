Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbUKUX2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUKUX2B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 18:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKUX0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:26:02 -0500
Received: from ozlabs.org ([203.10.76.45]:6337 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261844AbUKUXYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:24:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16801.9135.264043.449911@cargo.ozlabs.ibm.com>
Date: Mon, 22 Nov 2004 10:24:31 +1100
From: Paul Mackerras <paulus@samba.org>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: cachefs broken on ppc64
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

I just tried compiling 2.6.10-rc2-mm2, and just for fun, I turned on
cachefs, and found out that cachefs won't build on ppc64.  The problem
is that it is using xchg() on 16-bit quantities, which we don't
support on ppc (32 or 64).  Is there a good reason why
cachefs_super.ujnl_serial has to be 16 bits rather than 32?

It worries me a bit that you are using xchg() so much, actually.  It
feels like you are trying to be clever and do things without taking
any locks, but there are no memory barriers anywhere in fs/cachefs
that I could see.  So I suspect it would have problems on SMP ppc64 or
ia64 systems, which have weak memory consistency.  Or is there some
serialization at a higher level that saves you?  (If so, why do you
need to use xchg()?)

Paul.
