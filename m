Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319277AbSH2RtX>; Thu, 29 Aug 2002 13:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319281AbSH2RtX>; Thu, 29 Aug 2002 13:49:23 -0400
Received: from ns.suse.de ([213.95.15.193]:35346 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319277AbSH2RtW>;
	Thu, 29 Aug 2002 13:49:22 -0400
Date: Thu, 29 Aug 2002 19:53:45 +0200
From: Andi Kleen <ak@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Message-ID: <20020829195345.A27153@wotan.suse.de>
References: <p737ki9shok.fsf@oldwotan.suse.de> <Pine.GSO.4.21.0208291347540.15425-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0208291347540.15425-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 01:51:00PM -0400, Alexander Viro wrote:
> 
> 
> On 29 Aug 2002, Andi Kleen wrote:
> 
> > It does a better job for near all the string.h stuff. x86-64 just uses
> > the builtins. Only exception  is memcpy, where it likes to call out of line 
> > memcpy when it is not absolutely sure about all the alignments 
> > (especally lots of casting causes that) 
> 
> memcpy() on x86 includes uses of mmx_memcpy().  Not likely to be done by gcc...
Only for big arguments. That is why it calls the out of line function.
Basically it only inlines when the limit is known and small and the alignments
are known. IMHO the alignment check is overkill for x86, but that is what
it does. That is why I wrapped it a bit (see include/asm-x86_64/string.h) 


-Andi
