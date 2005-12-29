Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVL2Qah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVL2Qah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVL2Qah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:30:37 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:35537 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S1750801AbVL2Qag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:30:36 -0500
Message-ID: <016701c60c94$a3a599f0$a400a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: "Nate Diller" <nate.diller@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
References: <EXCHG2003iSnRMWuLn500000618@EXCHG2003.microtech-ks.com> <00ad01c5eefd$7990b370$a700a8c0@dcccs> <5c49b0ed0512230058q157ddedx96059d876c45a69f@mail.gmail.com> <006001c6080b$03759da0$a700a8c0@dcccs> <5c49b0ed0512282010x156d59afmb2e1dd420542440b@mail.gmail.com>
Subject: Re: buffer cache question
Date: Thu, 29 Dec 2005 17:26:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

----- Original Message ----- 
From: "Nate Diller" <nate.diller@gmail.com>
To: "JaniD++" <djani22@dynamicweb.hu>
Cc: <linux-kernel@vger.kernel.org>; <pavel@suse.cz>
Sent: Thursday, December 29, 2005 5:10 AM
Subject: Re: buffer cache question


> > ----- Original Message -----
> > From: Nate Diller
> > To: JaniD++
> > Cc: Roger Heflin ; linux-kernel@vger.kernel.org
> > Sent: Friday, December 23, 2005 9:58 AM
> > Subject: Re: buffer cache question
> >
> > looks like you're barely using any of your high memory.  maybe NBD
doesn't
> > have highmem support.  what file system are you using?
> >
> > NATE
> >
> >
> > I cannot understant this.
> > NBD need to support highmem for buffering?
> > If know right, the kernel does buffering, not NBD!
> > But the kernel only use ~830MB for buffer cache instead of dinamically
use
> > all free memory like page cache.
> >
> > This is one raw disk node, independent from file system.
> >
>
> this is an NBD client, using CONFIG_BLK_DEV_NBD?  on the 2.6 series
> kernel?  if so, then it, like any other kernel component using the
> page cache, needs to explicity use kmap/kunmap to make use of memory
> in the high memory zone.  on a 32 bit machine, any pages above the 896
> meg mark are treated specially inside the linux kernel (see
> http://kerneltrap.org/node/2450).

Yes, i have read this helpful document, but there is about the memory usage,
mapping, and not exactly the buffering/caching.
Yes, i use the 2.6 series NBD.

>
> if you don't have highmem support (CONFIG_HIGHMEM4G) enabled, then
> enabling that should fix it.  if you already have it enabled (it
> looked like it to me, based on your /proc/meminfo) then there is a bug
> somewhere.

Yes, it is enabled.

>
> it would seem from a brief inspection that the send/recv_bvec
> functions in nbd (2.6.13) do use kmap.  I don't know the nbd code very
> well, it seems that Pavel Machek wrote the code, he or block layer
> maintainer Jens Axboe may know something I don't.  So if enabling
> highmem in your .config doesn't help, try CC'ing them with your issue.
>  in the mean time, one of the memory split patches, such as the 4G:4G
> patch, should get things working.

The NBD use buffer cache (i am sure), but the highest limit is about
830-840M.

Where can i get the split patch?

Thanks for helpful answers!


Cheers,
Janos


>
> NATE

