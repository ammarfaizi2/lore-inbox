Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSH0Ut7>; Tue, 27 Aug 2002 16:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSH0Ut7>; Tue, 27 Aug 2002 16:49:59 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:19697 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316897AbSH0Ut6>; Tue, 27 Aug 2002 16:49:58 -0400
Date: Tue, 27 Aug 2002 16:54:17 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Dean Nelson <dcn@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: atomic64_t proposal
Message-ID: <20020827165417.C23980@redhat.com>
References: <200208271937.OAA78345@cyan.americas.sgi.com.suse.lists.linux.kernel> <p73sn102hvu.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73sn102hvu.fsf@oldwotan.suse.de>; from ak@suse.de on Tue, Aug 27, 2002 at 09:58:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 09:58:45PM +0200, Andi Kleen wrote:
> Is it supposed to only work on 64bit or do you plan to supply it for 32
> bit too? If no, I don't see how drivers etc. should ever use it. linux 
> is supposed to have a common kernel api.
> If yes, the implementation on 32bit could be a problem. e.g. some 
> archs need space in there for spinlocks, so it would be needed to limit
> the usable range.

There are a couple of options for implementations to use that don't 
require space for a spinlock: a hash table of spinlocks can be used 
to protect the data (parisc uses this technique).  Andrea's lockless 
reader locks could be useful in this case.  Most x86es can use cmpxchg8, 
and the 64 bit machines are already set.  I suspect it would be a useful 
addition to the kernel APIs.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
