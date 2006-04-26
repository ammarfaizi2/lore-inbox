Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWDZJ4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWDZJ4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 05:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWDZJ4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 05:56:25 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:52357 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932072AbWDZJ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 05:56:24 -0400
Date: Wed, 26 Apr 2006 11:56:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hzhong@gmail.com
Subject: Re: [PATCH] Profile likely/unlikely macros
Message-ID: <20060426095602.GB29108@wohnheim.fh-wedel.de>
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com> <20060424200657.0af43d6a.akpm@osdl.org> <444DF5B4.6030004@yahoo.com.au> <1145989423.3674.17.camel@localhost.localdomain> <444EC7F9.8080208@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <444EC7F9.8080208@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 April 2006 11:08:09 +1000, Nick Piggin wrote:
> Daniel Walker wrote:
> 
> Ah, I see. Then you should be OK with either your current scheme, or
> Andrew's suggestion, so long as you have a memory barrier before the
> unlock (eg. smp_mb__before_clear_bit()).
> 
> >I'm not exactly sure what you mean by "release consistency" ?
> 
> Without a barrier, the stores to the linked list may be visible to another
> CPU after the store that unlocks the atomic_t. Ie. the critical section can
> leak out of the lock.

Admitted, I'm a bit slow at times.  But why does this matter?
According to my fairly limited brain, you take a potentially expensive
barrier, so you pay with a bit of runtime.  What you buy is a smaller
critical section, so you can save some runtime on other cpus.  When
optimizing for the common case, which is one cpu, this is a net loss.

There must be some correctness issue hidden that I cannot see.  Can
you explain that to me?

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
