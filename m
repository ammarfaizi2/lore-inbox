Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUJPFzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUJPFzI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 01:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUJPFzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 01:55:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:49365 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268609AbUJPFzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 01:55:04 -0400
Date: Fri, 15 Oct 2004 22:53:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nigel Kukard <nkukard@lbsd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-bk2 bug report
Message-Id: <20041015225306.10bbbc69.akpm@osdl.org>
In-Reply-To: <416FD24C.7020007@lbsd.net>
References: <416FD24C.7020007@lbsd.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Kukard <nkukard@lbsd.net> wrote:
>
> While booting with 2.6.9rc4-bk2 I seem to get the below OOPS, I copied 
>  the modules & System.map file over to another box of mine where i used 
>  serial-console to grab the oops.
> 
>  Anyone know what I can try to debug the below problem?

Something appears to have wrecked the system-wide timer queue. 
Possibilties are that some kernel module was unloaded but forgot to remove
a pending timer, or some data structure was freed while holding a pending
timer.

You could try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC, but I
doubt if those would shed much light.

I'd suggest that you strip your .config down to the bare minimum which is
needed to boot and see if the crash goes away.  If it does, then it's just
a matter of reintroducing .config options until you find which one caused
the crash.  Code inspection should then lead us to the bug.
