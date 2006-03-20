Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWCTNtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWCTNtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWCTNtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:49:32 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:6849 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932305AbWCTNta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:49:30 -0500
Date: Mon, 20 Mar 2006 21:54:41 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/23] Adaptive read-ahead V11
Message-ID: <20060320135441.GA5360@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org
References: <20060319023413.305977000@localhost.localdomain> <9e4733910603181910p21117f3anc107673e31f6352b@mail.gmail.com> <20060319034750.GA8732@mail.ustc.edu.cn> <9e4733910603182010p394c3233p81825b093fb693c@mail.gmail.com> <20060319050956.GA4313@mail.ustc.edu.cn> <9e4733910603190753y2d36845ay8e0b08f961ade71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910603190753y2d36845ay8e0b08f961ade71@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2006 at 10:53:46AM -0500, Jon Smirl wrote:
> In another thread someone made a mention that this problem may have
> something to do with the pools of memory being used for sendfile. The
> readahead from sendfile is going into a moderately sized pool. When
> you get 100 of them going at once the other threads flush the
> readahead data out of the pool before it can be used and thus trigger
> the thrashing seek storm. Is this true, that sendfile data is read
> ahead into a fixed sized pool? If so, the readahead algorithms would

The pages are kept in a cache pool which is made of all the free memory.
E.g. the following command shows a system with 331M cache pool:

% free -m
             total       used       free     shared    buffers     cached
Mem:           488        482          5          0          7        331
-/+ buffers/cache:        142        345
Swap:          127          0        127

That would be more than enough for the stock read-ahead to handle 100
concurrent readers.

> need to reduce the sendfile window sizes to stop the pool from
> thrashing.

Sure, it is the desired behavior. This patch provides exactly this feature :)

Cheers,
Wu
