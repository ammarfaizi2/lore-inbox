Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVLAR5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVLAR5d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVLAR5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:57:33 -0500
Received: from hera.kernel.org ([140.211.167.34]:64898 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932377AbVLAR5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:57:32 -0500
Date: Thu, 1 Dec 2005 15:57:11 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-mm <linux-mm@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Better pagecache statistics ?
Message-ID: <20051201175711.GA17169@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain> <20051201152029.GA14499@dmt.cnet> <1133452790.27824.117.camel@localhost.localdomain> <1133453411.2853.67.camel@laptopd505.fenrus.org> <20051201170850.GA16235@dmt.cnet> <1133457315.21429.29.camel@localhost.localdomain> <1133457700.2853.78.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133457700.2853.78.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 06:21:39PM +0100, Arjan van de Ven wrote:
> On Thu, 2005-12-01 at 09:15 -0800, Badari Pulavarty wrote:
> > > Most of the issues you mention are null if you move the stats
> > > maintenance burden to userspace. 
> > > 
> > > The performance impact is also minimized since the hooks 
> > > (read: overhead) can be loaded on-demand as needed.
> > > 
> > 
> > The overhead is - going through each mapping/inode in the system
> > and dumping out "nrpages" - to get per-file statistics. This is
> > going to be expensive, need locking and there is no single list 
> > we can traverse to get it. I am not sure how to do this.

Can't you add hooks to add_to_page_cache/remove_from_page_cache 
to record pagecache activity ?

> and worse... you're going to need memory to store the results, either in
> kernel or in userspace, and you don't know how much until you're done.
> That memory is going to need to be allocated, which in turn changes the
> vm state..

Indeed - need to pre-allocate some sensible amount of memory to store the
results (relayfs does it for your).

