Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWDDDl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWDDDl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 23:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWDDDl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 23:41:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964995AbWDDDl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 23:41:57 -0400
Date: Mon, 3 Apr 2006 20:40:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel-news@e-dict.net
Cc: Ingo.Freund@e-dict.net, linux-kernel@vger.kernel.org
Subject: Re: out of memory
Message-Id: <20060403204048.092db2cc.akpm@osdl.org>
In-Reply-To: <4431001C.5080905@e-dict.net>
References: <4431001C.5080905@e-dict.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Freund <Ingo.Freund@e-dict.net> wrote:
>
> Hi,
> 
> on our database machine with 4 GB RAM and 2 XEON CPUs I got the
> following kernel messages.
> There are 2 GB RAM declared as shared memory for database usage.
> Can anybody explain to me what happened and -may be- why?
> 

You have a kernel memory leak.

> 
> Apr  2 10:55:09 widbrz01 kernel: oom-killer: gfp_mask=0xd0, order=0

It was a GFP_KERNEL allocation.

> Apr  2 10:56:10 dbm kernel: Normal free:3168kB min:3756kB low:4692kB high:5632kB active:700kB inactive:548kB present:901120kB

There's a grand total of 1.2MB of ZONE_NORMAL memory on the LRU.  The rest
(900MB-odd) is lost.

> Apr  2 10:56:11 dbm kernel: 8538 pages slab

and it's not in slab.

> Apr  2 10:56:11 dbm kernel: Symbols match kernel version 2.6.13.

Boy, 2.6.13 was a long time ago - I'm sure we fixed many leaks since then,
but I do not recall any particular patch which might fix this, sorry.

Your best option would be to seek a kernel upgrade.
