Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbUBQEMP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265955AbUBQEMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:12:15 -0500
Received: from dp.samba.org ([66.70.73.150]:49855 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265954AbUBQEMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:12:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16433.38038.881005.468116@samba.org>
Date: Tue, 17 Feb 2004 15:12:06 +1100
To: linux-kernel@vger.kernel.org
Subject: UTF-8 and case-insensitivity
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given how much pain the "kernel is agnostic to charset encoding"
attitude has cost me in terms of programming pain, I thought I should
de-cloak from lurk mode and put my 2c into the UTF-8 issue.

Personally I think that eventually the Linux kernel will have to
embrace the interpretation of the byte streams that applications have
given it, despite the fact that this will be very painful and
potentially quite complex. The reason is that I think that eventually
the Linux kernel will need to efficiently support a userspace policy
of case-insensitivity and the only way to do case-insensitive filename
operations is to interpret those byte streams as a particular
encoding.

Personally I much prefer the systems I use to be case-sensitive, but
there are important applications that require case-insensitivity for
interoperability. Right now it is not possible to write a case
insensitive application on Linux in an efficient manner. With the
current "encoding agnostic" APIs a simple open() or stat() call
becomes a horrendously expensive operation and one that is fraught
with race conditions. Providing the same functionality in the kernel
is dirt cheap by comparison (not cheap in terms of code complexity,
but cheap in terms of runtime efficiency).

Cheers, Tridge
