Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDVAzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDVAzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 20:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWDVAzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 20:55:44 -0400
Received: from ns1.siteground.net ([207.218.208.2]:696 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750802AbWDVAzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 20:55:43 -0400
Date: Fri, 21 Apr 2006 17:56:49 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@osdl.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext3 percpu counter fixes to suppport for more than 2**31 ext3 free blocks counter
Message-ID: <20060422005649.GA3817@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com> <1145631546.4478.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145631546.4478.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 07:59:06AM -0700, Mingming Cao wrote:
> The following patches are to fix the percpu counter issue support more
> than 2**31 blocks for ext3, i.e. allow the ext3 free block accounting
> works with more than 8TB storage.
> 
> [PATCH 1] - Generic perpcu longlong type counter support: global counter
> type changed from long to long long. The local counter is still remains
> 32 bit (long type), so we could avoid doing 64 bit update in most cases.
> Fixed the percpu_counter_read_positive() to handle the  0 value counter
> correctly;Add support to initialize the global counter to a value that
> are greater than 2**32.
> 
> [PATCH 2] - ext3 part of the changes: make use of the new support to
> initialize the free blocks counter, instead of using percpu_counter_mod
> () indirectly.
> 
> Patches against 2.6.17-rc1-mm2. Tested on a freshly created 10TB ext3. 
> 
> Here is Patch 1.
> 
> Signed-Off-By: Mingming Cao <cmm@us.ibm.com>
> 
> ...  
> +static inline void
> +percpu_counter_ll_init(struct percpu_counter *fbc, long long amount)
> +{
> +	spin_lock_init(&fbc->lock);
> +	fbc->count = amount;
> +	fbc->counters = alloc_percpu(long);
> +}
> +

Do we need another interface for this?  Why not change percpu_counter_init
and users to use 'amount' as an additional argument instead?  

Thanks,
Kiran
