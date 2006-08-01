Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWHABZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWHABZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 21:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHABZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 21:25:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:54299 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751471AbWHABZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 21:25:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=py+nRyFAUMk/DjlpgFSwOeW9G/nuGhHrSIpahW/Dp/5ikyppTbGi5Jis50II6jEnkyMlSCAh5rRuasbNr89hsodyzssS+rMge9mc/pic+3TzDhn9BT9PsnFyzS2mdwPs8LyiatoCNXzArI8ubkkAQMccdYFXjb78U/IveMT+J/s=
Message-ID: <5c49b0ed0607311825p6341b19eq9108f0a9225ae831@mail.gmail.com>
Date: Mon, 31 Jul 2006 18:25:24 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Nate Diller" <nate.diller@gmail.com>,
       "David Lang" <dlang@digitalinsight.com>,
       "Adrian Ulrich" <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Cc: "Matthias Andree" <matthias.andree@gmx.de>
In-Reply-To: <20060801010215.GA24946@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <200607311918.k6VJIqTN011066@laptop13.inf.utfsm.cl>
	 <20060731225734.ecf5eb4d.reiser4@blinkenlights.ch>
	 <44CE7C31.5090402@gmx.de>
	 <5c49b0ed0607311621i54f1c46fh9137f8955c9ea4be@mail.gmail.com>
	 <Pine.LNX.4.63.0607311621360.14674@qynat.qvtvafvgr.pbz>
	 <5c49b0ed0607311650j4b86d0c3h853578f58db16140@mail.gmail.com>
	 <Pine.LNX.4.63.0607311651410.14674@qynat.qvtvafvgr.pbz>
	 <5c49b0ed0607311705t1eb8fc6bs9a68a43059bfa91a@mail.gmail.com>
	 <20060801010215.GA24946@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Matthias Andree <matthias.andree@gmx.de> wrote:
> On Mon, 31 Jul 2006, Nate Diller wrote:
>
> > this is only a limitation for filesystems which do in-place data and
> > metadata updates.  this is why i mentioned the similarities to log
> > file systems (see rosenblum and ousterhout, 1991).  they observed an
> > order-of-magnitude increase in performance for such workloads on their
> > system.
>
> It's well known that transactions that would thrash on UFS or ext2fs may
> have quieter access patterns with shorter strokes can benefit from
> logging, data journaling, whatever else turns seeks into serial writes.
> And then, the other question with wandering logs (to avoid double
> writes) and such, you start wondering how much fragmentation you get as
> the price to pay for avoiding seeks and double writes at the same time.
> TANSTAAFL, or how long the system can sustain such access patterns,
> particularly if it gets under memory pressure and must move. Even with
> lazy allocation and other optimizations, I question the validity of
> 3000/s or faster transaction frequencies. Even the 500 on ext3 are
> suspect, particularly with 7200/min (s)ATA crap. This sounds pretty much
> like the drive doing its best to shuffle blocks around in its 8 MB cache
> and lazily writing back.

it's not my benchmark, and you are right to be interested in more
information.  I would be curious about such things as write barrier
support, average/min/max transaction latency, and number of individual
threads, as well as hardware specs.  i also suspect that the numbers
would be altered a bit by testing with different I/O schedulers.
unfortunately, namesys has considered mongo a replacement for
postmark, so i cannot point to any more rigorous postmark tests ATM.

however, the results seem consistent with what i would expect for the
various file systems, with a significant number of threads.  after
all, even ext3 has the benefit of a disk scheduler, especially if
barriers are disabled

NATE
