Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVAXTok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVAXTok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVAXTok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:44:40 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48401 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261603AbVAXTm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:42:28 -0500
Date: Mon, 24 Jan 2005 19:41:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "0602@eq.cz" <0602@eq.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel bug: mm/rmap.c:483
In-Reply-To: <41F4F5D4.9000502@eq.cz>
Message-ID: <Pine.LNX.4.61.0501241926300.6017@goblin.wat.veritas.com>
References: <41F4F5D4.9000502@eq.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, 0602@eq.cz wrote:
> 
> I've also experienced mentioned bug, kernel 2.6.10-ac8.
> The relevant syslog entries and .config are attached.
> I'm not subscribed, so please CC me.
> 
> Jan 23 20:01:14 kryton kernel: swap_free: Bad swap offset entry 00100000
> Jan 23 20:01:14 kryton kernel: swap_free: Bad swap offset entry 00110000
> Jan 23 20:01:14 kryton kernel: swap_free: Bad swap offset entry 00100000
> Jan 23 20:01:14 kryton kernel: kernel BUG at mm/rmap.c:483!
> Jan 23 20:02:24 kryton kernel: kernel BUG at fs/reiserfs/inode.c:357!
> Jan 23 20:11:29 kryton kernel: kernel BUG at fs/reiserfs/inode.c:357!
> Jan 23 20:25:53 kryton kernel: kernel BUG at mm/rmap.c:483!
> Jan 23 20:25:53 kryton kernel: kernel BUG at mm/rmap.c:483!
> Jan 23 20:29:15 kryton kernel: Bad page state at prep_new_page (in process 'httpd', page c1b29de0)
> Jan 23 20:29:15 kryton kernel: flags:0x40000110 mapping:00000000 mapcount:-1 count:0

I'm fairly confident that in your case, unlike Jay's,
memtest86 will soon show you're suffering from bad memory.

Those swap_free warnings suggest single-bit and double-bit memory errors;
which are likely to be responsible for all the rest of your symptoms.

It's natural that such errors will sometimes appear as swap_free warnings
and sometimes as rmap.c BUGs.  Increasingly it seems that the rmap.c BUG
is quite a good indicator of bad memory (though not necessarily so).  But
it concerns me that we don't see nearly so many swap_free warnings, which
should be nearly as common if bad memory were the sole cause.

Hugh
