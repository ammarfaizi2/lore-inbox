Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312690AbSDSPaV>; Fri, 19 Apr 2002 11:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSDSPaU>; Fri, 19 Apr 2002 11:30:20 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:10667 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S312690AbSDSPaU>;
	Fri, 19 Apr 2002 11:30:20 -0400
Subject: Re: Bio pool & scsi scatter gather pool usage
From: Steve Lord <lord@sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Mark Peloquin <peloquin@us.ibm.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16yUE0-0006i7-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 19 Apr 2002 10:27:22 -0500
Message-Id: <1019230042.10294.285.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-04-19 at 03:58, Alan Cox wrote:
> > But this gets you lowest common denominator sizes for the whole
> > volume, which is basically the buffer head approach, chop all I/O up
> > into a chunk size we know will always work. Any sort of nasty  boundary
> > condition at one spot in a volume means the whole thing is crippled
> > down to that level. It then becomes a black magic art to configure a
> > volume which is not restricted to a small request size.
> 
> Its still cheaper to merge bio chains than split them. The VM issues with
> splitting them are not nice at all since you may need to split a bio to
> write out a page and it may be the last page
> -

I am well aware of the problems of allocating more memory in some of
these places - been the bane of my life for the last couple of years
with XFS ;-)

It just feels so bad to have the ability to build a large request and
use one bio structure and know that 99.9% of the time the lower layers
can handle it in one chunk, but instead have to chop it into the lowest
common denominator pieces for the sake of the other 0.1%.

Just looking at how my disks ended up partitioned not many of them are
even on 4K boundaries, so any sort of concat built on them would
have a boundary case which required such a split - I think, still
working on my caffine intake this morning.

Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
