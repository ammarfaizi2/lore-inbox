Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268273AbUIKSZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268273AbUIKSZQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268275AbUIKSZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:25:16 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:118 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268273AbUIKSZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:25:11 -0400
Date: Sat, 11 Sep 2004 20:25:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-rc1-bk16] ppc32: Use $(addprefix ...) on arch/ppc/boot/lib/
Message-ID: <20040911182524.GA8380@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040909153031.GA2945@smtp.west.cox.net> <20040909163705.GA7830@mars.ravnborg.org> <20040911162946.GB11438@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911162946.GB11438@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 09:29:46AM -0700, Tom Rini wrote:
 
> How hard would it be make some sort of synchronisation point?  I know
> SuSE folks who always build with -j5.
This particular usage in ppc has vmlinux is synchronisation point - this
way it is guaranteed that lib/zlib_inflate/ is not visited twice
concurrently.

So this will not break SuSE "make -j 5" builds.
And current kernel compile fine with make -j 32 (only report the last
couple of months was me re-introducing a warning - already fixed).

Only issue seems to be file-stamps with no more than one second
resolution - this may result in rebuild in second run - because
some .o have equal timestamps.

	Sam
