Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbUC2KuQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 05:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUC2KuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 05:50:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:48795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262797AbUC2KuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 05:50:12 -0500
Date: Mon, 29 Mar 2004 02:49:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm5
Message-Id: <20040329024959.34c9b77e.akpm@osdl.org>
In-Reply-To: <20040329113321.A23135@flint.arm.linux.org.uk>
References: <20040329014525.29a09cc6.akpm@osdl.org>
	<20040329105729.A20272@flint.arm.linux.org.uk>
	<20040329022556.255c71bb.akpm@osdl.org>
	<20040329113321.A23135@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Mon, Mar 29, 2004 at 02:25:56AM -0800, Andrew Morton wrote:
> > > and it is completely valid for ->close to be called while
> > > another thread is in ->open.  In fact, it's desirable since ->open may
> > > be waiting for the DCD line from a modem to activate, while there may
> > > be a simultaneous O_NONBLOCK open/ioctl/close from stty.
> > 
> > ->open is not called under tty_sem.  With this change, ->close is called
> > under tty_sem.
> > 
> > Are ->close implementations likely to block on hardware events?
> 
> Historically they have blocked in a well defined manner - eg when
> dropping the DTR signal for a specified minimum time period.
> 
> They can also block until the data awaiting transmission has been
> sent, which by default has a 30 second timeout, or may be configured
> to be "until sent".  Of course, if CTS is deasserted, we will wait
> until the timeout.

I suspect such drivers have always had a barndoor-sized hole in them, if
someone tries to open the thing while ->close is sleeping.

I'll take another look at the darn thing tomorrrow.

