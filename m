Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSJDOL0>; Fri, 4 Oct 2002 10:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261803AbSJDOL0>; Fri, 4 Oct 2002 10:11:26 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:45074 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261799AbSJDOLZ>; Fri, 4 Oct 2002 10:11:25 -0400
Date: Fri, 4 Oct 2002 15:16:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 4/4: evms_biosplit.h
Message-ID: <20021004151656.C30635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF2FC09D0D.E4C956E8-ON85256C47.006ECCC8@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF2FC09D0D.E4C956E8-ON85256C47.006ECCC8@pok.ibm.com>; from peloquin@us.ibm.com on Thu, Oct 03, 2002 at 03:36:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 03:36:24PM -0500, Mark Peloquin wrote:
> 
> On 10/03/2002 at 10:05 AM, Christoph Hellwig wrote:
> 
> >> +static mempool_t *my_bio_split_pool, *my_bio_pool;
> >> +static kmem_cache_t *my_bio_split_slab, *my_bio_pool_slab;
> 
> > Umm, static variables in header files?
> 
> Yupp, that wasn't accidental.
> 
> Based on the conclusions mutually agreed on in the OLS
> BOF on bio splitting, it was decided that each driver
> having the need to split bios *should* have their own
> private bio pools to use exclusively for this purpose.
> Thus any plugin that includes this header gets their
> own private copies of these variables.

Having variables and (non-inline) functions is very bad style and a
perfect method for the obsfucated C contest.  Just let every module
that needs bio-splitting declare it's own variables.

