Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWEOXvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWEOXvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWEOXvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:51:11 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:38284 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750821AbWEOXvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:51:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images (rev. 2)
Date: Tue, 16 May 2006 09:50:19 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au
References: <200605021200.37424.rjw@sisk.pl> <200605151948.45345.kernel@kolivas.org> <200605152152.12194.rjw@sisk.pl>
In-Reply-To: <200605152152.12194.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605160950.19639.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 May 2006 05:52, Rafael J. Wysocki wrote:
> Hi,
>
> On Monday 15 May 2006 11:48, Con Kolivas wrote:
> > On Sunday 14 May 2006 08:33, Rafael J. Wysocki wrote:
> > > On Friday 12 May 2006 12:30, Pavel Machek wrote:
> > > > > Please also remember that you are introducing complexity in other
> > > > > ways, with that swap prefetching code and so on. Any comparison in
> > > > > speed should include the time to fault back in pages that have been
> > > > > discarded.
> > > >
> > > > Well, swap prefetching is useful for other workloads, too; so it gets
> > > > developed/tested outside swsusp.
> > >
> > > Still my experience indicates that it doesn't play very nice with
> > > swsusp and unfortunately it hogs the I/O.
> >
> > There is no swap prefetching code linked in any way to swsusp suspend or
> > resume on mainline or -mm. It was a preliminary experiment and Rafael
> > lost interest in it so I never bothered pursuing it.
>
> I'm referring to the code currently in -mm, where kprefetchd sometimes
> starts prefetching like mad after resume which hurts the disk I/O really
> badly (unless I set /proc/sys/vm/swap_prefetch to 0, that is).

Not my experience. It does lots of disk I/O after resume because as you say 
yourself there is heaps in swap, but I haven't seen that I/O hurt as it 
simply stops the instant I do anything with the machine even as trivial as 
moving the mouse.

> I think the problem is related to the fact that swsusp tends to leave quite
> a lot of pages in the swap, if they had to be swapped out before suspend,
> and that makes kprefetchd believe it should get these pages back into RAM,
> which usually is not the greatest idea.
>
> The above is only a speculation, however, and I'd have to investigate it a
> bit more to say something more certain.  Anyway, my experience indicates
> that it usually is better to set /proc/sys/vm/swap_prefetch to 0 after
> resume, but YMMV.

My mileage definitely varies here. I don't concentrate on examining the fact 
that the machine is doing any I/O, but how usable the machine is and it's my 
experience that it is much better as about 1/3 of my applications are not 
floundering entirely on swap. Fortunately there's a tunable there and it 
allows you to set and unset it how you see fit.

Anyway the original point of my response was to point out to Nigel that there 
is no added complexity on behalf of swsusp in the swap prefetch code.

-- 
-ck
