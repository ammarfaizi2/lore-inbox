Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVK3MAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVK3MAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 07:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVK3MAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 07:00:06 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:7263 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751168AbVK3MAE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 07:00:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/b++Rjp9KN6qThAaIqMcJZGJWWcuylT2X5ZRPgPFyZCKwxNXlyS8cAwfh8S3OsbZ/G9MHYt40saEyaDOmJ1cGsUdGSRaCVLo9qLtyIQRFPTpos+rO3hPdmBr97PXdB8d+whhF121B/eRrFWnnQrZ9Lnidmv6f3+RGXuaeaatBs=
Message-ID: <9a8748490511300400q4cf2d6bes511b3b6bf4671d63@mail.gmail.com>
Date: Wed, 30 Nov 2005 13:00:03 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>
Subject: Re: [BUG] 2.6.15-rc1, soft lockup detected while probing IDE devices on AMD7441
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051130105952.GA14641@shurick.s2s.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051120204656.GA17242@shurick.s2s.msu.ru>
	 <20051120172915.31754054.akpm@osdl.org>
	 <1132605524.11842.38.camel@localhost.localdomain>
	 <200511232017.52788.jesper.juhl@gmail.com>
	 <20051130105952.GA14641@shurick.s2s.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/05, Alexander V. Inyukhin <shurick@sectorb.msk.ru> wrote:
> On Wed, Nov 23, 2005 at 08:17:51PM +0100, Jesper Juhl wrote:
> > On Monday 21 November 2005 21:38, Alan Cox wrote:
> > > On Sul, 2005-11-20 at 17:29 -0800, Andrew Morton wrote:
> > > > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > > > Quite normal. The old IDE probe code takes a long time and it makes the
> > > > > soft lockup code believe a lockup occurred - rememeber its a debugging
> > > > > tool not a 100% reliable detector of failures.
> > > >
> > > > We could put a touch_softlockup_watchdog() in there.
> > >
> > > Would make sense. Spin up and probe can take over 30 seconds worst case
> > > and is polled in the IDE world. The loop will eventually exit and a true
> > > lockup caused by a stuck IORDY line will hang forever in an inb/outb so
> > > neither softlockup or even nmi lockup would save you.
> >
> > How about something like the patch below?
> >
> > The  if (!(timeout % 128))  bit is a guess that since
> > touch_softlockup_watchdog() is a per_cpu thing it will be cheaper to do the
> > modulo calculation than calling the function every time through the loop,
> > especially as the nr of CPU's go up. But it's purely a guess, so I may very
> > well be wrong - also, 128 is an arbitrarily chosen value, it's just a nice
> > number that'll give us <10 function calls pr second.
>
> It seems to work.
> I have no BUG messages during boot with this patch.
>
Great.
Thank you for testing.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
