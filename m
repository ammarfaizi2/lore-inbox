Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935802AbWK1KOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935802AbWK1KOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 05:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935800AbWK1KOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 05:14:46 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:18653 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S935802AbWK1KOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 05:14:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W16v1uZeaxWZFGezozqUVAjM9A0+6IPbJ5sFx4M8+qNKnhk1LH4X52P8e/NntA8cGeeyj1zsT2ecDSMTGrbzKS3ZU1DGihvQeJa3Q6eYZY00PsdhOrEBfUcODdywsdwlh+s5/Xv1TiZ/3qqQbWcmUaJ/KWG8/jUbPc8lfdGX+vE=
Message-ID: <9a8748490611280214s711d4f6eq6100a574af22f8a7@mail.gmail.com>
Date: Tue, 28 Nov 2006 11:14:44 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Fawad Lateef" <fawadlateef@gmail.com>
Subject: Re: Reserving a fixed physical address page of RAM.
Cc: "Dave Airlie" <airlied@gmail.com>, "Jon Ringle" <jringle@vertical.com>,
       "Robert Hancock" <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1e62d1370611272251r6cb797el26bc4f96e0958092@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fa.LC2HgQx8572p2lwOKfUm6cxg95s@ifi.uio.no>
	 <456B8517.7040502@shaw.ca> <456BAEB0.5030800@vertical.com>
	 <21d7e9970611272134g72044fa8u5c5e47842e994fe3@mail.gmail.com>
	 <1e62d1370611272251r6cb797el26bc4f96e0958092@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/06, Fawad Lateef <fawadlateef@gmail.com> wrote:
> On 11/28/06, Dave Airlie <airlied@gmail.com> wrote:
> > On 11/28/06, Jon Ringle <jringle@vertical.com> wrote:
> <snip>
> > > It looks promising, however, I need to reserve a physical address area
> > > that is well known (so that the code running on the other processor
> > > knows where in PCI memory to write to). It appears that
> > > dma_alloc_coherent returns the address that it allocated. Instead I need
> > > something where I can tell it what physical address and range I want to use.
> > >
> >
> > I've seen other projects just boot a 128M board with mem=120M and just
> > use the 8MB at 120 to talk to the other processor..
> >
>
> Yes, this can be used if required physical-memory exists in the last
> part of RAM as if you use mem=<xxxM> then kernel will only use memory
> less than or equal-to <xxxM> and above can be used by drivers (or any
> kernel module) might be through ioremap which takes physical-address.
>
> But if lets say we need only 1MB portion of specific physical-memory
> region then AFAIK it must be done by hacking in kernel code during
> memory-initialization (mem_init function) where it is marking/checking
> pages as/are reserved; you can simply mark you required pages as
> reserved too and set their count to some-value if you want to know
> later which pages are reserved by you. (can do this reservation work
> here: http://lxr.free-electrons.com/source/arch/i386/mm/init.c#605).
> CMIIW
>

Can you not use the 'memmap=' kernel option to reserve the specific
area you need?
(See Documentation/kernel-parameters.txt for details)

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
