Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312180AbSCRCxR>; Sun, 17 Mar 2002 21:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312181AbSCRCw6>; Sun, 17 Mar 2002 21:52:58 -0500
Received: from [203.162.56.202] ([203.162.56.202]:61171 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S312180AbSCRCwp>; Sun, 17 Mar 2002 21:52:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: Mike Fedyk <mfedyk@matchmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre3-ac1
Date: Mon, 18 Mar 2002 10:02:33 +0700
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020316190415.38CE14E534@mail.vnsecurity.net> <E16mLFj-000794-00@the-village.bc.nu> <20020317053624.GD23938@matchmail.com>
In-Reply-To: <20020317053624.GD23938@matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020318025233.A7C044E534@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 March 2002 12:36 pm, Mike Fedyk wrote:
> > So you have 128Mb of RAM, 64Mb of swap, and if all pages are touched you
> > would need 226Mb of swap + ram (minus kernel overhead). Looks like the
> > machine is hovering on the edge
>
> In Other Words (IOW), add more swap like everyone else said.
>
> The rmap design does use a bit more memory (about 400k for 128MB ram) for
> the reverse mapping tables, so that could push you over into an OOM case.
It seems that OOM killer doesn't work in 2.4.19-pre2-ac4 and 2.4.19-pre3-ac1.
I try to load alot of apps (KDE apps + JBuilder) as much as possible until
swap free = 0. At this time, if I try to load a big enough app (KDE Media in
my case), kernel should start OOM killer. But 2.4.19-pre-ac didn't, it try to
.... swap ;), kswapd runs like crazy (30%-40%CPU), disk access continuously,
and whole system is un-interractive => push restart button after 1 hour
waiting for OOM kill.

Behavior of some kernels in this case:
- 2.4.19-pre3: Start OOM killer to kill SOME java processes (JBuilder) before
KDE Media starts and continue to kill all re-spawned java processes. System
is slow down but still interactivable and back to normal status if close some
apps.
- 2.4.19-pre-aa: Start OOM killer to kill ALL java processes (JBuilder) or
kill KDE Media immediately. System is still interactivable.
- 2.4.19-pre-ac: kswapd try to swap out and access disk continuously. Whole
system is slow down and un-interactivable.

HTH,

MrChuoi
