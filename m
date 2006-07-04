Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWGDBZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWGDBZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 21:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWGDBZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 21:25:40 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:26004 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750834AbWGDBZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 21:25:39 -0400
Message-ID: <351976334.31345@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Tue, 4 Jul 2006 09:26:21 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New readahead - ups and downs new test. Vm oddities.
Message-ID: <20060704012621.GA7236@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Helge Hafting <helge.hafting@aitel.hist.no>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44A12D84.5010400@aitel.hist.no> <20060702235516.GA6034@mail.ustc.edu.cn> <20060703135027.GA4440@aitel.hist.no> <20060703153930.GC5874@mail.ustc.edu.cn> <20060703214217.GA10699@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703214217.GA10699@aitel.hist.no>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge,

On Mon, Jul 03, 2006 at 11:42:17PM +0200, Helge Hafting wrote:
> I have now re-run my tests (parallel debsums and
> bzcat+patch) this time with everything on the same device
> so as to get competition for io.
> 
> New and old readahead didn't make much difference this time
> either, so it seems that my idea about readahead
> problems were wrong.  Which is good, as the new readahead
> improves so many other things.
> 
> Results with new readahead using one disk device:
> Swap went up to 32M, dropped to 244k when testing ended.
> patch timing:
> real    6m8.451s
> user    0m5.183s
> sys     0m2.897s
> debsums timing:
> real    7m42.851s
> user    0m21.172s
> sys     0m13.642s
> 
> Results with old readahead, one disk device:
> Swap went to 32M, dropped to 244k when testing ended.
> timings:
> patch:
> real    6m18.191s
> user    0m5.226s
> sys     0m2.724s
> debsums:
> real    7m49.860s
> user    0m21.243s
> sys     0m14.268s
> A tiny bit slower, but very little.
> 
> 
> No surprise that everyting is slower when using a single
> disk instead of two.  

Thanks for all the efforts!

> The swap difference from using two disks is striking though.
> Nothing to do with readahead, but
> why 32M swap when using one disk, and 244k swap when using two?
> 
> The amount of data processed is the same either way,
> is the VM very timing-sensitive?

Because read/write request go for the same elevator queue I guess.

When there are concurrent read/writes, writes will be hold back,
giving priority to reads. So there will be more dirtied pages taking
up your memory during the test.

Thanks,
Wu
