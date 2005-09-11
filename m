Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVIKXQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVIKXQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 19:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVIKXQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 19:16:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49861 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751046AbVIKXQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 19:16:03 -0400
Date: Mon, 12 Sep 2005 00:16:01 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree
Message-ID: <20050911231601.GL25261@ZenIV.linux.org.uk>
References: <20050911012033.5632152f.sfr@canb.auug.org.au> <20050910161917.GA22113@mars.ravnborg.org> <20050911023203.GH25261@ZenIV.linux.org.uk> <20050911083153.GA24176@mars.ravnborg.org> <20050911154550.GJ25261@ZenIV.linux.org.uk> <20050911170425.GA8049@mars.ravnborg.org> <20050911212942.GK25261@ZenIV.linux.org.uk> <20050911220328.GE2177@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050911220328.GE2177@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 12:03:28AM +0200, Sam Ravnborg wrote:
> If the kernel had used a scheme like the following everything could be
> solved by a few -I statements:
> 
> include/i386/asm/<what we have in include/asm-i386 today>
> include/ia64/asm/<what we have in include/asm-ia64 today>
> etc.
> 
> Then to use ia64 we would just use:
> -Iinclude/ia64

Doesn't solve the problem.  We have header pulled from include/linux/*
by asm/foo.h.  It contains generic UML stuff _and_ include of regular
asm/foo.h _of_ _the_ _subarch_.  Not a UML stuff that varies depending
on the subarch; we want whatever normal i386, amd64, etc. kernel would
get upon include of asm/foo.h.

See what I mean?  _IF_ we just wanted subarch foo.h, your scheme would
work.  If we wanted subarch-dependent header that would be pulled by
foo.h - ditto (sysdep/blah.h from foo.h).  But we can't do that when
we want #include <asm/foo.h> (from arch-independent code) pull some
UML stuff *and* asm/foo.h of subarch.

That's the problem.  Everything else is reasonably easy to deal with.
That one is not.  And yes, I know about #include_next.  I'd rather
stick to C, though, TYVM...
