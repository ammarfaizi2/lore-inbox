Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSJOUDG>; Tue, 15 Oct 2002 16:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264731AbSJOUDG>; Tue, 15 Oct 2002 16:03:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44049 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264729AbSJOUDF>; Tue, 15 Oct 2002 16:03:05 -0400
Date: Tue, 15 Oct 2002 22:11:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@suse.cz>, Hu Gang <hugang@soulinfo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: patch for 2.5.42. 2/2
Message-ID: <20021015201104.GE19330@atrey.karlin.mff.cuni.cz>
References: <20021014185202.C585@elf.ucw.cz> <Pine.LNX.4.44L.0210151208300.1648-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210151208300.1648-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > better to just have the network layer stop operations when the
> > > system is going into suspend, instead of having to modify 100
> > > individual network drivers ?
> >
> > Whole userland is stopped at that point. That should mean that new
> > requests can not come.
> >
> > OTOH packet from the network *can* come, and higher levels can not do
> > much with that.
> 
> Higher layers can throw away the packet.  This means you just
> need to modify the higher layer at one or two places, instead
> of needing to modify every single network driver out there.
> 
> I don't need to tell you which of these two options is gonna
> be the easiest to maintain, do I ?

No, that one is simple.

What is not so simple is seeing that throwing that packet away is not
enough. Receiving packet means DMA, and DMA is no-no during S4
resume. So simply throwing packet away is not enough.

						Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
