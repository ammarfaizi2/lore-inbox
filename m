Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312181AbSCRDBG>; Sun, 17 Mar 2002 22:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312182AbSCRDA6>; Sun, 17 Mar 2002 22:00:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:23036
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312181AbSCRDAq>; Sun, 17 Mar 2002 22:00:46 -0500
Date: Sun, 17 Mar 2002 19:01:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: MrChuoi <MrChuoi@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Linux 2.4.19-pre3-ac1
Message-ID: <20020318030145.GB2254@matchmail.com>
Mail-Followup-To: MrChuoi <MrChuoi@yahoo.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <20020316190415.38CE14E534@mail.vnsecurity.net> <E16mLFj-000794-00@the-village.bc.nu> <20020317053624.GD23938@matchmail.com> <20020318025233.A7C044E534@mail.vnsecurity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020318025233.A7C044E534@mail.vnsecurity.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 10:02:33AM +0700, MrChuoi wrote:
> On Sunday 17 March 2002 12:36 pm, Mike Fedyk wrote:
> > > So you have 128Mb of RAM, 64Mb of swap, and if all pages are touched you
> > > would need 226Mb of swap + ram (minus kernel overhead). Looks like the
> > > machine is hovering on the edge
> >
> > In Other Words (IOW), add more swap like everyone else said.
> >
> > The rmap design does use a bit more memory (about 400k for 128MB ram) for
> > the reverse mapping tables, so that could push you over into an OOM case.
> It seems that OOM killer doesn't work in 2.4.19-pre2-ac4 and 2.4.19-pre3-ac1.
> I try to load alot of apps (KDE apps + JBuilder) as much as possible until
> swap free = 0. At this time, if I try to load a big enough app (KDE Media in
> my case), kernel should start OOM killer. But 2.4.19-pre-ac didn't, it try to
> .... swap ;), kswapd runs like crazy (30%-40%CPU), disk access continuously,
> and whole system is un-interractive => push restart button after 1 hour
> waiting for OOM kill.
> 
> Behavior of some kernels in this case:
> - 2.4.19-pre3: Start OOM killer to kill SOME java processes (JBuilder) before
> KDE Media starts and continue to kill all re-spawned java processes. System
> is slow down but still interactivable and back to normal status if close some
> apps.
> - 2.4.19-pre-aa: Start OOM killer to kill ALL java processes (JBuilder) or
> kill KDE Media immediately. System is still interactivable.
> - 2.4.19-pre-ac: kswapd try to swap out and access disk continuously. Whole
> system is slow down and un-interactivable.
> 

Can you reproduce with just rmap12h from http://www.surriel.com/patches/ on
top of 2.4.18?

Rik, can you confirm that OOM kill should work with rmap12 (the rmap VM is in -ac...)?
