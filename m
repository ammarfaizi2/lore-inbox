Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbTBUJ2D>; Fri, 21 Feb 2003 04:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbTBUJ2D>; Fri, 21 Feb 2003 04:28:03 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:34693 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267204AbTBUJ2C>;
	Fri, 21 Feb 2003 04:28:02 -0500
Date: Fri, 21 Feb 2003 10:37:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030221093713.GF31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <shs1y22zhm9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs1y22zhm9.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:56:14PM +0100, Trond Myklebust wrote:
> >>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:
> 
>      > 2.5.62 has the very same deadlock condition in xdr triggered by
>      >        nfs too.
>      > Andrew, if you're forward porting it yourself like with the
>      > filebacked vma merging feature just let me know so we make sure
>      > not to duplicate effort.
> 
> For 2.5.x we should rather fix MSG_MORE so that it actually works
> instead of messing with hacks to kmap().
> 
> For 2.4.x, Hirokazu Takahashi had a patch which allowed for a safe
> kmap of > 1 page in one call. Appended here as an attachment FYI
> (Marcelo do *not* apply!).

you can't do it this way, the number of kmap available can be just 1,
and you can ask for 10000 in a row this way. Furthmore you want to be
able to use all the kmaps available, think if you have 11 kmaps, and 10
are constantly in use. I much prefer my approch that is the most
finegrined and scalable and it doesn't risk to deadlock in function of
the number of kmaps in the pool and the max reservation you make. I just
considered the approch implemented in the patch you quoted and I
discarded it for the reasons explained above.

Andrea
