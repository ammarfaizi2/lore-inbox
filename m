Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVAZKAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVAZKAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVAZKAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:00:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16533 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262238AbVAZKAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:00:02 -0500
Date: Wed, 26 Jan 2005 10:00:02 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Christoph Hellwig <hch@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050126100002.GH8859@parcelfarce.linux.theplanet.co.uk>
References: <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org> <20050125185812.GA1499@us.ibm.com> <20050126094308.GA7326@infradead.org> <20050126095131.GF8859@parcelfarce.linux.theplanet.co.uk> <20050126095504.GA7542@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126095504.GA7542@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 09:55:04AM +0000, Christoph Hellwig wrote:
> On Wed, Jan 26, 2005 at 09:51:31AM +0000, Al Viro wrote:
> > On Wed, Jan 26, 2005 at 09:43:08AM +0000, Christoph Hellwig wrote:
> > > > o	vfs_follow_link(): used to interpret symbolic links, which
> > > > 	might point outside of SAN Filesystem.
> > > 
> > > This one is going away very soon, including the whole old-style
> > > ->follow_link support - for technical reasons.
> > 
> > Not really.  In some cases it _is_ legitimate.  Trivial example:
> > /proc/self.
> 
> Which is an extreme special case an not modular.

I'm not convinced.  Sure, leaving traversal to caller is preferable.
I don't believe that it should be enforced.  That's why we have a way
to enforce a separate limit on that sort of recursion...
