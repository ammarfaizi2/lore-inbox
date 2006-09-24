Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWIXVfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWIXVfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWIXVfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:35:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44173 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932166AbWIXVfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:35:11 -0400
Date: Sun, 24 Sep 2006 22:35:08 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060924213508.GR29920@ftp.linux.org.uk>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org> <20060923203605.GN29920@ftp.linux.org.uk> <20060924064446.GA13320@uranus.ravnborg.org> <20060924191917.GQ29920@ftp.linux.org.uk> <20060924205244.GA26774@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924205244.GA26774@uranus.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 10:52:44PM +0200, Sam Ravnborg wrote:
> The only thing I like to see is minimal suprise. And minimal suprise in
> this case is to be considered as "works on almost all archs if not all".
> In practical terms it could be that users of asm/* had to include
> baz.h before bar.h.

Even though dependency on baz.h is due to implementation of one of the
helpers in bar.h on a few targets and makes no sense whatsoever for
everything else?

> Or we could stick to current mess where one has
> to have a shitload of crosscompiles and CPU power to check even trivial
> changes to a few include files.

We _are_ stuck with it.

> Partly this could be fixed by making header files in asm-$(ARCH)
> second class citizen - that always got included via their linux/
> counterpart.

Which only makes dependency graph fatter...  What's the difference
between including asm/uaccess.h and linux/uaccess.h?

Basically, you pull tons of includes into linux/blah.h because it
happens to include asm/foo.h and _that_ depends on having linux/barf.h
for $WEIRD_TARGET.  And guess what?  You are back to the same cross-compiles,
since attempt to remove blah.h -> barf.h will break $WEIRD_TARGET, but
you won't notice that unless you cross-compile for it.

So all you get is a bunch of harder to explain includes between linux/*.h,
_and_ extra dependencies that make no sense whatsoever.
