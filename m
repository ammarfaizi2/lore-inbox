Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWGCVqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWGCVqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWGCVqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:46:24 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:3731 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750865AbWGCVqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:46:24 -0400
Date: Mon, 3 Jul 2006 23:42:17 +0200
To: Fengguang Wu <fengguang.wu@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New readahead - ups and downs new test. Vm oddities.
Message-ID: <20060703214217.GA10699@aitel.hist.no>
References: <44A12D84.5010400@aitel.hist.no> <20060702235516.GA6034@mail.ustc.edu.cn> <20060703135027.GA4440@aitel.hist.no> <20060703153930.GC5874@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703153930.GC5874@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have now re-run my tests (parallel debsums and
bzcat+patch) this time with everything on the same device
so as to get competition for io.

New and old readahead didn't make much difference this time
either, so it seems that my idea about readahead
problems were wrong.  Which is good, as the new readahead
improves so many other things.

Results with new readahead using one disk device:
Swap went up to 32M, dropped to 244k when testing ended.
patch timing:
real    6m8.451s
user    0m5.183s
sys     0m2.897s
debsums timing:
real    7m42.851s
user    0m21.172s
sys     0m13.642s

Results with old readahead, one disk device:
Swap went to 32M, dropped to 244k when testing ended.
timings:
patch:
real    6m18.191s
user    0m5.226s
sys     0m2.724s
debsums:
real    7m49.860s
user    0m21.243s
sys     0m14.268s
A tiny bit slower, but very little.


No surprise that everyting is slower when using a single
disk instead of two.  

The swap difference from using two disks is striking though.
Nothing to do with readahead, but
why 32M swap when using one disk, and 244k swap when using two?

The amount of data processed is the same either way,
is the VM very timing-sensitive?

Helge Hafting

