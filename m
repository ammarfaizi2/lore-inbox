Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUARGlS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 01:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUARGlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 01:41:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:13547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265750AbUARGlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 01:41:17 -0500
Date: Sat, 17 Jan 2004 22:41:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] kill sleep_on
Message-Id: <20040117224139.5585fb9c.akpm@osdl.org>
In-Reply-To: <1074383111.9965.4.camel@imladris.demon.co.uk>
References: <40098251.2040009@colorfullife.com>
	<1074367701.9965.2.camel@imladris.demon.co.uk>
	<20040117201000.GL21151@parcelfarce.linux.theplanet.co.uk>
	<1074383111.9965.4.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Sat, 2004-01-17 at 20:10 +0000,
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> > AFAICS, _all_ uses of sleep_on() in drivers are broken in one way or another
> > and BKL won't help them.
> 
> I think ext3 and nfs get away with it at the moment by using the BKL. It
> does want fixing though.

ext3 had all its sleep_on()s and lock_kernel()s eradicated ages ago.  In
2.4 it uses sleep_on()s and lock_kernel() makes that safe.

It would be nice to fix up the lock_kernel()s in the NFS client: SMP lock
contention is quite high in there.

