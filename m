Return-Path: <linux-kernel-owner+w=401wt.eu-S965392AbXATWAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbXATWAs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 17:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965401AbXATWAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 17:00:48 -0500
Received: from [139.30.44.16] ([139.30.44.16]:3994 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965392AbXATWAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 17:00:47 -0500
Date: Sat, 20 Jan 2007 23:00:46 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Sunil Naidu <akula2.shark@gmail.com>
cc: =?UTF-8?Q?Ismail_D=C3=B6nm?= <ismail@pardus.org.tr>,
       Willy Tarreau <w@1wt.eu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal disk performance, how to debug?
In-Reply-To: <8355959a0701201312r9a3aac4ufd151ca18ef7e64e@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0701202252550.24255@gockel.physik3.uni-rostock.de>
References: <200701201920.54620.ismail@pardus.org.tr>  <20070120174503.GZ24090@1wt.eu>
  <200701201952.54714.ismail@pardus.org.tr> 
 <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
 <8355959a0701201312r9a3aac4ufd151ca18ef7e64e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007, Sunil Naidu wrote:

> On 1/21/07, Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> >
> > Note that these dd "benchmarks" are completely bogus, because the data
> > doesn't actually get written to disk in that time. For some enlightening
> > data, try
> >
> >   time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time sync
> >
> > The dd returns as soon as all data could be buffered in RAM. Only sync
> > will show how long it takes to actually write out the data to disk.
> > also explains why you see better results is writeout starts earlier.
> 
> I am still getting better I feel:

Yes. You have a faster Disk that writes about 45 MB/s. But I am not sure I 
understand what you want to know?

> [sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time
> sync
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB) copied, 19.5007 seconds, 55.1 MB/s
> 
> real    0m20.439s
> user    0m0.004s
> sys     0m4.535s
> 
> real    0m4.625s
> user    0m0.000s
> sys     0m0.125s
> 
> 
> [sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB) copied, 20.8707 seconds, 51.4 MB/s
> 
> real    0m22.449s
> user    0m0.002s
> sys     0m4.922s
> 
> 
> Linux used here is not 2.6.20-rc5, but it's a FC6 2.6.19 binary. Shall
> post the results with 2.6.20-rc5.
> 
> BTW, does the results vary with a customized kernel (configured w.r.t
> Processor & Hardware) than a generic kernel like FC6?

I'd guess the kernel won't make much of a difference as the time is 
mostly determined by RAM and disk speeds.

> Are there any other such test cases?

Well, what do you want to find out? Anyways, I am in no way expert in the 
field of benchmarking.


Note to Willy:
I finally noticed my logic actually was not flawed. I stated why dd would 
report approximately doubled throughputs with buffering, while you argued 
why the total elapsed time would not change much.

Time to go to bed now...

Tim
