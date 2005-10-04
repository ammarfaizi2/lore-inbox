Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbVJDTty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbVJDTty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVJDTtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:49:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:29904 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964942AbVJDTtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:49:53 -0400
Date: Wed, 5 Oct 2005 01:13:49 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Christopher Friesen" <cfriesen@nortel.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Roland Dreier <rolandd@cisco.com>,
       Sonny Rao <sonny@burdell.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20051004194349.GA6039@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org> <4331C9B2.5070801@nortel.com> <20050921210019.GF4569@in.ibm.com> <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332CAEA.1010509@nortel.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 09:16:58AM -0600, Christopher Friesen wrote:
> Al Viro wrote:
> 
> >Umm...   How many RCU callbacks are pending?
> 
> I added an atomic counter that is incremented just before call_rcu() in 
> d_free(), and decremented just after kmem_cache_free() in d_callback().
> 
> According to this we had 4127306 pending rcu callbacks.  A few seconds 
> later it was down to 0.
> 
> 
> /proc/sys/fs/dentry-state:
> 1611    838     45      0       0       0
> 

Hmm.. This clearly indicates that there are very few allocated dentries
and they are just not returned to slab by RCU.

Since then, I have done some testing myself, but I can't reproduce
this problem in two of my systems - x86 and x86_64. I ran rename14
in a loop too, but after exhausting a lot of free memory, dcache
does get shrunk and I don't see dentries stuck in RCU queues at all.
I tried UP kernel too.

So, there must be something else in your system that I
am missing in my setup. Could you please mail me your .config ?

Thanks
Dipankar
