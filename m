Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWIYOkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWIYOkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWIYOkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:40:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51591 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932210AbWIYOka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:40:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060925142016.GI29920@ftp.linux.org.uk> 
References: <20060925142016.GI29920@ftp.linux.org.uk>  <1159186771.11049.63.camel@localhost.localdomain> <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> <7276.1159186684@warthog.cambridge.redhat.com> 
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 15:39:12 +0100
Message-ID: <20660.1159195152@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:

> Fine by me.  In that case we need to add
> 	depends on !FRV || BROKEN

My point is that all the numbers are invalid or incorrect.  They will cause
the arch to oops, and so need completely replacing.  So that patch you added
is incorrect and should not include asm-generic/libata-portmap.h as nothing in
there is correct on this arch.  So your patch should *not* be applied, but
should instead be replaced.

> to drivers/ata/Kconfig and be done with that.  BTW, empty libata-portmap.h
> is equivalent to absent one - it still won't build.

Why does the arch have to supply those numbers?  What's wrong with my
suggested patch?  According to code in libata, these are _legacy_ access
methods, and on FRV they aren't currently required, so why can't I dispense
with them if they're not needed?  Doing that not only skips legacy accesses
for ISA compatibility, it also reduces the code size by not actually emitting
the code for the accesses, thus making the kernel smaller...

David
