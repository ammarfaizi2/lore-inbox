Return-Path: <linux-kernel-owner+w=401wt.eu-S965370AbXATUTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965370AbXATUTv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbXATUTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:19:51 -0500
Received: from 1wt.eu ([62.212.114.60]:2091 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965373AbXATUTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:19:51 -0500
Date: Sat, 20 Jan 2007 21:19:23 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120201923.GC25307@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr> <200701201952.54714.ismail@pardus.org.tr> <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de> <200701202216.16637.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701202216.16637.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 10:16:15PM +0200, Ismail Dönmez wrote:
> 20 Oca 2007 Cts 22:10 tarihinde, Tim Schmielau ??unlar?? yazm????t??: 
> [...]
> >
> > Note that these dd "benchmarks" are completely bogus, because the data=20
> > doesn't actually get written to disk in that time. For some enlightening=20
> > data, try
> >
> >   time dd if=3D/dev/zero of=3D/tmp/1GB bs=3D1M count=3D1024; time sync
> >
> > The dd returns as soon as all data could be buffered in RAM. Only sync=20
> > will show how long it takes to actually write out the data to disk.
> > also explains why you see better results is writeout starts earlier.
> 
> Still not that bad:
> 
> [~]> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024;sync
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1,1 GB) copied, 53,3194 s, 20,1 MB/s
> 
> real    0m53.517s
> user    0m0.003s
> sys     0m3.193s

No, your measure is wrong because time measures "dd" and sync is done
after. Either use Tim's method (time sync) or the one I proposed in
previous mail (time dd | sync). Anyway, in your situation with a very
small buffer, this should not change by more than half a second or so.

Willy

