Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbTCHThF>; Sat, 8 Mar 2003 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbTCHThF>; Sat, 8 Mar 2003 14:37:05 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32270 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262153AbTCHThB>;
	Sat, 8 Mar 2003 14:37:01 -0500
Date: Sat, 8 Mar 2003 11:37:22 -0800
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, hch@infradead.org, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] register_blkdev
Message-ID: <20030308193722.GD26374@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl> <20030307193644.A14196@infradead.org> <20030307123029.2bc91426.akpm@digeo.com> <20030307221217.GB21315@kroah.com> <20030307143319.2413d1df.akpm@digeo.com> <20030307234541.GG21315@kroah.com> <1047086062.24215.14.camel@irongate.swansea.linux.org.uk> <20030308005018.GE23071@kroah.com> <1047136302.25932.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047136302.25932.28.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 03:11:42PM +0000, Alan Cox wrote:
> On Sat, 2003-03-08 at 00:50, Greg KH wrote:
> > > So we need a maxminors flag in the register for 2.6 I guess ?
> > 
> > Do you mean to only increase the number of majors, and not minors then?
> 
> How about an interface that looks like
> 
> 	register_chr_device(blah. blah, MY_MAX_MINOR);
> 
> and we can delete all the if < 0 || >= MAX return logic from the drivers
> as we go. Right now each driver checks and several in the past had off 
> by one errors.

That's a good start, but why not change that to a simple,
HOW_MANY_MINORS_I_WANT, which will work the same way now, but allow us
to change to a pure dynamic major/minor allocation scheme in the future
by only modifying the register_chr_device() code.  Same thing for
register_blkdev().

Although if we increase the width of dev_t then a need for dynamic
major/minors is pretty much gone...

thanks,

greg k-h
