Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267308AbTA1Dtg>; Mon, 27 Jan 2003 22:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTA1Dtg>; Mon, 27 Jan 2003 22:49:36 -0500
Received: from holomorphy.com ([66.224.33.161]:61863 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267308AbTA1Dtf>;
	Mon, 27 Jan 2003 22:49:35 -0500
Date: Mon, 27 Jan 2003 19:57:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jason Papadopoulos <jasonp@boo.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Message-ID: <20030128035736.GF780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <3.0.6.32.20030127224726.00806c20@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.6.32.20030127224726.00806c20@boo.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 10:47:26PM -0500, Jason Papadopoulos wrote:
> This is yet another holding action, a port of my page coloring patch
> to the 2.5 kernel. This is a minimal port (x86 only) intended to get
> some testing done; once again the algorithm used is the same as in 
> previous patches. There are several cleanups and removed 2.4-isms that
> make the code somewhat more compact, though.
> I'll be experimenting with other coloring schemes later this week.
> www.boo.net/~jasonp/page_color-2.5.59-20030127.patch
> Feedback of any sort welcome.

set_num_colors() needs to go downstairs under arch/ Some of the
current->pid checks look a bit odd esp. for GFP_ATOMIC and/or
in_interrupt() cases. I'm not sure why this is a config option; it
should be mandatory. I also wonder about the interaction of this with
the per-cpu lists. This may really want to be something like a matrix
with (cpu, color) indices to find the right list; trouble is, there's a
high potential for many pages to be trapped there. mapnr's (page -
zone->zone_mem_map etc.) are being used for pfn's; this may raise
issues if zones' required alignments aren't num_colors*PAGE_SIZE or
larger. proc_misc.c can be used instead of page_color_init(). ->free_list
can be removed. get_rand() needs locking, per-zone state. Useful stuff.

--wli
