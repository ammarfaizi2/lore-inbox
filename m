Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTEHPPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTEHPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:15:20 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:687 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261624AbTEHPPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:15:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Gerd Knorr <kraxel@bytesex.org>
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Date: Thu, 8 May 2003 17:23:19 +0200
User-Agent: KMail/1.5.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20030507104008$12ba@gated-at.bofh.it> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net>
In-Reply-To: <1052318339.9817.8.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="euc-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305081723.19285.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

> ioctl struct size and the ioctl number (which has the size encoded)
> should end up being different too.  Anyone aware of corner cases where
> this isn't going to work?

About half of the ioctls that need special care have fixed numbers 
instead of using _IOR() etc, see e.g. include/linux/sockios.h,
or they get the definition wrong in some way.

The way you do it in your patch could work for many cases, but it
won't be enough to eliminate HANDLE_IOCTL(), if that is desired.

Adding fops->compat_ioctl() makes it possible to eventually replace 
all HANDLE_IOCTL() and keep only COMPATIBLE_IOCTL(), which in turn
would become simpler to deal with.
If we don't add fops->compat_ioctl(), the ioctl handlers could
however look at (current_thread_info()->flags & _TIF_32BIT) to find
out if which user data structure they should expect. Is that reliable?
Do we already have a macro to do it?

	Arnd <><
