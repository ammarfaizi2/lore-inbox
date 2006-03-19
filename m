Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWCSCUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWCSCUL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWCSCUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:20:11 -0500
Received: from thunk.org ([69.25.196.29]:21690 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751262AbWCSCUK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:20:10 -0500
Date: Sat, 18 Mar 2006 21:20:02 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060319022002.GA19607@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Takashi Sato <sho@tnes.nec.co.jp>, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000301c6482d$7e5b5200$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 09:39:20PM +0900, Takashi Sato wrote:
>  - Modify to call C functions(ext2fs_set_bit(),ext2fs_test_bit())
>    defined in lib/ex2fs/bitops.c on x86 and mc68000 architecture.

I just did some quick tests, and using the C functions instead of the
asm instructions increases the CPU user time by 7.8% on a test
filesystem, and increased the wall clock time of the e2fsck regression
test suite by 4.5%.  That's not huge, and the test suite was cached so
the percentage difference will probably be less in real-life
situation, but I'd still like to avoid it if I can.

I've just checked my i386 assembly language reference, and I don't see
any indication that the btsl, btrl, and btl instructions don't work if
the high bit is set on the bit number.  Have you done tests showing
that these instructions do not work correctly for filesystem sizes >
2**31 blocks, or have references showing that these instructions
interpret the bit number as a signed integer?

Thanks regards,

						- Ted
