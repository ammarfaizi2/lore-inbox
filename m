Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263465AbTIBOIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 10:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTIBOIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 10:08:35 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:4362 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263465AbTIBOIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 10:08:21 -0400
Date: Tue, 2 Sep 2003 15:08:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902150808.A7388@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
	andrew.lunn@ascom.ch
References: <20030902104212.GA23978@londo.lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902104212.GA23978@londo.lunn.ch>; from andrew@lunn.ch on Tue, Sep 02, 2003 at 12:42:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 12:42:12PM +0200, Andrew Lunn wrote:
> I've attached two possible patches to the bugzilla bug. The first one
> causes the slave devices to be created in devfs at start up. The
> second one makes it work more like 2.4 when the slave device is only
> created when the master device is opened.

The first patch looks okay.

> Both patches suffer from a problem. The slave is always only RW
> root. 2.4 sets the owner of the slave to that of the process opening
> the master. I cannot see a way to make this happen with 2.6-test. 

Well, that's why we have UNIX98 ptys.  My preferred fix for this
issue would be to just axe traditional ptys, although this would probably
make it us incompatible with libc5.

Why aren't you using the new-style ptys?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 12:42:12PM +0200, Andrew Lunn wrote:
> I've attached two possible patches to the bugzilla bug. The first one
> causes the slave devices to be created in devfs at start up. The
> second one makes it work more like 2.4 when the slave device is only
> created when the master device is opened.

The first patch looks okay.

> Both patches suffer from a problem. The slave is always only RW
> root. 2.4 sets the owner of the slave to that of the process opening
> the master. I cannot see a way to make this happen with 2.6-test. 

Well, that's why we have UNIX98 ptys.  My preferred fix for this
issue would be to just axe traditional ptys, although this would probably
make it us incompatible with libc5.

Why aren't you using the new-style ptys?

