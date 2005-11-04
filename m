Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932736AbVKDNB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbVKDNB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVKDNB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:01:58 -0500
Received: from [81.2.110.250] ([81.2.110.250]:63626 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932736AbVKDNB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:01:58 -0500
Subject: Re: tty locking again :)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1131087820.4680.248.camel@gaston>
References: <1131087820.4680.248.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Nov 2005 13:32:04 +0000
Message-Id: <1131111124.26925.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-04 at 18:03 +1100, Benjamin Herrenschmidt wrote:
> I noticed that there doesn't seem to be any kind of locking in
> tty_(un)register_driver. It can very easily race with tty_open() doing a
> get_tty_driver(). Shouldn't tty_(un)register_driver be changed to take
> the tty_sem at least while manipulating the list ?

Its totally racy. Its on the todo list but I'm waiting for the buffering
changes to get into the Linus kernel and tested before doing the next
chunk of work on it (firstly fixing the rx/tx locking, then removing
TTY_DONT_FLIP which is a precursor to sanity for polled serial devices
and DMA)

> I noticed that while chasing a different bug (a driver bug actually),
> but I don't see how we are protected here. And considering the race I
> found in the driver, I tend to think we aren't protected at all

It all needs considerable work. Fixing the receive/transmit locking is
IMHO by far the most important however now the buffers are done.

Alan

