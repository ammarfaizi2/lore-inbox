Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbTDUWN5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbTDUWN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:13:56 -0400
Received: from verein.lst.de ([212.34.181.86]:23569 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262526AbTDUWNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:13:55 -0400
Date: Tue, 22 Apr 2003 00:25:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
Message-ID: <20030422002556.A31329@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org
References: <20030421195847.A28684@lst.de> <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com> <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com> <20030421215637.A30019@lst.de> <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com> <20030421225704.A30489@lst.de> <Pine.LNX.4.55.0304211709560.2913@marabou.research.att.com> <20030421232348.A30621@lst.de> <Pine.LNX.4.55.0304211732580.3093@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211732580.3093@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 05:45:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 05:45:19PM -0400, Pavel Roskin wrote:
> On Mon, 21 Apr 2003, Christoph Hellwig wrote:
> 
> > And you are sure you have the following line in pty.c:
> >
> > 	pts_driver[i].flags |= TTY_DRIVER_NO_DEVFS;
> 
> Yes, it's in drivers/char/pty.c, line 458.
> 
> The complete diff between the clean source and my current tree is
> attached.
> 
> I have forced another rebuild, but the problem with disappearing /dev/pts
> persists.

This one ontop should really fix it...

(fingers crossed..)


--- 1.11/drivers/char/pty.c	Mon Mar 31 03:16:19 2003
+++ edited/drivers/char/pty.c	Mon Apr 21 23:02:55 2003
@@ -95,7 +95,6 @@
 			}
 		}
 #endif
-		tty_unregister_device (&tty->link->driver, minor(tty->device));
 		tty_vhangup(tty->link);
 	}
 }
