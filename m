Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbULMLZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbULMLZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbULMLZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:25:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:57238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262226AbULMLZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:25:49 -0500
Date: Mon, 13 Dec 2004 03:25:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: kernel@kolivas.org, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-Id: <20041213032521.702efe2f.akpm@osdl.org>
In-Reply-To: <20041213111741.GR16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random>
	<20041212163547.GB6286@elf.ucw.cz>
	<20041212222312.GN16322@dualathlon.random>
	<41BCD5F3.80401@kolivas.org>
	<20041213030237.5b6f6178.akpm@osdl.org>
	<20041213111741.GR16322@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> The patch only does HZ at dynamic time. But of course it's absolutely
>  trivial to define it at compile time, it's probably a 3 liner on top of
>  my current patch ;). However personally I don't think the three liner
>  will worth the few seconds more spent configuring the kernel ;).

We still have 1000-odd places which do things like

	schedule_timeout(HZ/10);

which will now involve a runtime divide.  The propagation of msleep() and
ssleep() will reduce that a bit, but not much.

It's so simple to turn all those into compile-time divides that we may as
well do it.
