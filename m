Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbUKKDyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUKKDyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 22:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbUKKDyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 22:54:47 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:45066 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262051AbUKKDyp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 22:54:45 -0500
Date: Thu, 11 Nov 2004 03:54:41 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Antonino Sergi <Antonino.Sergi@Roma1.INFN.it>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: isa memory address
In-Reply-To: <1100079437.30102.66.camel@delphi.roma1.infn.it>
Message-ID: <Pine.LNX.4.58L.0411110329260.10663@blysk.ds.pg.gda.pl>
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>  <418FA2F1.2090003@osdl.org>
  <1100014956.30102.54.camel@delphi.roma1.infn.it> 
 <Pine.LNX.4.58L.0411091638570.9795@blysk.ds.pg.gda.pl>
 <1100079437.30102.66.camel@delphi.roma1.infn.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004, Antonino Sergi wrote:

> >  Because you are trying to use the region in the I/O port space.  That's
> > probably not what you want to do and an 8-bit ISA board cannot decode it
> > at all anyway.  Actually for some platforms using the I/O space outside
> > the low 16-bit range may be quite difficult even for buses and devices
> > that support it and Linux does not support it then, either.  So Linux 
> > correctly informs you you cannot use that range.
> 
> This is actually not clear for me.

 The port I/O space range differs among platforms.  You get -EBUSY in a
response to a request for a range of ports outside the supported range.

> >  ... or better yet request_mem_region()/release_resource(), as the former 
> > is deprecated and will be removed.
> 
> I tried but (on 2.4.2):
> - request_region fails but, ignoring it and remapping physical address
> to virtual, everything works fine, except for release_region, of course.
> - request_mem_region works but what I get from communication with the
> actual device are numbers that sometimes are surely wrong.

 As both request_region() and request_mem_region() merely reserve
different resources in Linux structures, you can't get a different
behavior from your device depending on which one you call, if any at all,
unless you change code elsewhere at the same time.

> I couldn't understand what is the actual difference between
> ioport_resource and iomem_resource to track the problem.

 The former holds I/O resources mapped in the port space, whilst the
latter holds ones mapped in the memory space.  The spaces use different
cycles each at the bus the destined device is located on.

  Maciej
