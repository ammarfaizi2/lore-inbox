Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266302AbUG0HKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266302AbUG0HKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUG0HKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:10:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20120 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266292AbUG0HK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:10:26 -0400
Date: Tue, 27 Jul 2004 12:39:15 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add kref_read and kref_put_last primitives
Message-ID: <20040727070915.GC1270@obelix.in.ibm.com>
References: <20040726144856.GH1231@obelix.in.ibm.com> <20040726173151.A11637@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726173151.A11637@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 05:31:51PM +0100, Christoph Hellwig wrote:
> On Mon, Jul 26, 2004 at 08:18:56PM +0530, Ravikiran G Thirumalai wrote:
> > ...
> 
> Why don't you simply use an atomic_t if that's what you seem to
> want?
> 

struct kref does just that.  The kref api are just abstractions for 
refcounting which i presume is recommended for all refcounters in the
kernel.  I am just converting the struct file.f_count refcounter
to use kref with this patch.  

My actual intentions are to extend the kref api to do lock free refcounting 
and use that for the file.f_count refcounter, and make fd lookup lock 
free using rcu.  My earlier experiments with such patches showed 
performance improvements for threaded workloads which do lot of io.

Thanks,
Kiran
