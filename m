Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267315AbTA1EDf>; Mon, 27 Jan 2003 23:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTA1EDe>; Mon, 27 Jan 2003 23:03:34 -0500
Received: from holomorphy.com ([66.224.33.161]:64679 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267315AbTA1EDe>;
	Mon, 27 Jan 2003 23:03:34 -0500
Date: Mon, 27 Jan 2003 20:11:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Message-ID: <20030128041142.GG780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <3.0.6.32.20030127224726.00806c20@boo.net> <20030128035736.GF780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128035736.GF780@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 07:57:36PM -0800, William Lee Irwin III wrote:
> set_num_colors() needs to go downstairs under arch/ Some of the
> current->pid checks look a bit odd esp. for GFP_ATOMIC and/or
> in_interrupt() cases. I'm not sure why this is a config option; it
> should be mandatory. I also wonder about the interaction of this with
> the per-cpu lists. This may really want to be something like a matrix
> with (cpu, color) indices to find the right list; trouble is, there's a
> high potential for many pages to be trapped there. mapnr's (page -
> zone->zone_mem_map etc.) are being used for pfn's; this may raise
> issues if zones' required alignments aren't num_colors*PAGE_SIZE or
> larger. proc_misc.c can be used instead of page_color_init(). ->free_list
> can be removed. get_rand() needs locking, per-zone state. Useful stuff.

Hmm, actually the mapnr's as physical pfn's are broken with
MAP_NR_DENSE(), though existing boxen probably luck out. The RNG uses
an integer multiply which may be slow on various cpus, and I wouldn't
mind either a stronger or better documented RNG algorithm. ->color_init
is basically a bitflag, and ->target_color has a very limited range.
sizeof(task_t) needs to be small, could you fold that stuff into
->flags or ->thread_info?

-- wli
