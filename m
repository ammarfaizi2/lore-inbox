Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSEQCcj>; Thu, 16 May 2002 22:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315285AbSEQCcj>; Thu, 16 May 2002 22:32:39 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:8077 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315337AbSEQCci>; Thu, 16 May 2002 22:32:38 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
Date: Fri, 17 May 2002 12:32:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15588.27565.57663.59147@notabene.cse.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: knfsd misses occasional writes
In-Reply-To: message from Sverker Wiberg on Thursday May 16
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 16, Sverker.Wiberg@uab.ericsson.se wrote:
> Neil Brown wrote:
> > 
> > On Thursday May 16, Sverker.Wiberg@uab.ericsson.se wrote:
> 
> [on soft mount timeouts]
> > > But shouldn't those timeouts become errors over at the clients?
> > 
> > Yes... but "write" won't see an error.  Only 'fsync' or maybe 'close',
> > and many applications ignore errors from these operations.
> 
> How come? Isn't the client side innately synchronous (as RPC clients in
> general)?

Now way!  That would kill performance.

The application writes into the pagecache.  The nfs client, possibly
using  the helper thread like rpciod write asynchronously to the
server.  Data is only flushed on close or fsync or memory presure
or...
I have only a passing knowledge of this stuff though.  I trust Trond
will correct me is I say anything really silly.

> Or is this one of thost thing that are now done differently?

I think it was always this way.

NeilBrown
