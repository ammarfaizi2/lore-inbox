Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbVF0SvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbVF0SvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVF0SvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:51:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15755 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261589AbVF0SvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:51:17 -0400
Subject: RE: [rfc] lockless pagecache
From: Badari Pulavarty <pbadari@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, Lincoln Dale <ltd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <200506271814.j5RIEwg22390@unix-os.sc.intel.com>
References: <200506271814.j5RIEwg22390@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 11:50:58 -0700
Message-Id: <1119898264.13376.89.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 11:14 -0700, Chen, Kenneth W wrote:
> Nick Piggin wrote on Monday, June 27, 2005 2:04 AM
> > >> However I think for Oracle and others that use shared memory like
> > >> this, they are probably not doing linear access, so that would be a
> > >> net loss. I'm not completely sure (I don't have access to real loads
> > >> at the moment), but I would have thought those guys would have looked
> > >> into fault ahead if it were a possibility.
> > > 
> > > 
> > > i thought those guys used O_DIRECT - in which case, wouldn't the page 
> > > cache not be used?
> > > 
> > 
> > Well I think they do use O_DIRECT for their IO, but they need to
> > use the Linux pagecache for their shared memory - that shared
> > memory being the basis for their page cache. I think. Whatever
> > the setup I believe they have issues with the tree_lock, which is
> > why it was changed to an rwlock.
> 
> Typically shared memory is used as db buffer cache, and O_DIRECT is
> performed on these buffer cache (hence O_DIRECT on the shared memory).
> You must be thinking some other workload.  Nevertheless, for OLTP type
> of db workload, tree_lock hasn't been a problem so far.

What about DSS ? I need to go back and verify some of the profiles
we have.

Thanks,
Badari


