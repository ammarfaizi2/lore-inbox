Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbULULde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbULULde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 06:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbULULde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 06:33:34 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:6798 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S261734AbULULd3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 06:33:29 -0500
Message-ID: <41C80A04.9070504@moving-picture.com>
Date: Tue, 21 Dec 2004 11:33:24 +0000
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org> <20041220192046.GM4630@dualathlon.random>
In-Reply-To: <20041220192046.GM4630@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> My only suggestion for 2.4 is to try with vm_cache_scan_ratio = 20 or
> higher (or alternatively vm_mapped_ratio = 50 or = 20).  There's a
> reason why everything is tunable by sysctl.
> 
> I don't think the vm_lru_balance_ratio is the one he's interested
> about. vm_lru_balance_ratio controls how much work is being done at
> every dcache/icache shrinking.
> 
> His real objective is to invoke the dcache/icache shrinking more
> frequently, how much work is being done at each pass is a secondary
> issue. If we don't invoke it, nothing will be shrunk, no matter what is
> the value of vm_lru_balance_ratio.
> 
> Hope this helps funding an optimal tuning for the workload.

Setting vm_mapped_ratio to 20 seems to give a 'better' memory usage 
using my very contrived test - running a find will result in about 900Mb 
of dcache/icache, but then running a cat to /dev/null will shrink the 
dcache/icache down to between 100-300Mb - running the find and cat at 
the same time results in about the same dcache/icache usage.

I'll give this a go on the production NFS server and I'll see if it 
improves things.

Thanks

James Pearson




