Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbWA0Uid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbWA0Uid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWA0Uid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:38:33 -0500
Received: from [85.8.13.51] ([85.8.13.51]:38617 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1161013AbWA0Uic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:38:32 -0500
Message-ID: <43DA84B2.8010501@drzeus.cx>
Date: Fri, 27 Jan 2006 21:38:10 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de> <20060127202646.GC2767@flint.arm.linux.org.uk>
In-Reply-To: <20060127202646.GC2767@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Jan 27, 2006 at 09:22:06PM +0100, Jens Axboe wrote:
>   
>> That is definitely valid, same goes for the bio_vec structure. They map
>> _a_ page, after all :-)
>>     
>
> Okay.  Pierre - are you saying that you have an sg entry where
> sg->offset + sg->length > PAGE_SIZE, and hence is causing you to
> cross a page boundary?
>
>   

That, and sg->length > PAGE_SIZE. On highmem systems this causes all
kinds of funky behaviour. Usually just bogus data in the buffers though.

> (Sorry, your initial mail got lost because I've tend to be over-eager
> these days with the D key with lkml over the last week or so - I've
> not been around much.)
>
>   

The background wasn't really detailed on LKML anyway. The background was
that I got several reports of very strange behaviour, all from people
running highmem systems. When debug messages were added, printing the sg
structure entries, we discovered that the problems seemed to occur when
we were crossing pages.

You can find the thread here if you feel like a lot of reading: :)

http://list.drzeus.cx/pipermail/sdhci-devel/2006-January/000301.html

Rgds
Pierre

