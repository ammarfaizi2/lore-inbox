Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUAYXOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUAYXOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:14:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:65252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265336AbUAYXOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:14:46 -0500
Date: Sun, 25 Jan 2004 15:14:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc in BK: Oops loading parport_pc.
Message-Id: <20040125151454.70b5011e.akpm@osdl.org>
In-Reply-To: <20040125115129.GA10387@merlin.emma.line.org>
References: <20040125115129.GA10387@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
>
>  Loading the parport_pc modules crashes in 2.6.2-rc; I have recently done
>  a "bk pull" and enabled some PNP options, among them ISA PNP.

Often this is because some other, unrelated module left things registered
after it was removed.  Or otherwise wrecked shared data structures.

So what you ned to do is to take careful note of what other modules were
loaded and unloaded leading up to the crash, and suspect those.

There is one known problem in this area: unloading 8250_pnp will wreck the
kobject tree.  Try

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/broken-out/8250_pnp-cleanup.patch


