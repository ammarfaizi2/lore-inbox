Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266943AbSKPAJu>; Fri, 15 Nov 2002 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbSKPAJt>; Fri, 15 Nov 2002 19:09:49 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3089 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266943AbSKPAJt>; Fri, 15 Nov 2002 19:09:49 -0500
Date: Sat, 16 Nov 2002 01:16:41 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE TCQ
Message-ID: <20021116001641.GD26188@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <71EE24368CCFB940A79BD7002F14D760409348@exchange.uns.t-systems.tss> <20021113113940.GE832@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113113940.GE832@suse.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Jens Axboe wrote:

> > Second set of questions: Does it do any good to one-channel-one-disk
> > setups?  Is it supposed to do good to access time, operations/sec,
> > throughput, random reqs rearrangement or what?  Do you have any
> > figures how much TCQ helps performace (e.g. in file serving case)?
> 
> Yes it will help any setup. Due to way ide tcq works, it's recommended
> only to use tcq on one drive on a channel right now. This may change in
> the future.

Would be "it's recommended to use only one drive on a channel for best
results, whether with or without TCQ" more accurate? Or are there
reasons that make TCQ <-> slave interactions particularly bad that don't
show up without TCQ?

> I don't have any general numbers. I did some benchmarking when I first
> implemented it, and it typically shows (as with scsi drives) that having
> just enough tags to keep the disk busy helps a bit. The linux io
> scheduler does the rest. For random reads, 10-30% speed increase was
> observed.

Did you perchance benchmark the impact TCQ has on sequential writes when
the write cache is turned off?

Turning off the write cache without TCQ has a severe impact (30 to 70%
on my "stupid dd" tests) in my computer (VIA82C686, but I don't recall
which drive I did this on, it was either of IBM DJNA, DTLA or Maxtor
4W060H4)
