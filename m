Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVBKE3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVBKE3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 23:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVBKE3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 23:29:19 -0500
Received: from almesberger.net ([63.105.73.238]:20238 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262151AbVBKE3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 23:29:14 -0500
Date: Fri, 11 Feb 2005 01:27:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, anton@samba.org, okir@suse.de,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050211012736.A25529@almesberger.net>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com> <20050203150821.2321130b.davem@davemloft.net> <20050204113305.GA12764@gondor.apana.org.au> <20050204154855.79340cdb.davem@davemloft.net> <20050204222428.1a13a482.davem@davemloft.net> <20050210012304.E25338@almesberger.net> <20050210195026.09b507e7.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050210195026.09b507e7.davem@davemloft.net>; from davem@davemloft.net on Thu, Feb 10, 2005 at 07:50:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Absolutely, I agree.  My fingers even itched as I typed those lines
> in.  I didn't change the wording because I couldn't come up with
> anything better.

How about something like:

  Unlike the above routines, atomic_???_return are required to perform
  memory barriers [...]

I think "implicit" and "explicit" here are just confusing, because
you don't define them, and there's no intuitively correct meaning
either.

Perhaps a little warning could also be useful for the reader who
wasn't paying close attention to whose role is described:

  Note: this means that a caller of atomic_add, etc., who needs a
  memory barrier before or after that call has to code the memory
  barrier explicitly, whereas a caller of atomic_???_return can rely
  on said functions to provide the barrier without further ado. For
  the implementor of the atomic functions, the roles are reversed.

> You still get the memory barrier, whether you read the return
> value or not.

That might be something worth mentioning. Not that a construct
is used that gcc can optimize away when nobody cares about the
return value.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
