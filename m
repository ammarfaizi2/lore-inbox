Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWJRMz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWJRMz6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 08:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWJRMz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 08:55:58 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:55722 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030224AbWJRMz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 08:55:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WLdPKdbOrWuV6cLzLun6+AynewzKaNIvYOe46/8XkuCDQ/J1HlYlWKCq1r8qM9kLPqvLRtgbgitqUxZn97nHvy8kFzylu9MlBGN9FL3jHX+elnCGMWmgV5gI1Wpb2CgEgJTvuZKJelpwDQGUnQniYk8V++lqJXY9cNwscT70UB4=  ;
Message-ID: <4536245B.8070906@yahoo.com.au>
Date: Wed, 18 Oct 2006 22:55:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com> <1161048269.3245.26.camel@laptopd505.fenrus.org> <20061017132312.GD7854@kernel.dk> <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain> <20061018124420.GI24452@kernel.dk>
In-Reply-To: <20061018124420.GI24452@kernel.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Oct 18 2006, Alan Cox wrote:
> 
>>Bandwidth is completely silly in this context, iops/sec is merely
>>hopeless 8)
> 
> 
> Both need the disk to play nicely, if you get into error handling or
> correction, you get screwed. Bandwidth by itself is meaningless, you
> need latency as well to make sense of it.

When writing an IO scheduler, I decided `time' was a pretty good
metric. That's roughly what we use for CPU scheduling as well (but
use nice levels and adjusted by dynamic priorities instead of a
straight % share).

So you could say you want your database to consume no more than 50%
of disk and have your mp3 player get a minimum of 10%. Of course,
that doesn't say anything about what the time slices are, or what
latencies you can expect (1s out of every 10, or 100ms out of every
1000?).

It is still far from perfect, but at least it accounts for seeks vs
throughput reasonably well, and in a device independent manner.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
