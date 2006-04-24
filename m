Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWDXRtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWDXRtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDXRtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 13:49:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:48827 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750974AbWDXRtU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 13:49:20 -0400
Subject: Re: [PATCH 1/2] ext3 percpu counter fixes to suppport for more
	than 2**31 ext3 free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: akpm@osdl.org, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060422005649.GA3817@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <1145631546.4478.10.camel@localhost.localdomain>
	 <20060422005649.GA3817@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 24 Apr 2006 10:49:16 -0700
Message-Id: <1145900957.4820.16.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 17:56 -0700, Ravikiran G Thirumalai wrote:
> On Fri, Apr 21, 2006 at 07:59:06AM -0700, Mingming Cao wrote:
> > The following patches are to fix the percpu counter issue support more
> > than 2**31 blocks for ext3, i.e. allow the ext3 free block accounting
> > works with more than 8TB storage.
> > 
> > [PATCH 1] - Generic perpcu longlong type counter support: global counter
> > type changed from long to long long. The local counter is still remains
> > 32 bit (long type), so we could avoid doing 64 bit update in most cases.
> > Fixed the percpu_counter_read_positive() to handle the  0 value counter
> > correctly;Add support to initialize the global counter to a value that
> > are greater than 2**32.
> > 
> > [PATCH 2] - ext3 part of the changes: make use of the new support to
> > initialize the free blocks counter, instead of using percpu_counter_mod
> > () indirectly.
> > 
> > Patches against 2.6.17-rc1-mm2. Tested on a freshly created 10TB ext3. 
> > 
> > Here is Patch 1.
> > 
> > Signed-Off-By: Mingming Cao <cmm@us.ibm.com>
> > 
> > ...  
> > +static inline void
> > +percpu_counter_ll_init(struct percpu_counter *fbc, long long amount)
> > +{
> > +	spin_lock_init(&fbc->lock);
> > +	fbc->count = amount;
> > +	fbc->counters = alloc_percpu(long);
> > +}
> > +
> 
> Do we need another interface for this?  Why not change percpu_counter_init
> and users to use 'amount' as an additional argument instead?  

Suggestion accepted.:-)

Mingming

