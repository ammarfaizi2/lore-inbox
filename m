Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318750AbSHLRKz>; Mon, 12 Aug 2002 13:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSHLRKz>; Mon, 12 Aug 2002 13:10:55 -0400
Received: from hercules.egenera.com ([208.254.46.135]:41229 "HELO
	coyote.egenera.com") by vger.kernel.org with SMTP
	id <S318750AbSHLRKy>; Mon, 12 Aug 2002 13:10:54 -0400
Date: Mon, 12 Aug 2002 13:14:31 -0400
From: Phil Auld <pauld@egenera.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
Message-ID: <20020812131431.F27650@vienna.EGENERA.COM>
References: <20020812120659.B27650@vienna.EGENERA.COM> <20020812174634.A10106@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020812174634.A10106@infradead.org>; from hch@infradead.org on Mon, Aug 12, 2002 at 05:46:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rumor has it that on Mon, Aug 12, 2002 at 05:46:34PM +0100 Christoph Hellwig said:
> On Mon, Aug 12, 2002 at 12:06:59PM -0400, Phil Auld wrote:
> > Hi Al,
> > 	I think this falls under the VFS umbrella, but I may be wrong. 
> > 
> > Below is a fix to make block_llseek behave as specified in the Single Unix Spec. v3.
> > (http://www.unix-systems.org/single_unix_specification/). It's extremely trivial but
> > may have political baggage.
> 
> Have you tested when you actually seek over the size of a block device?

Yes. Later reads/writes fails as they should.

> Stupid standards aside: what is the purpose of this? blockdevices don't

It can be used to determine the size fo the device. Seek then read, if read fails
back off. That's where I first noticed it. The IOtest program from the Cerberus suite
does this.

As to the stupidity of standards, I'm not sure how to answer that. I am not the only
one to raise this issue though. 

> grow bigger if you seek beyond them..
> 
> Did any Linux implementation ever follow the standard (as you rewrite
> reverse)? 

Yes. As far as I can tell this came in in 2.4.11. Earlier 2.4 kernels and at least 2.2.16 
(I didn't check them all) don't have this problem. If it had always been this way it
probably wouldn't have come up. I'm not trying to pick nits on purpose. Something
used to work and then didn't.  

> What's the behaviour of other unix systems when seeking
> beyond the end of block devices?

Unfortunately (or not), I don't have any others handy. 

Remember there is no data transfer taking place to do the lseek.

There were a couple of exerpts from the standard in this thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102889752209363&w=2



-- 
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St., Marlboro, MA 01752       (508)858-2600
