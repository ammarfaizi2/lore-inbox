Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUIHWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUIHWMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269182AbUIHWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 18:12:05 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:62130 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S269181AbUIHWMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 18:12:00 -0400
Date: Wed, 8 Sep 2004 15:07:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: cmm@us.ibm.com, dipankar@us.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Put size in array to get rid of barriers in grow_ary()
Message-ID: <20040908220753.GD1240@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040907230936.GA13387@us.ibm.com> <Pine.LNX.4.44.0409081623380.8697-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409081623380.8697-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 04:39:43PM +0100, Hugh Dickins wrote:
> On Tue, 7 Sep 2004, Paul E. McKenney wrote:
> > 
> > The grow_ary() code has a number of explicit memory barriers, as does
> > ipc_lock().  This patch gets rid of the need for some of these by
> > placing the array size in the same block of memory containing the
> > array itself, so that the array and the size cannot possibly get out
> > of sync.  Also uses rcu_assign_pointer() to get rid of the remaining
> > smp_wmb().
> 
> But Paul, if you keep removing all these examples of memory barriers,
> how can I be expected to learn how to use them properly?

But Hugh, I left quite a few smp_wmb()s in there just for you!  ;-)

> Seriously, good, yes, the fewer "mb"s the better.
> I could always educate myself from the older source.

Agreed!

> > Untested, therefore probably broken.
> 
> Agreed ;)

Any specifics greatly appreciated, as always...

> > Thoughts?
> 
> Wouldn't it be a little nicer to start ipc_ids off pointing to a
> const ipc_id_ary of size 0, to avoid the various entries == NULL
> tests you had to add?

I like this one!!!  Will put a patch together.  Manfred's recent
patch applied a refcount, which negates the const part, but should
be no problem to put a size-zero structure in the struct ipc_ids.
(Having a separately allocated structure puts me back to checking
NULL pointers due to possibility of allocation failure.)

						Thanx, Paul
