Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUBJF2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265640AbUBJF2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:28:43 -0500
Received: from gate.crashing.org ([63.228.1.57]:7568 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265639AbUBJF2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:28:41 -0500
Subject: Re: [PATCH] drivers/char/vt possible race
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040209203424.3fc85842.akpm@osdl.org>
References: <1076386813.884.11.camel@gaston>
	 <20040209203424.3fc85842.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1076390892.886.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 16:28:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-10 at 15:34, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > Hi !
> > 
> > I falled again on the crash in con_do_write() with driver->data
> > beeing NULL. It happens during boot, when userland is playing
> > open/close games with tty's, I was intentionally typing keys like
> > mad during boot trying to trigger another problem when this one
> > poped up.
> 
> OK.  Was this patch confirmed to prevent any reoccurrences?

Well, I didn't see it again, and if for some reason, we still
enter the function with tty->driver_data == NULL (which may still
happen if the tty layer itself isn't serializing, which I suspect),
we will print a warning and bail out.

In the end, I suppose the warning can be removed, but I want to
make sure that if the race still happens, we behave properly now.

The patch makes sure the vt internal state stays consistent.

> > Andrew: I suggest putting that in -mm for a while, and if it
> > doesn't trigger any new problem, upstream, maybe without my
> > 2 printk's "argh" :)
> 
> Yup.  I'll also bring back the sysfs patch which somehow triggers
> this race.

Yup, let me know.

Ben.


