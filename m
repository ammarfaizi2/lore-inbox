Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWA1KVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWA1KVy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 05:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWA1KVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 05:21:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:141 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932210AbWA1KVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 05:21:53 -0500
Subject: Re: [patch 0/9] Critical Mempools
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, bcrl@kvack.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
In-Reply-To: <43DABDBF.7010006@us.ibm.com>
References: <1138217992.2092.0.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
	 <43D954D8.2050305@us.ibm.com>
	 <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com>
	 <43D95BFE.4010705@us.ibm.com> <20060127000304.GG10409@kvack.org>
	 <43D968E4.5020300@us.ibm.com>
	 <84144f020601262335g49c21b62qaa729732e9275c0@mail.gmail.com>
	 <20060127021050.f50d358d.pj@sgi.com>
	 <84144f020601270307t7266a4ccs5071d4b288a9257f@mail.gmail.com>
	 <43DABDBF.7010006@us.ibm.com>
Date: Sat, 28 Jan 2006 12:21:51 +0200
Message-Id: <1138443711.8657.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-01-27 at 16:41 -0800, Matthew Dobson wrote:
> Now, a few pages of memory could be incredibly crucial, since
> we're discussing an emergency (presumably) low-mem situation, but if
> we're going to be getting several requests for the same
> slab/kmalloc-size then we're probably better of giving a whole page to
> the slab allocator.  This is pure speculation, of course... :)

Yeah but even then there's no guarantee that the critical allocations
will be serviced first. The slab allocator can as well be giving away
bits of the fresh page to non-critical allocations. For the exact same
reason, I don't think it's enough that you pass a subsystem-specific
page pool to the slab allocator.

Sorry if this has been explained before but why aren't mempools
sufficient for your purposes? Also one more alternative would be to
create a separate object cache for each subsystem-specific critical
allocation and implement a internal "page pool" for the slab allocator
so that you could specify for the number of pages an object cache
guarantees to always hold on to.

				Pekka

