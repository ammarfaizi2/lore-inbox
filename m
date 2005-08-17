Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbVHQCBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbVHQCBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 22:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVHQCBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 22:01:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47007 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750793AbVHQCBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 22:01:25 -0400
Date: Tue, 16 Aug 2005 19:01:57 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, SteveW@ACM.org, walpole@cs.pdx.edu
Subject: Re: rcu read-side protection
Message-ID: <20050817020156.GF1319@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <000f01c5a2bf$f8e752d0$6401a8c0@woodworkxi42l4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c5a2bf$f8e752d0$6401a8c0@woodworkxi42l4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 05:09:29PM -0700, Suzanne Wood wrote:
[ . . . ]
> A read-side critical section is marked to protect the dereference of the 
> dn_ptr and assignment to dn_db which is a pointer to a dn_dev.  (struct 
> net_device is defined in /linux/netdevice.h and its dn_ptr in 
> /include/net/dn_dev.h)  Should this rcu-protection be extended to the line 
> following rcu_read_lock()?  Even though use_long is a simple char, it 
> appears to be a member of an rcu-protected structure.

Looks to me that this could indeed be a problem -- the structure
pointed to by dn_db could potentially be freed immediately after the
rcu_read_unlock(), unless there is some other non-obvious locking
mechanism protecting it.  In which case, why the rcu_read_lock()
and rcu_read_unlock()...

						Thanx, Paul
