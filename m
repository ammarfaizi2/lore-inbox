Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265082AbTFEUDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265089AbTFEUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:03:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19328 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265082AbTFEUD3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:03:29 -0400
Date: Thu, 5 Jun 2003 16:17:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk9 kick FAR out of the zlib
In-Reply-To: <20030605194644.GA22439@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.53.0306051607260.2391@chaos>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Jun 2003, [iso-8859-1] Jörn Engel wrote:

> A while back:
>
> On Fri, 30 May 2003 14:38:07 -0700, Linus Torvalds wrote:
> > On Fri, 30 May 2003, Jörn Engel wrote:
> > >
> > > How about an all or nothing approach?  If you really want to get rid
> > > of K&R, change indentation as well, rip out some of the rather
> > > tasteless macros (ZEXPORT, ZEXPORTVA, ZEXTERN, FAR, ...) and so on.
> >
> > I'd love to, but I suspect we lack the motivation to do so, and there
> > aren't any obvious upsides. Yes, the code is ugly, but it's also fairly
> > stable so people seldom need to look at it.
>
> Today was a lazy day and that is often motivation enough.  The patch
> below removes FAR, the typedefs using FAR (Bytef and friends) and the
> function prototypes for zalloc and zfree that should have gone earlier
> already.
>
> Hope you like it.
>
> Jörn

[SNIPPED patch]

But you just removed the portability hooks. The current code worked
in DOS, on Windows, etc., as will as Linux. This means that if some-
body, as unlikely as it may seem, develops a better/quicker
version using M$ Visual C/C++, you can't get a patch. In particular,
FAR is your friend. A simple #define makes it disappear when you
are not using a segmented architecture, but allows the use of
large arrays when you are.

These kinds of things don't make the code 'pure'. It just prevents
future enhancements. Look in the 'C' header files and see all the
macros that disappear under the right conditions. Would you
justify getting rid of __P in those headers? If not, please don't
eliminate FAR.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

