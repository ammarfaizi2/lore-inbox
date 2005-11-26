Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVKZN7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVKZN7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 08:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbVKZN7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 08:59:40 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:57517 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750842AbVKZN7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 08:59:40 -0500
Date: Sat, 26 Nov 2005 22:11:28 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 00/19] Adaptive read-ahead V8
Message-ID: <20051126141128.GA4515@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20051125151210.993109000@localhost.localdomain> <20051125164317.c42c0639.diegocg@gmail.com> <20051126031755.GA7226@mail.ustc.edu.cn> <20051126132524.GA12396@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126132524.GA12396@irc.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 02:25:24PM +0100, Tomasz Torcz wrote:
> > It's interesting ;)
> > In fact some distributions do have a read-ahead script to preload files on
> > startup. The readahead system call should be enough for this purpose:
> > 
> > NAME
> >        readahead - perform file readahead into page cache
> 
> posix_fadvise() with        POSIX_FADV_WILLNEED hint?
>               The specified data will be accessed in the near future.

Nod, this one is better.
They do roughly the same thing, while the latter interface is more portable.

Another note: if you do not know precisely which files to readahead, turn on
aggressive readahead feature temporary might help. There are mainly three
parameters that controls the aggressiveness, the following example values should
be large enough:

echo 16 > /proc/sys/vm/readahead_hit_rate   # overlook hit rate?
echo 1000 > /proc/sys/vm/readahead_ratio    # grow up ra-size quickly?
blockdev --setra 8192 /dev/had              # large ra-size limit?

Thanks,
Wu
