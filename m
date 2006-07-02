Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWGBXym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWGBXym (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGBXym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:54:42 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:24554 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750764AbWGBXym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:54:42 -0400
Message-ID: <351884479.18942@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Mon, 3 Jul 2006 07:55:16 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New readahead - ups and downs
Message-ID: <20060702235516.GA6034@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44A12D84.5010400@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A12D84.5010400@aitel.hist.no>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Tue, Jun 27, 2006 at 03:07:16PM +0200, Helge Hafting wrote:
> I made my own little io-intensive test, that shows a case where
> performance drops.
> 
> I boot the machine, and starts "debsums", a debian utility that
> checksums every file managed by debian package management.
> As soon as the machine starts swapping, I also start
> start a process that applies an mm-patch to the kernel tree, and
> times this.
> 
> This patching took 1m28s with cold cache, without debsums running.
> With the 2.6.15 kernel (old readahead), and debsums running, this
> took 2m20s to complete, and 360kB in swap at the worst.
> 
> With the new readahead in 2.6.17-mm3 I get 6m22s for patching,
> and 22MB in swap at the most.  Runs with mm1 and mm2 were
> similiar, 5-6 minutes patching and 22MB swap.
> 
> My patching clearly takes more times this way.  I don't know
> if debsums improved though, it could be as simple as a fairness
> issue.  Memory pressure definitely went up.

There are a lot changes between 2.6.15 and 2.6.17-mmX. Would you use
the single 2.6.17-mm5 kernel for benchmarking? It's easy:

        - select old readahead:
                echo 1 > /proc/sys/vm/readahead_ratio

        - select new readahead:
                echo 50 > /proc/sys/vm/readahead_ratio


Thanks,
Wu
