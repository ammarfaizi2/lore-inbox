Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269035AbUHMI71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269035AbUHMI71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 04:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUHMI71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 04:59:27 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:27866 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S269035AbUHMI7Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 04:59:25 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: linux-kernel@vger.kernel.org
Subject: Re: excessive swapping
Date: Fri, 13 Aug 2004 02:00:02 -0700
User-Agent: KMail/1.7
References: <1092379250.2597.14.camel@rivendell.home.local> <1092379468.2597.16.camel@rivendell.home.local> <1092381036.2597.29.camel@rivendell.home.local>
In-Reply-To: <1092381036.2597.29.camel@rivendell.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408130200.02828.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you try using Nick Piggin's np patchset ? 

Matt H.

On Friday 13 August 2004 12:10 am, Florin Andrei wrote:
> On Thu, 2004-08-12 at 23:44, Florin Andrei wrote:
> > On Thu, 2004-08-12 at 23:40, Florin Andrei wrote:
> > > The system is swapping excessively. There's no way the total size of
> > > the applications exceeds the size of RAM. There's plenty of room to
> > > spare, yet 16% of the 530MB of swap is used.
> >
> > Now it's 22% and counting. Way to go. :-(
>
> Now it's 27%. You get the picture.
>
> Anyway, out of the 512MB of RAM, like 390MB are disk cache. No wonder
> that the useful pages are swaped out.
>
> It seems like the kernel believes that the disk cache has some
> miraculous properties w.r.t. the system performance, and desperately
> tries to grow it as much as possible.
> This is wrong religion. The reality is opposite. The system is much
> slower, because applications are thrown out in the swap, then sucked
> back in, which is a very slow process.
>
> The efficiency of increasing the disk cache decreases exponentially with
> size, like any other cache. Then what's the point of sacrificing useful
> memory just to increase some hypothetical "useful" cache?
>
> Even on a server, the same universal laws still apply, the efficiency of
> increasing cache still decreases exponentially. There's still precious
> time wasted when an application is sucked back in from swap, at the
> price of an immeasurably small performance gain due to the disk cache
> being larger.
>
> I'm sorry for rambling, but to me the current swapping policy is so
> blatantly wrong. Besides the space occupied by the apps themselves,
> there's a lot of room to _spare_ - then why swap?
