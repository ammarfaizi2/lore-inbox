Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTLUA7n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 19:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTLUA7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 19:59:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:29104 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261928AbTLUA7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 19:59:42 -0500
Date: Sat, 20 Dec 2003 17:00:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, mbligh@us.ibm.com
Subject: Re: [PATCH] make try_to_free_pages walk zonelist
Message-Id: <20031220170042.3feb6aa7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.55L.0312201928530.31547@imladris.surriel.com>
References: <Pine.LNX.4.55L.0312201928530.31547@imladris.surriel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@surriel.com> wrote:
>
> In 2.6.0 both __alloc_pages() and the corresponding
>  wakeup_kswapd()s walk all zones in the zone list,
>  possibly spanning multiple nodes in a low numa factor
>  system like AMD64.
> 
>  Also, if lower_zone_protection is set in /proc, then
>  it may be possible that kswapd never cleans out data
>  in zones further down the zonelist and try_to_free_pages
>  needs to do that.
> 
>  However, in 2.6.0 try_to_free_pages() only frees pages
>  in the pgdat the first zone in the zonelist belongs to.
> 
>  This is probably the wrong behaviour, since both the
>  page allocator and the kswapd wakeup free things from
>  all zones on the zonelist.  The following patch makes
>  try_to_free_pages() consistent with the allocator, by
>  passing the zonelist as an argument and freeing pages
>  from all zones in the list.

hm, OK, so this should be a no-op for non-NUMA setups.

Prior to merging such a change it would be nice to have confirmed
before-and-after testing on real NUMA hardware.  Rather than saying "gee,
this should help", but never knowing how much it really did help.

Could you suggest a suitable worklaod for Andi and Martin to test sometime?

Meanwhile, I'll mmify it for a bit of soak testing, thanks.
