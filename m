Return-Path: <linux-kernel-owner+w=401wt.eu-S965364AbXATUFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbXATUFp (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbXATUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:05:45 -0500
Received: from 1wt.eu ([62.212.114.60]:2084 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965364AbXATUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:05:44 -0500
Date: Sat, 20 Jan 2007 21:05:15 +0100
From: Willy Tarreau <w@1wt.eu>
To: Sunil Naidu <akula2.shark@gmail.com>
Cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120200515.GA25307@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu> <200701201952.54714.ismail@pardus.org.tr> <20070120180344.GA23841@1wt.eu> <8355959a0701201144x290362d8ja6cd5bc1408475da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8355959a0701201144x290362d8ja6cd5bc1408475da@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2007 at 01:14:41AM +0530, Sunil Naidu wrote:
> On 1/20/07, Willy Tarreau <w@1wt.eu> wrote:
> >> > >
> >
> >It is not expected to increase write performance, but it should help
> >you do something else during that time, or also give more responsiveness
> >to Ctrl-C. It is possible that you have fast and slow RAM, or that your
> >video card uses shared memory which slows down some parts of memory
> >which are not used anymore with those parameters.
> 
> I did test some SATA drives, am getting these value for 2.6.20-rc5:-
> 
> [sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB) copied, 21.0962 seconds, 50.9 MB/s
> 
> What can you suggest here w.r.t my RAM & disk?

I don't suggest anything, this is already very good. The only goal of
reducing memory write cache is to get a more responsive system when
dumping massive amounts of data to disks, like above, because when
the system starts flushing the caches, you can only wait for it to
finish. But those tests are not realistic loads. A desktop and most
servers will benefit from large caches. But *some* workloads will
benefit from smaller caches if they consist in writing continuous
streams (eg: tcpdump or video recorders). What I suggested to the
user above was a way to get the system more responsive during his
test. It should not have changed the throughput at all if the
hardware was not a bit strange (well, it's a VAIO after all, I've
had one too, fortunately it died one month after the warranty,
putting an end to all my problems...).

Regards,
Willy

