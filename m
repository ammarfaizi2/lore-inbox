Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267170AbSKMLdH>; Wed, 13 Nov 2002 06:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267172AbSKMLdH>; Wed, 13 Nov 2002 06:33:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:27346 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267170AbSKMLdG>;
	Wed, 13 Nov 2002 06:33:06 -0500
Date: Wed, 13 Nov 2002 12:39:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Sasi =?iso-8859-1?Q?P=E9ter?= <Peter.Sasi@t-systems.co.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE TCQ
Message-ID: <20021113113940.GE832@suse.de>
References: <71EE24368CCFB940A79BD7002F14D760409348@exchange.uns.t-systems.tss>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71EE24368CCFB940A79BD7002F14D760409348@exchange.uns.t-systems.tss>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12 2002, Sasi Péter wrote:
> Dear Jens,
> 
> I would like to ask a few simple question: what does it take to make use of this nifty feature?
> 
> My example: I have a box with an ABIT BH6 mainboard (Intel chipset,
> 2xUATA33 channels), A Leadtek WinFast CMD648 with 2xUATA66 channels,
> and a Promise Ultra100 TX2 2xUATA100.  I have 3x IBM GXP120 120GB
> UATA100 IDE HDDs (have read you write these to be capable of TCQ).
> 
> First set of questions: On which of the three different IDE
> controllers are the disks supposed to be doing TCQ?

They should all work

> Is it limited to UATA100 and up?  Is it limited to specific chipsets?
> Maybe a combination of these two?

No

> Is there any list of the disks that support TCQ?  Or does that come
> compulsory with eg. UATA100?

The list in the help section for ide tcq is pretty much complete.
Genereally, IBM deskstar drives support tcq and that's about it.

> Second set of questions: Does it do any good to one-channel-one-disk
> setups?  Is it supposed to do good to access time, operations/sec,
> throughput, random reqs rearrangement or what?  Do you have any
> figures how much TCQ helps performace (e.g. in file serving case)?

Yes it will help any setup. Due to way ide tcq works, it's recommended
only to use tcq on one drive on a channel right now. This may change in
the future.

I don't have any general numbers. I did some benchmarking when I first
implemented it, and it typically shows (as with scsi drives) that having
just enough tags to keep the disk busy helps a bit. The linux io
scheduler does the rest. For random reads, 10-30% speed increase was
observed.

> Now I see I piled up quite a few questions. Maybe it is more polite to
> ask you if you can recommend any reading on the topic on the web
> first?

TCQ itself is described in the ata standards, but that's just a
technical description of how to use it from a driver. For general ide
tcq discussions, you probably want to search on google for instance.

> Maybe I should rather be asking Andre Hedrick about the internals of
> TCQ?

You could, I should know a bit about it too though :-)

-- 
Jens Axboe

