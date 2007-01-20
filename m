Return-Path: <linux-kernel-owner+w=401wt.eu-S965362AbXATUj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965362AbXATUj1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbXATUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:39:27 -0500
Received: from [139.30.44.16] ([139.30.44.16]:3059 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965362AbXATUj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:39:26 -0500
Date: Sat, 20 Jan 2007 21:39:25 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Willy Tarreau <w@1wt.eu>
cc: =?UTF-8?Q?Ismail_D=C3=B6nm?= <ismail@pardus.org.tr>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal disk performance, how to debug?
In-Reply-To: <20070120202821.GD25307@1wt.eu>
Message-ID: <Pine.LNX.4.63.0701202135380.23938@gockel.physik3.uni-rostock.de>
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu>
 <200701201952.54714.ismail@pardus.org.tr>
 <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
 <20070120202821.GD25307@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007, Willy Tarreau wrote:
> On Sat, Jan 20, 2007 at 09:10:22PM +0100, Tim Schmielau wrote:
> > 
> > Note that these dd "benchmarks" are completely bogus, because the data 
> > doesn't actually get written to disk in that time. For some enlightening 
> > data, try
> > 
> >   time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time sync
> > 
> > The dd returns as soon as all data could be buffered in RAM. Only sync 
> > will show how long it takes to actually write out the data to disk.
> 
> While I 100% agree with you on this, I'd like to note that I don't agree
> with the following statement :
> 
> > also explains why you see better results is writeout starts earlier.
> 
> The results should be better when writeout starts later since most of
> the transfer will have been performed at RAM speed. That's what happens
> with the user above with 2 GB RAM. But in case of the VAIO with 512 MB,
> there's really something strange IMHO. I suspect it has two RAM areas,
> one fast and one slow (probably one two large non-cacheable area for a
> shared video or such a crap, which can be avoided when reducing the
> cache size).

No - the earlier the writeout starts, the earlier he will have enough free 
RAM to finish the dd command by buffering the remaining data.

Note that we did not cap the amount of buffers, just started to write out 
earlier.

Tim
