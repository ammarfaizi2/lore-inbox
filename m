Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWCOS3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWCOS3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 13:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWCOS3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 13:29:14 -0500
Received: from fmr22.intel.com ([143.183.121.14]:708 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750942AbWCOS3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 13:29:13 -0500
Message-Id: <200603151828.k2FISxg19755@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Roland Dreier'" <rdreier@cisco.com>, <hawkes@sgi.com>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Jes Sorensen" <jes@sgi.com>
Subject: RE: [PATCH] fix alloc_large_system_hash roundup
Date: Wed, 15 Mar 2006 10:29:00 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZIV9rKkHnRl09QSpeeX2yxokSUnwABefmw
In-Reply-To: <adazmjr38t7.fsf@cisco.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote on Wednesday, March 15, 2006 9:41 AM
> >  	/* rounded up to nearest power of 2 in size */
> > -	numentries = 1UL << (long_log2(numentries) + 1);
> > +	numentries = 1UL << (long_log2(2*numentries - 1));
> 
> How about just using roundup_pow_of_two()?  You could kill the comment
> too then.

roundup_pow_of_two uses fls, but fls takes an "int" argument.  I think
that function is buggy on 64-bit arch. Is it an oversight or something?


static inline unsigned long roundup_pow_of_two(unsigned long x)
{
        return (1UL << fls(x - 1));
}

- Ken

