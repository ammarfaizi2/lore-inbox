Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTAULoY>; Tue, 21 Jan 2003 06:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTAULoY>; Tue, 21 Jan 2003 06:44:24 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:50642 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267023AbTAULoX>;
	Tue, 21 Jan 2003 06:44:23 -0500
Date: Tue, 21 Jan 2003 11:53:08 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Minor header bug? MIPS (32-bit) nlink_t sign
Message-ID: <20030121115308.GA750@bjl1.asuk.net>
References: <20030118033435.GC18282@bjl1.asuk.net> <20030121160959.6e392885.sfr@canb.auug.org.au> <20030121100020.A15008@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121100020.A15008@linux-mips.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> > I assume we are being compatable with Irix? Ralf?
> 
> Dunno where the signed int for nlink_t did come from.  The original idea
> was to avoid pointless creativity and choose data types to match IRIX
> rsp. the MIPS psABI.

(I've been going through all the <asm-*/*.h> API files, and there is a
lot of duplication, with very small variations.  It was with a view to
getting rid of some of the duplication, and making it easy to see what
the _real_ differences are).

MIPS and Sparc are the only architectures that decided to be really
different to all the other Linux archs).

Anyway, I spotted another MIPS suggestion:

	asm-mips/siginfo.h:

	The comments explain that siginfo_t is IRIX compatible with
	extensions.  In fact it is not IRIX compatible, now that
	siginfo_t._sigchld has an additional _uid field in the middle
	of it.  So it's compatible for _some_ uses only.

	It's obvious that the code author knew of this change (because
	_irix_sigchld is there to document it), but didn't change the
	comment.

Suggestion:

	That comment should be removed or changed as siginfo_t
	is not IRIX compatible, at least in this part.  And maybe
	_irix_sigchld should be removed, along with the comment.

cheers,
-- Jamie
