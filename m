Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUKZV3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUKZV3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264004AbUKZVWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 16:22:50 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50854 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S264081AbUKZUS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:18:58 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: hugang@soulinfo.com
Cc: Pavel Machek <pavel@ucw.cz>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041126043203.GA2713@hugang.soulinfo.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams>
	 <20041126003944.GR2711@elf.ucw.cz>
	 <20041126043203.GA2713@hugang.soulinfo.com>
Content-Type: text/plain
Message-Id: <1101456577.4343.121.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 26 Nov 2004 20:08:40 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-11-26 at 15:32, hugang@soulinfo.com wrote:
> > For swsusp2, you need drivers to stop the DMA, NMI not interfering,
> > sync may not happen after you have saved LRU, memory may not be
> > alocated from slab after you have saved LRU. (something else? This
> > needs to be written down somewhere, and all kernel hackers will need
> > to be carefull not to break these rules. Do you see why it wories me?)
> Ok, I got it.  I think making LRU safe must sure 
>  1: LRU can't change after saved.
>  2: LRU memory can't change after saved.
> The first one is done, the second we can't sure in current design, can
> we using COW do it?

2 is simple: LRU doesn't change because everything that would change it
is frozen, and the memory pool hooks ensure that scanning of the list
doesn't happen while suspending either.

I don't see the point to saving LRU pages separately when you're still
eating all the memory you can. You'll have the same number of pages to
save, just fewer to copy (and copying takes far less time than saving).

> Pagecaches still in, but disable by default, active using sysctl, 
> I'd like not merge it right now, Hope other chagnes can merge into. :)

Pavel's going to think you are trying to turn swsusp into suspend2!!

Nigel 
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

