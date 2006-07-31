Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWGaIC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWGaIC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWGaIC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:02:27 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:62961 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751254AbWGaIC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:02:26 -0400
From: Junio C Hamano <junkio@cox.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Linux v2.6.18-rc3
References: <Pine.LNX.4.64.0607292320490.4168@g5.osdl.org>
	<20060730083034.GA11360@flint.arm.linux.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Date: Mon, 31 Jul 2006 01:02:25 -0700
In-Reply-To: <20060730083034.GA11360@flint.arm.linux.org.uk> (Russell King's
	message of "Sun, 30 Jul 2006 09:30:34 +0100")
Message-ID: <7vzmeq8ani.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> There's something weird in this release - object
> 0021aad5db43ccc0d0356f2f5e4e28446c8b983a appears to change size (or it
> does for me.)

This is a manifestation of a recent harmless change which allows
you to change the compression level for loose objects, which
happened on July 3rd (v1.4.1-g12f6c30).  The blob is compressed
to 6891 bytes with zlib compression level of 6 (new default)
while older git used compression level of 9 (old default,
without a possibility for users to futz with it) which produces
6862 bytes.

Linus is apparently using newer git that uses the new default,
while -mmc, -rmk, and -serial trees are managed with git older
than the said version.

    commit 12f6c308d53509dcb11e309604457d21d60438db
    Author: Joachim B Haga <cjhaga@fys.uio.no>
    Date:   Mon Jul 3 22:11:47 2006 +0200

        Make zlib compression level configurable, and change default.

        With the change in default, "git add ." on kernel dir is about
        twice as fast as before, with only minimal (0.5%) change in
        object size. The speed difference is even more noticeable
        when committing large files, which is now up to 8 times faster.

        The configurability is through setting core.compression = [-1..9]
        which maps to the zlib constants; -1 is the default, 0 is no
        compression, and 1..9 are various speed/size tradeoffs, 9
        being slowest.

        Signed-off-by: Joachim B Haga (cjhaga@fys.uio.no)
        Acked-by: Linus Torvalds <torvalds@osdl.org>
        Signed-off-by: Junio C Hamano <junkio@cox.net>

As you have found out, the objects compressed differently are
fully backward compatible and there is nothing to worry about.

