Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbTIBRwh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTIBRuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:50:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:40843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263848AbTIBRif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:38:35 -0400
Date: Tue, 2 Sep 2003 10:21:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-Id: <20030902102141.44dc7297.akpm@osdl.org>
In-Reply-To: <20030902150808.A7388@infradead.org>
References: <20030902104212.GA23978@londo.lunn.ch>
	<20030902150808.A7388@infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Sep 02, 2003 at 12:42:12PM +0200, Andrew Lunn wrote:
> > I've attached two possible patches to the bugzilla bug. The first one
> > causes the slave devices to be created in devfs at start up. The
> > second one makes it work more like 2.4 when the slave device is only
> > created when the master device is opened.
> 
> The first patch looks okay.

But what about this:

> > Both patches suffer from a problem. The slave is always only RW
> > root. 2.4 sets the owner of the slave to that of the process opening
> > the master. I cannot see a way to make this happen with 2.6-test. 
> 
> Well, that's why we have UNIX98 ptys.  My preferred fix for this
> issue would be to just axe traditional ptys, although this would probably
> make it us incompatible with libc5.

Unless we made an explicit decision to kill off old-style ptys (and we did
not do that), they should continue to work as in 2.4, yes?

IOW: we broke it.  Have you any theory as to which change caused this?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Sep 02, 2003 at 12:42:12PM +0200, Andrew Lunn wrote:
> > I've attached two possible patches to the bugzilla bug. The first one
> > causes the slave devices to be created in devfs at start up. The
> > second one makes it work more like 2.4 when the slave device is only
> > created when the master device is opened.
> 
> The first patch looks okay.

But what about this:

> > Both patches suffer from a problem. The slave is always only RW
> > root. 2.4 sets the owner of the slave to that of the process opening
> > the master. I cannot see a way to make this happen with 2.6-test. 
> 
> Well, that's why we have UNIX98 ptys.  My preferred fix for this
> issue would be to just axe traditional ptys, although this would probably
> make it us incompatible with libc5.

Unless we made an explicit decision to kill off old-style ptys (and we did
not do that), they should continue to work as in 2.4, yes?

IOW: we broke it.  Have you any theory as to which change caused this?

