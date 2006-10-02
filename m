Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWJBUOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWJBUOB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWJBUOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:14:01 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20708
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964955AbWJBUOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:14:00 -0400
Date: Mon, 02 Oct 2006 13:14:14 -0700 (PDT)
Message-Id: <20061002.131414.74728780.davem@davemloft.net>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: linux/compat.h includes asm/signal.h causing problems
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On some platforms, including sparc64, asm/signal.h needs
compat_sigset_t, but this is defined in linux/compat.h
after asm/signal.h is included.

Andrew, aren't you doing sparc64 cross builds these days? :-)

This came from 3f2e05e90e0846c42626e3d272454f26be34a1bc

    [PATCH] BLOCK: Revert patch to hack around undeclared sigset_t in linux/compat.h
    
    Revert Andrew Morton's patch to temporarily hack around the lack of a
    declaration of sigset_t in linux/compat.h to make the block-disablement
    patches build on IA64.  This got accidentally pushed to Linus and should
    be fixed in a different manner.
    
    Also make linux/compat.h #include asm/signal.h to gain a definition of
    sigset_t so that it can externally declare sigset_from_compat().
    
    This has been compile-tested for i386, x86_64, ia64, mips, mips64, frv, ppc and
    ppc64 and run-tested on frv.
    
    Signed-off-by: David Howells <dhowells@redhat.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

It figures that one of the platforms it wasn't compile tested on is
the one that breaks :-)
