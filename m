Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbUK0D4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUK0D4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUK0D4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:56:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53187 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262484AbUKZTcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:32:48 -0500
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, matthew@wil.cx, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 25 Nov 2004 16:20:06 -0200
In-Reply-To: <19865.1101395592@redhat.com>
Message-ID: <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25, 2004, David Howells <dhowells@redhat.com> wrote:

> 	SOURCE			INSTALLED AS
> 	======================	============
> 	include/user/		/usr/include/user/
> 	include/user-i386/	/usr/include/user-i386/
> 				/usr/include/linux -> user
> 				/usr/include/asm -> user-i386

Although user/ and user-* make a lot of sense within the kernel source
tree, I don't think these names would be very clear in /usr/include.
I'd rather use names in /usr/include that more clearly associate them
with the kernel.  Heck, even /usr/include/asm is inappropriate, but
it's been there for so long that we really shouldn't try to get rid of
it.

If I had it my way, we'd have, in the kernel tree, userland-aimed
headers in include/linux/user and include/asm-<machine>/user, and have
them installed in /usr/include/linux and /usr/include/asm-<machine>.

This means these headers shouldn't reference each other as
linux/user/something.h, but rather as linux/something.h, such that
they still work when installed in /usr/include/linux.  This may
require headers include/linux/something.h to include
linux/user/something.h, but that's already part of the proposal.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
