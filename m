Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWIXGje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWIXGje (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 02:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbWIXGje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 02:39:34 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:57503 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1752153AbWIXGje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 02:39:34 -0400
Date: Sun, 24 Sep 2006 08:44:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060924064446.GA13320@uranus.ravnborg.org>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org> <20060923203605.GN29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923203605.GN29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 09:36:05PM +0100, Al Viro wrote:
> > A better fix would be to avoid the arch dependency in the non-arch .h
> > files so that in most cases it just works??
> 
> What "it"?  Use of vmalloc() without including vmalloc.h since on i386
> it just happens to be pulled via the
> linux/pci.h -> linux/dmapool.h -> asm-i386/io.h -> linux/vmalloc.h
> chain?
The other way around. Try to get rid of the evil includes in arch-$(ASM)
that is just sitting there for no other purpose than to let a developer skip
a single include.
In this case the right fix IMO would have been to kill the include of
linux/vmalloc.h from asm-i386/io.h and let all users that previously failed
to include vmalloc.h now do so themself.

Looking through asm-i386/io.h at fist look there is zero use of
linux/vmalloc.h so the include has no business there.

With this your patch would obviously be needed and on top of this we would
have to fix other places that 'forget' to include vmalloc.h but the good thing
would be that this is now a bit more consistent across architectures.

	Sam
