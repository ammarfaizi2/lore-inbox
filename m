Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSFKPpK>; Tue, 11 Jun 2002 11:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317142AbSFKPpJ>; Tue, 11 Jun 2002 11:45:09 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:44266 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317141AbSFKPpJ> convert rfc822-to-8bit; Tue, 11 Jun 2002 11:45:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: David Brownell <david-b@pacbell.net>, "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 17:44:55 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D058B41.6010601@pacbell.net> <20020610.224401.13280464.davem@redhat.com> <3D061363.70500@pacbell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206111744.56026.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 11. Juni 2002 17:12 schrieb David Brownell:
> >    One question is whether to support only one of them, or allow both.
> >    In either case the DMA-mapping.txt will need to touch on the issue.
> >
> > Another important issue is from where do these issues originate?
> >
> > This stuff rarely happens most of the time because block buffers and
> > networking buffers are what are fed to the chip.
>
> I think the examples Oliver found related mostly to device control
> and status tracking.

I did not look for others. It would seem that SCSI and networking are
affected as well. SCSI due to the sense buffer.

> Or then there's David Woodhouse's option (disable caching on those
> pages while the DMA mapping is active) which seems good, except for
> the fact that this issue is most common for buffers that are a lot
> smaller than one page ... so lots of otherwise cacheable data would
> suddenly get very slow. :)

There might be several buffers in one page. You'd have to count
DMA users in struct page.
Secondly are you sure that a physical page won't be accessed
by several different virtual addresses ? On some architectures
that would kill us.

	Regards
		Oliver

