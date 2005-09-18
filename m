Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVIRVOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVIRVOe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVIRVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:14:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41414 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932205AbVIRVOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:14:33 -0400
Date: Sun, 18 Sep 2005 22:14:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <willy@w.ods.org>,
       Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918211429.GQ19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org> <20050918190714.GO19626@ftp.linux.org.uk> <1127079026.8932.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127079026.8932.13.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 10:30:26PM +0100, Alan Cox wrote:
> > It would be very useful when e.g. tracking down improper uses of
> > struct file, struct dentry, etc. - stuff that should always be
> > allocated by one helper function.  Same goes for e.g. net_device -
> 
> Another useful trick here btw is to make such objects contain (when
> debugging)
> 
> 	void *magic_ptr;
> 
> which is initialised as foo->magic_ptr = foo;
> 
> That catches anyone copying them and tells you what got copied

At runtime, _if_ we do not forget to initialize it.  Which is what
we are trying to catch...
