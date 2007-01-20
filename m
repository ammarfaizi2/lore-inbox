Return-Path: <linux-kernel-owner+w=401wt.eu-S965367AbXATUJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965367AbXATUJt (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965368AbXATUJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:09:48 -0500
Received: from 1wt.eu ([62.212.114.60]:2088 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965367AbXATUJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:09:47 -0500
Date: Sat, 20 Jan 2007 21:09:17 +0100
From: Willy Tarreau <w@1wt.eu>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Sunil Naidu <akula2.shark@gmail.com>,
       Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120200916.GB25307@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu> <200701201952.54714.ismail@pardus.org.tr> <20070120180344.GA23841@1wt.eu> <8355959a0701201144x290362d8ja6cd5bc1408475da@mail.gmail.com> <45B273E4.8040302@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B273E4.8040302@seclark.us>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2007 at 02:56:20PM -0500, Stephen Clark wrote:
> Sunil Naidu wrote:
> 
> >On 1/20/07, Willy Tarreau <w@1wt.eu> wrote:
> > 
> >
> >>It is not expected to increase write performance, but it should help
> >>you do something else during that time, or also give more responsiveness
> >>to Ctrl-C. It is possible that you have fast and slow RAM, or that your
> >>video card uses shared memory which slows down some parts of memory
> >>which are not used anymore with those parameters.
> >>   
> >>
> >
> >I did test some SATA drives, am getting these value for 2.6.20-rc5:-
> >
> >[sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> >1024+0 records in
> >1024+0 records out
> >1073741824 bytes (1.1 GB) copied, 21.0962 seconds, 50.9 MB/s
> >
> >What can you suggest here w.r.t my RAM & disk?
> >
> > 
> >
> >>Willy
> >>   
> >>
> >
> >Thanks,
> >
> >~Akula2
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> > 
> >
> Hi,
> whitebook vbi s96f core 2 duo t5600 2gb hitachi ATA      HTS721060G9AT00 
> using libata
> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB) copied, 10.0092 seconds, 107 MB/s
> 
> real    0m10.196s
> user    0m0.004s
> sys     0m3.440s

You have too much RAM, it's possible that writes did not complete before
the end of your measurement. Try this instead :

$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync

Willy

