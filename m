Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUC3B4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUC3B4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:56:45 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:36484 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263483AbUC3B4m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:56:42 -0500
Subject: Re: [patch] silence nfs mount messages
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040330013300.GC17179@apps.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl>
	 <1080587480.2410.61.camel@lade.trondhjem.org>
	 <20040329195435.GA19426@apps.cwi.nl>
	 <1080602653.2410.192.camel@lade.trondhjem.org>
	 <20040329234643.GB17179@apps.cwi.nl>
	 <1080606053.2410.260.camel@lade.trondhjem.org>
	 <20040330013300.GC17179@apps.cwi.nl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1080611809.2410.347.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 20:56:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 29/03/2004 klokka 20:33, skreiv Andries Brouwer:
> On Mon, Mar 29, 2004 at 07:20:53PM -0500, Trond Myklebust wrote:
> 
> > The changes you are complaining about have *NOTHING* whatsoever to do
> 
> Wait. It seems you think I am complaining about changes. I am not.
> 
> I am complaining about kernel messages.
> They have been there since 0.99. Hardly changes, but they are annoying.
> Mount has to go through all kinds of contortions to avoid these messages.
> Has an explicit list of kernel versions built-in.
> Yecch.

Yecch is indeed appropriate, and I agree that this is bad. I really
regret not having created the "nfs3" filesystem all those years ago.
That would have made much of this compatibility argument mute.

I do have plans to fix this for 2.7. In particular I'd like to drop
support for "nfs", and separate it into "nfs2" and "nfs3", so that we
can have mount make sensible choices about what the server does or does
not support.
That should also allow us to modularize NFS a bit more in order to allow
people to drop v2 support (for instance) if they don't want to use it.

> These messages should have been silenced ten years ago.
> People complain.

They are supposed to. If they are seeing those messages, then they are
not up to date w.r.t. the binary interfaces.

Now if you can assure me that "util-linux" and all other programs that
use the mount interface can handle the EINVAL error, then fine: send me
the patch.
Otherwise, I see no alternative to the current situation: a silent
attempt to comply with a binary interface that the kernel does not
understand is clearly the wrong thing to do.

Cheers,
  Trond
