Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTIBSSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTIBRt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:49:58 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:64269 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263891AbTIBRmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:42:43 -0400
Date: Tue, 2 Sep 2003 18:42:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902184236.A14715@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
References: <20030902104212.GA23978@londo.lunn.ch> <20030902150808.A7388@infradead.org> <20030902102141.44dc7297.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902102141.44dc7297.akpm@osdl.org>; from akpm@osdl.org on Tue, Sep 02, 2003 at 10:21:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:21:41AM -0700, Andrew Morton wrote:
> > > Both patches suffer from a problem. The slave is always only RW
> > > root. 2.4 sets the owner of the slave to that of the process opening
> > > the master. I cannot see a way to make this happen with 2.6-test. 
> > 
> > Well, that's why we have UNIX98 ptys.  My preferred fix for this
> > issue would be to just axe traditional ptys, although this would probably
> > make it us incompatible with libc5.
> 
> Unless we made an explicit decision to kill off old-style ptys (and we did
> not do that), they should continue to work as in 2.4, yes?

They work as they do in 2.4 and 2.6 (and any previous kernel) without
devfs, remember the pt_chown pain?

There's no point in emulating half of the UNIX98 pty semantics
in devfs when we have UNIX98 ptys that do it right anyway.

> IOW: we broke it.  Have you any theory as to which change caused this?

That's the magic use uid/gid of the process calling devfs_Register flag
I killed.  With a big HEADSUP and explanation on lkml..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 10:21:41AM -0700, Andrew Morton wrote:
> > > Both patches suffer from a problem. The slave is always only RW
> > > root. 2.4 sets the owner of the slave to that of the process opening
> > > the master. I cannot see a way to make this happen with 2.6-test. 
> > 
> > Well, that's why we have UNIX98 ptys.  My preferred fix for this
> > issue would be to just axe traditional ptys, although this would probably
> > make it us incompatible with libc5.
> 
> Unless we made an explicit decision to kill off old-style ptys (and we did
> not do that), they should continue to work as in 2.4, yes?

They work as they do in 2.4 and 2.6 (and any previous kernel) without
devfs, remember the pt_chown pain?

There's no point in emulating half of the UNIX98 pty semantics
in devfs when we have UNIX98 ptys that do it right anyway.

> IOW: we broke it.  Have you any theory as to which change caused this?

That's the magic use uid/gid of the process calling devfs_Register flag
I killed.  With a big HEADSUP and explanation on lkml..

