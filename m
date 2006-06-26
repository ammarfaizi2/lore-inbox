Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbWFZBwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWFZBwu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965215AbWFZBwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:52:49 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39585 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965195AbWFZBwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:52:49 -0400
Message-ID: <351286764.22182@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 26 Jun 2006 09:52:56 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Adaptive readahead updates 3
Message-ID: <20060626015256.GA6120@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060625130704.464870100@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060625130704.464870100@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Sun, Jun 25, 2006 at 09:07:04PM +0800, Wu Fengguang wrote:
> Most patches here are focused on seperating out readahead overheads.

Here are some notes that I forgot to include in the mail:

The three patches:
        [PATCH 3/6] readahead: kconfig option READAHEAD_ALLOW_OVERHEADS
        [PATCH 4/6] readahead: kconfig option READAHEAD_SMOOTH_AGING
        [PATCH 5/6] readahead: kconfig option READAHEAD_HIT_FEEDBACK

make the menuconfig look like this:
        [*] Adaptive file readahead (EXPERIMENTAL)
        [*]   Allow extra features with overheads
        [*]     Readahead debug and accounting (NEW)
        [*]     Readahead hit feedback (NEW)
        [ ]     Fine grained readahead aging (NEW)

With all of the three new options disabled(the defaults), it becomes comparable
to the stock readahead in efficiency when reading big files:

Summary:
                      user       sys       cpu         total
ARA     avg           0.13       5.42      91.62%      6.02 
STOCK   avg           0.13       5.47      91.64%      6.09

Details:

ARA
cp work/sparse /dev/null  0.13s user 5.44s system 92% cpu 5.987 total
cp work/sparse /dev/null  0.11s user 5.42s system 91% cpu 6.028 total
cp work/sparse /dev/null  0.14s user 5.47s system 92% cpu 6.087 total
cp work/sparse /dev/null  0.13s user 5.46s system 91% cpu 6.087 total
cp work/sparse /dev/null  0.13s user 5.45s system 91% cpu 6.070 total
cp work/sparse /dev/null  0.13s user 5.41s system 92% cpu 6.003 total
cp work/sparse /dev/null  0.13s user 5.42s system 91% cpu 6.036 total
cp work/sparse /dev/null  0.13s user 5.36s system 91% cpu 6.003 total
cp work/sparse /dev/null  0.14s user 5.39s system 92% cpu 6.003 total
cp work/sparse /dev/null  0.14s user 5.42s system 92% cpu 6.028 total
cp work/sparse /dev/null  0.12s user 5.36s system 92% cpu 5.937 total
cp work/sparse /dev/null  0.12s user 5.36s system 92% cpu 5.961 total
cp work/sparse /dev/null  0.13s user 5.47s system 92% cpu 6.062 total

STOCK
cp work/sparse /dev/null  0.13s user 5.49s system 92% cpu 6.068 total
cp work/sparse /dev/null  0.15s user 5.38s system 92% cpu 6.012 total
cp work/sparse /dev/null  0.12s user 5.49s system 91% cpu 6.112 total
cp work/sparse /dev/null  0.12s user 5.52s system 92% cpu 6.103 total
cp work/sparse /dev/null  0.13s user 5.57s system 91% cpu 6.203 total
cp work/sparse /dev/null  0.11s user 5.45s system 92% cpu 6.037 total
cp work/sparse /dev/null  0.13s user 5.52s system 92% cpu 6.120 total
cp work/sparse /dev/null  0.14s user 5.43s system 91% cpu 6.070 total
cp work/sparse /dev/null  0.12s user 5.49s system 92% cpu 6.078 total
cp work/sparse /dev/null  0.13s user 5.51s system 92% cpu 6.128 total
cp work/sparse /dev/null  0.13s user 5.45s system 92% cpu 6.061 total
cp work/sparse /dev/null  0.15s user 5.40s system 91% cpu 6.037 total
cp work/sparse /dev/null  0.14s user 5.49s system 92% cpu 6.086 total
cp work/sparse /dev/null  0.13s user 5.46s system 91% cpu 6.106 total

Thanks,
Wu
