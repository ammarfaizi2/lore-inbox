Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755777AbWKQSOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbWKQSOV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755771AbWKQSOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:14:21 -0500
Received: from homer.mvista.com ([63.81.120.158]:21753 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1755774AbWKQSOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:14:20 -0500
Subject: Re: [PATCH] Allow NULL pointers in percpu_free
From: Daniel Walker <dwalker@mvista.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Jens Axboe <axboe@kernel.dk>, Christoph Lameter <clameter@sgi.com>,
       Pedro Roque <roque@di.fc.ul.pt>,
       "David S. Miller" <davem@davemloft.net>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0611171307180.2627-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0611171307180.2627-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 10:14:07 -0800
Message-Id: <1163787247.3097.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 13:07 -0500, Alan Stern wrote:
> On Fri, 17 Nov 2006, Daniel Walker wrote:
> 
> > On Fri, 2006-11-17 at 12:36 -0500, Alan Stern wrote:
> > 
> > >  void percpu_free(void *__pdata)
> > >  {
> > > +	if (!__pdata)
> > > +		return;
> > 
> > Should be unlikely() right?
> 
> It certainly could be.  I tend not to put such annotations in my code, but 
> it wouldn't hurt.

It's actually a really good idea to add them .. I've noticed they tend
to make my kernels smaller, although I wouldn't expect that to always be
the case.. Another reason is that in -mm we can track how often this
condition is triggered with likely profiling. With kfree, for instance,
there were a number of callers that frequently called kfree(NULL), which
IMO isn't good.

Daniel

