Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319805AbSIMVs0>; Fri, 13 Sep 2002 17:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319806AbSIMVs0>; Fri, 13 Sep 2002 17:48:26 -0400
Received: from packet.digeo.com ([12.110.80.53]:33257 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319805AbSIMVsZ>;
	Fri, 13 Sep 2002 17:48:25 -0400
Message-ID: <3D825E43.FDB41C7F@digeo.com>
Date: Fri, 13 Sep 2002 14:53:07 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
References: <20020913212921.GA17627@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.44L.0209131830560.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 21:53:12.0158 (UTC) FILETIME=[F483EFE0:01C25B6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Fri, 13 Sep 2002, Pavel Machek wrote:
> 
> > Allocating memory is pain because I have to free it afterwards. Yep I
> > have such code, but it is ugly. try_to_free_pages() really seems like
> > cleaner solution to me... if you only tell me how to fix it :-).
> 
> "Fixing" the VM just so it behaves the way swsuspend wants is
> out. If swsuspend relies on all other subsystems playing nicely,
> I think it should be removed from the kernel.
> 

Yup.  Martin Bligh is cooking up a multi-page allocation API, so when that's
in place, swsusp need only do:

	LIST_HEAD(foo);
	alloc_many_pages(&foo, nr_pages, __GFP_HIGHMEM|__GFP_WAIT);
	free_many_pages(&foo);

So I suggest you do something local for the while, plan to use that later.

(Actually, the implementation would probably have a heart attack if you
asked for 100,000 pages so you may need to sit in a loop there; we'll see).
