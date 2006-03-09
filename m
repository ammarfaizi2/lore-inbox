Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752011AbWCIQCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbWCIQCE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWCIQCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:02:04 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:60116 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751099AbWCIQCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:02:03 -0500
Date: Thu, 9 Mar 2006 19:02:01 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>,
       Alan Cox <alan@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Paul@ozlabs.org, E.McKenney@ozlabs.org,
       " <paulmck@us.ibm.com>"@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060309190201.A19243@jurassic.park.msu.ru>
References: <20060308154157.GI7301@parisc-linux.org> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <10095.1141838381@warthog.cambridge.redhat.com> <17423.22121.254026.487964@cargo.ozlabs.ibm.com> <20060309020851.D9651@jurassic.park.msu.ru> <17423.32377.460820.710578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17423.32377.460820.710578@cargo.ozlabs.ibm.com>; from paulus@samba.org on Thu, Mar 09, 2006 at 12:01:45PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 12:01:45PM +1100, Paul Mackerras wrote:
> If you do:
> 
> 	CPU 0			CPU 1
> 
> 	foo = val;
> 	wmb();
> 	p = &foo;
> 				reg = p;
> 				bar = *reg;
> 
> it is apparently possible for CPU 1 to see the new value of p
> (i.e. &foo) but an old value of foo (i.e. not val).  This can happen
> if p and foo are in different halves of the cache on CPU 1, and there
> are a lot of updates coming in for the half containing foo but the
> half containing p is quiet.

Indeed, this can happen according to architecture reference manual,
so CPU 1 needs mb() as well.

Thanks for clarification.

Ivan.
