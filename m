Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTLOKAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 05:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTLOKAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 05:00:11 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:43977 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263462AbTLOKAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 05:00:04 -0500
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
From: Vladimir Saveliev <vs@namesys.com>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312121535.22375.rob@landley.net>
References: <20031211125806.B2422@hexapodia.org>
	 <200312120753.11906.rob@landley.net>
	 <1071237719.27730.158.camel@tribesman.namesys.com>
	 <200312121535.22375.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1071482402.11042.36.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Dec 2003 13:00:03 +0300
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Sat, 2003-12-13 at 00:35, Rob Landley wrote:
> On Friday 12 December 2003 08:01, Vladimir Saveliev wrote:
> > On Fri, 2003-12-12 at 16:53, Rob Landley wrote:
> > > On Friday 12 December 2003 07:28, Vladimir Saveliev wrote:
> > > > Hi
> > > >
> > > > On Fri, 2003-12-12 at 15:55, Jörn Engel wrote:
> > > > > On Thu, 11 December 2003 14:32:12 -0600, Rob Landley wrote:
> > > > > > On Thursday 11 December 2003 13:48, Jörn Engel wrote:
> > > > > > > If you really do it, please don't add a syscall for it.  Simply
> > > > > > > check each written page if it is completely filled with zero. 
> > > > > > > (This will be a very quick check for most pages, as they will
> > > > > > > contain something nonzero in the first couple of words)
> > > > > >
> > > > > > Cache poisoning, streaming writes to large RAID arrays...  There
> > > > > > are about 8 zllion reasons not to do this.  Really.  (It defeats
> > > > > > the whole purpose of DMA, doesn't it?)
> > > >
> > > > Sorry,
> > > > but doesn't truncate do almost exactly what "make hole" is supposed to
> > > > do?
> > >
> > > I have a 2 gigabyte file.  I want to punch a hole from 257 megabytes to
> > > 364 megabytes, saving over 100 megs of disk space.  I do NOT want to have
> > > to copy off and rewrite 1.6 gigabytes of data from the end of the file. 
> > > (There may not even be enough room on the disk, and it would take a long
> > > time anyway.)
> >
> > ok.
> > But I asked why would "make hole" have problems you list (8 zillions)
> > and truncate would not have them?
> 
> Ah.
> 
> Truncate doesn't look at the contents of the file, it just frees the space 
> regardless of what the data was.  (It doesn't have to load the contents of 
> the blocks into memory and look at them in order to make the file's length 
> shorter in the metadata and de-allocate those blocks.)
> 
> What was suggested a bit earlier was automatically looking at the contents of 
> the data being written to disk, and not allocating actual blocks if the data 
> is all zeroes.  (A bit like looking at pages of memory and copy-on-write 
> aliasing them to the zero page whenever the page is entirely zeroes.)
> 
> Truncate doesn't do any of that.  Truncate only plays with metadata, and 
> doesn't care about the contents of the file.
> 

I thought we are talking about something which would allow to create
holes inside of non sparse file


> Rob
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

